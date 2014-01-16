" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------

set nocompatible                " Don't sacrifice anything for Vi compatibility
set history=1000                " Keep some stuff in the history
set ffs=unix,dos,mac            " Support these files
set isk+=_,$,@,%,#,-            " None word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                    " Make sure modeline support is enabled
set autoread                    " Reload the files if they changed on disk
set tabpagemax=50               " Open 50 tabs max
set encoding=utf-8              " Always use UTF-8 by default
set timeoutlen=500              " Timeout between key command combos

" Pathogen
execute pathogen#infect()

" ----------------------------------------------------------------------------
" Backups
" ----------------------------------------------------------------------------

set nobackup                    " do not keep backups after close
set nowritebackup               " do not keep a backup while working
set noswapfile                  " don't keep swp files either
set backupdir=$HOME/.vim/backup " store backups under ~/.vim/backup
set backupcopy=yes              " keep attributes of original file
set backupskip=/tmp/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,.


" ----------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------

set hidden                      " Handle multiple buffers better
set ruler                       " Show cursor position
set showcmd                     " Display incomplete commands
set showmode                    " Display the mode you're in
set nolazyredraw                " Don't redraw while executing macros
set number                      " Show line numbers
set numberwidth=4               " This sets the number width

set wildmenu                    " Enhanced command line completion: like a shell
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=_build                           " Sphinx build dir
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store
set wildignore+=*CACHE

set cmdheight=2                 " Command line height
set backspace=indent,eol,start  " Intuitive backspacing
set whichwrap+=<,>,h,l,[,]      " Backspace and cursor keys wrap to
set shortmess=aoOtAI            " Shorten messages
set report=0                    " Tell us about changes
set nostartofline               " Don't jump to start of line when scrolling
set scrolloff=5                 " Show 5 lines of context around the cursor


" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set visualbell                  " No beeping
set title                       " Set the terminal's title
set cursorline                  " Cursor line indicator
set shellslash                  " Use forward slashes everwhere
set mousehide                   " Hide the mouse pointer while typing

set laststatus=2                " Always show status line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y
set statusline+=\ %{exists('fugitive')?fugitive#statusline():''}
set statusline+=%=%-16(\ %l,%c-%v\ %)%P

set list                        " Show whitespace chars
set listchars=tab:»\ ,eol:¬,trail:·

set showmatch                   " Show matching brackets
set hlsearch                    " Highlight search matches
set incsearch                   " Highlight matches as you type
set ignorecase                  " Case-insensitive searching
set smartcase                   " ...but case-sensitive if expression contains a capital letter
set wrapscan                    " Set the search scan to wrap around the file

highlight OverLength ctermbg=red ctermfg=white guibg=#592929


" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent                  " automatic indent new lines
set smartindent
set nowrap                      " Turn off line wrapping

set softtabstop=4               " Global soft tab width
set shiftwidth=4                " Global whitespace shift width
set tabstop=4                   " Global tab width
set expandtab                   " Expand tabs to spaces
set nosmarttab

set formatoptions+=n            " Support for numbered/bullet lists
set textwidth=115               " Wrap at 115 chars by default
set virtualedit=block           " Allow virtual edit in visual block
set nojoinspaces                " Do not insert 2 spaces after a '.', '?', or '!'


" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

let mapleader=","               " Lead with ,
let g:mapleader=","             " ...and again
let maplocalleader="\\"         " For certain plugins that use localleader

" Editing .vimrc
nmap <Leader>v :e $MYVIMRC<CR>

" Remap ; to :
nnoremap ; :

" Quicker shell commands
nmap ! :!

" Fix Y so it behaves like D
nnoremap Y y$

" Remap jj to <esc> because I just like it much better
inoremap jj <Esc>

" Do not attempt to display manual
nnoremap K <nop>

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
" inoremap <Down> <C-o>gj
" inoremap <Up> <C-o>gk

" Unimpaired -- bubble single and multiple lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Press space bar to turn off search highlighting and clear any message displayed
nnoremap <silent> <Space> :nohl<Bar>:echo<CR>

" Substitute
nnoremap <Leader>s :%s//g<left><left>

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    silent! call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Uppercase
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

" Reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" Retab a source file
nmap <Leader>rr :retab!<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>mm mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Toggle whitespace characters
nmap <Leader>l :set list!<CR>

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation : save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    silent! call cursor(l, c)
endfunction

nnoremap <silent> <Leader>W :call <SID>StripTrailingWhitespaces()<CR>

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nmap <Leader>md :!mkdir -p %:p:h

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


" ----------------------------------------------------------------------------
" Source my scripts and add keybindings if needed
" ----------------------------------------------------------------------------
function! SourceMyConfig()
  let file_list = split(globpath("~/.vim/config", "*.vim"), '\n')

  for file in file_list
    execute( 'source '.file )
  endfor
endfunction

call SourceMyConfig()

nmap <leader>1 :call Class()<cr>
nmap <leader>2 :call AddDependency()<cr>

" ----------------------------------------------------------------------------
" Autocommands
" ----------------------------------------------------------------------------

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

if has("autocmd")
    " Remember last location in a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Save on lose focus
    au FocusLost * :wa

    " Source .vimrc on save
    au BufWritePost .vimrc source $MYVIMRC

    " Keep splits sized properly
    au VimResized * exe "normal! \<cw>="

    " Syntax of these languages is fussy over tabs vs spaces
    au FileType make       setlocal ts=4 sts=4 sw=4 noet
    au FileType yaml,haml  setlocal ts=2 sts=2 sw=2 et

    " Whitespace based on house-style (arbitrary)
    au FileType html       setlocal ts=4 sts=4 sw=4 noet
    au FileType xhtml      setlocal ts=4 sts=4 sw=4 et
    au FileType css        setlocal ts=4 sts=4 sw=4 noet
    au FileType ruby       setlocal ts=2 sts=2 sw=2 et
    au FileType sass       setlocal ts=2 sts=2 sw=2 et
    au FileType less       setlocal ts=4 sts=4 sw=4 noet
    au FileType javascript setlocal ts=4 sts=4 sw=4 noet
    au FileType xml        setlocal ts=4 sts=4 sw=4 et

    "" HTML
    au FileType html,xhtml setlocal fo+=tl                      " for HTML, generally format text, but if a long line has been created leave it alone when editing:
    au BufNewFile,BufRead *.{jsp,jspf} setlocal ft=jsp.html     " set .jsp files to edit like HTML

    "" CSS
    au BufNewFile,BufRead *.scss setlocal ft=scss.css           " Get CSS snippets in SCSS files
    au BufNewFile,BufRead *.less setlocal ft=less.css           " Get CSS snippets in LESS files

    "" JavaScript
    au BufNewFile,BufRead *.{json,htc} setlocal ft=javascript   " Syntax highlighting for JSON files

    "" Python
    au FileType python setlocal ts=4 sts=4 sw=4 et              " make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
    au FileType python match OverLength /\%79v.\+/

    "" PHP
    au BufNewFile,BufRead *.ctp setlocal ft=php                 " set .ctp files to edit like php for cakePHP

    "" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
    au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} setlocal ft=ruby

    "" Markdown -- markdown, md, mk, mkd, pdk, pandoc, and text are markdown and define buffer-local preview
    au FileType markdown,md,mk,mkd,pdk,pandoc,text nnoremap <buffer> <localleader>1 yypVr=
    au FileType markdown,md,mk,mkd,pdk,pandoc,text nnoremap <buffer> <localleader>2 yypVr-

    "" reStructuredText
    au FileType rst nnoremap <buffer> <localleader>1 yypVr=
    au FileType rst nnoremap <buffer> <localleader>2 yypVr-
    au FileType rst nnoremap <buffer> <localleader>3 yypVr~
    au FileType rst nnoremap <buffer> <localleader>4 yypVr`

    "" Open help files in a vertical split
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
endif


" ----------------------------------------------------------------------------
" GUI Settings
" ----------------------------------------------------------------------------

set guioptions-=T               " Hide toolbar.
set guioptions-=l               " Don't show left scrollbar
set guioptions-=L               " Don't show left scrollbar
set guioptions-=r               " Don't show right scrollbar
set guioptions-=R               " Don't show right scrollbar

set guioptions+=aA              " Autoselect.
set guioptions+=c               " Use console dialogs

set guifont=Source\ Code\ Pro\ for\ Powerline:h14     " Font family and font size.
set antialias                   " MacVim: smooth fonts.

if has('mouse')
    set mouse=a                 " Enable mouse usage (all modes) in terminal
endif

if has("gui_macvim")
    " MacVIM shift+arrow-keys behavior (required in .vimrc)
    let macvim_hig_shift_movement = 1

    " Command-Shift-F for Ack
    map <D-F> :Ack!<space>

    " Command-/ to toggle comments
    nmap <D-/> <Plug>CommentaryLine

    " Command-][ to increase/decrease indentation
    vmap <D-]> >gv
    vmap <D-[> <gv
endif

set background=dark
colorscheme molokai             " Default terminal color scheme

syntax enable                   " Turn on syntax highlighting
set synmaxcol=2048              " Syntax coloring too-long lines is slow


" ----------------------------------------------------------------------------
" Vundle
" ----------------------------------------------------------------------------
" Vundle init
set rtp+=~/.vim/bundle/vundle/

" Require Vundle
try
    call vundle#rc()
catch
    echohl Error | echo "Vundle is not installed. Run 'cd ~/.vim/ && git submodule init && git submodule update'" | echohl None
endtry


"{{{ Vundle Bundles!
if exists(':Bundle')
    Bundle 'gmarik/vundle'

    " My Bundles here:
    "
    " repos on github
    Bundle 'rking/ag.vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'othree/html5.vim.git'
    Bundle 'tomasr/molokai'
    Bundle 'scrooloose/nerdtree.git'
    Bundle 'tobyS/pdv'
    Bundle 'ervandew/supertab.git'
    Bundle 'scrooloose/syntastic.git'
    Bundle 'SirVer/ultisnips.git'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'joonty/vim-phpqa.git'
    Bundle 'joonty/vim-sauce.git'
    Bundle 'joonty/vdebug.git'
    Bundle 'joonty/vim-phpunitqf.git'
    Bundle 'joonty/vim-taggatron.git'
    Bundle 'tpope/vim-fugitive.git'
    Bundle 'joonty/vim-tork.git'
end

" ----------------------------------------------------------------------------
"  Plugin Settings
" ----------------------------------------------------------------------------

" ctrlp             git://github.com/kien/ctrlp.vim.git
                    "let g:ctrlp_map = '<C-Space>'
                    nmap <Leader>f :ClearCtrlPCache<CR>
                    let g:ctrlp_working_path_mode = 0
" fugitive          git://github.com/tpope/vim-fugitive.git
" nerdtree          git://github.com/scrooloose/nerdtree.git
                    nmap <Space>d :NERDTreeToggle<CR>
                    nmap <Leader>d :NERDTreeToggle<CR>
                    let NERDTreeIgnore=['\.rbc$', '\~$']
                    let NERDTreeDirArrows=1
                    let NERDChristmasTree=1
                    " Close nerdtree when it's the only buffer left open
                    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" pdv               https://github.com/tobyS/pdv.git
                    let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
                    nnoremap <buffer> <Leader>pd :call pdv#DocumentWithSnip()<CR>
" unimpaired        git://github.com/tpope/vim-unimpaired.git
" powerline         https://github.com/Lokaltog/powerline.git
                    python from powerline.vim import setup as powerline_setup
                    python powerline_setup()
                    python del powerline_setup
" UltiSnips         https://github.com/SirVer/ultisnips.git
" vim-unimpaired    https://github.com/tpope/vim-unimpaired.git
" vim: set ts=4 sw=4 tw=79 :
