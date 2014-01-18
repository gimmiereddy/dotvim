" This is my general settings file
" Author:   Sido Jensma
" Date:     18 Jan 2014
" ----------------------------------------------------------------------------
" general
" ----------------------------------------------------------------------------

set nocompatible                " don't sacrifice anything for vi compatibility
set history=1000                " keep some stuff in the history
set ffs=unix,dos,mac            " support these files
set isk+=_,$,@,%,#,-            " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                    " make sure modeline support is enabled
set autoread                    " reload the files if they changed on disk
set tabpagemax=50               " open 50 tabs max
set encoding=utf-8              " always use utf-8 by default
set timeoutlen=500              " timeout between key command combos

" ----------------------------------------------------------------------------
" backups
" ----------------------------------------------------------------------------

set nobackup                    " do not keep backups after close
set nowritebackup               " do not keep a backup while working
set noswapfile                  " don't keep swp files either
set backupdir=$home/.vim/backup " store backups under ~/.vim/backup
set backupcopy=yes              " keep attributes of original file
set backupskip=/tmp/*,/private/tmp/*,$tmpdir/*,$tmp/*,$temp/*
set directory=~/.vim/swap,~/tmp,.


" ----------------------------------------------------------------------------
" ui
" ----------------------------------------------------------------------------

set hidden                      " handle multiple buffers better
set ruler                       " show cursor position
set showcmd                     " display incomplete commands
set showmode                    " display the mode you're in
set nolazyredraw                " don't redraw while executing macros
set number                      " show line numbers
set numberwidth=4               " this sets the number width

set wildmenu                    " enhanced command line completion: like a shell
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " version control
set wildignore+=_build                           " sphinx build dir
set wildignore+=*.aux,*.out,*.toc                " latex intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " vim swap files
set wildignore+=*.ds_store
set wildignore+=*cache

set cmdheight=2                 " command line height
set backspace=indent,eol,start  " intuitive backspacing
set whichwrap+=<,>,h,l,[,]      " backspace and cursor keys wrap to
set shortmess=aootai            " shorten messages
set report=0                    " tell us about changes
set nostartofline               " don't jump to start of line when scrolling
set scrolloff=5                 " show 5 lines of context around the cursor


" ----------------------------------------------------------------------------
" visual cues
" ----------------------------------------------------------------------------

set visualbell                  " no beeping
set title                       " set the terminal's title
set cursorline                  " cursor line indicator
set shellslash                  " use forward slashes everwhere
set mousehide                   " hide the mouse pointer while typing

set listchars=tab:▸\ ,eol:¬,trail:·

set showmatch                   " show matching brackets
set hlsearch                    " highlight search matches
set incsearch                   " highlight matches as you type
set ignorecase                  " case-insensitive searching
set smartcase                   " ...but case-sensitive if expression contains a capital letter
set wrapscan                    " set the search scan to wrap around the file

highlight overlength ctermbg=red ctermfg=white guibg=#592929


" ----------------------------------------------------------------------------
" text formatting
" ----------------------------------------------------------------------------

set autoindent                  " automatic indent new lines
set smartindent
set nowrap                      " turn off line wrapping

set softtabstop=4               " global soft tab width
set shiftwidth=4                " global whitespace shift width
set tabstop=4                   " global tab width
set expandtab                   " expand tabs to spaces
set nosmarttab

set formatoptions+=n            " support for numbered/bullet lists
set textwidth=80                " wrap at 80 chars by default
set virtualedit=block           " allow virtual edit in visual block
set nojoinspaces                " do not insert 2 spaces after a '.', '?', or '!'

" ----------------------------------------------------------------------------
" autocommands
" ----------------------------------------------------------------------------

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

if has("autocmd")
    " remember last location in a file
    au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " save on lose focus
    au focuslost * :wa

    " source .vimrc on save
    au bufwritepost .vimrc source $MYVIMRC

    " keep splits sized properly
    au vimresized * exe "normal! \<cw>="

    " syntax of these languages is fussy over tabs vs spaces
    au filetype make       setlocal ts=4 sts=4 sw=4 noet
    au filetype yaml,haml  setlocal ts=2 sts=2 sw=2 et

    " whitespace based on house-style (arbitrary)
    au filetype html       setlocal ts=4 sts=4 sw=4 noet
    au filetype xhtml      setlocal ts=4 sts=4 sw=4 et
    au filetype css        setlocal ts=4 sts=4 sw=4 noet
    au filetype ruby       setlocal ts=2 sts=2 sw=2 et
    au filetype sass       setlocal ts=2 sts=2 sw=2 et
    au filetype less       setlocal ts=4 sts=4 sw=4 noet
    au filetype javascript setlocal ts=4 sts=4 sw=4 noet
    au filetype xml        setlocal ts=4 sts=4 sw=4 et

    "" html
    au filetype html,xhtml setlocal fo+=tl                      " for html, generally format text, but if a long line has been created leave it alone when editing:
    au bufnewfile,bufread *.{jsp,jspf} setlocal ft=jsp.html     " set .jsp files to edit like html

    "" css
    au bufnewfile,bufread *.scss setlocal ft=scss.css           " get css snippets in scss files
    au bufnewfile,bufread *.less setlocal ft=less.css           " get css snippets in less files

    "" javascript
    au bufnewfile,bufread *.{json,htc} setlocal ft=javascript   " syntax highlighting for json files

    "" python
    au filetype python setlocal ts=4 sts=4 sw=4 et              " make python follow pep8 ( http://www.python.org/dev/peps/pep-0008/ )
    au filetype python match overlength /\%79v.\+/

    "" php
    au bufnewfile,bufread *.ctp setlocal ft=php                 " set .ctp files to edit like php for cakephp

    "" thorfile, rakefile, vagrantfile and gemfile are ruby
    au bufread,bufnewfile {gemfile,rakefile,vagrantfile,thorfile,config.ru} setlocal ft=ruby

    "" markdown -- markdown, md, mk, mkd, pdk, pandoc, and text are markdown and define buffer-local preview
    au filetype markdown,md,mk,mkd,pdk,pandoc,text nnoremap <buffer> <localleader>1 yypvr=
    au filetype markdown,md,mk,mkd,pdk,pandoc,text nnoremap <buffer> <localleader>2 yypvr-

    "" restructuredtext
    au filetype rst nnoremap <buffer> <localleader>1 yypvr=
    au filetype rst nnoremap <buffer> <localleader>2 yypvr-
    au filetype rst nnoremap <buffer> <localleader>3 yypvr~
    au filetype rst nnoremap <buffer> <localleader>4 yypvr`

    "" open help files in a vertical split
    au bufwinenter *.txt if &ft == 'help' | wincmd l | endif
endif


" ----------------------------------------------------------------------------
" gui settings
" ----------------------------------------------------------------------------

set guioptions-=t               " hide toolbar.
set guioptions-=l               " don't show left scrollbar
set guioptions-=l               " don't show left scrollbar
set guioptions-=r               " don't show right scrollbar
set guioptions-=r               " don't show right scrollbar

set guioptions+=aa              " autoselect.
set guioptions+=c               " use console dialogs

set guifont=source\ code\ pro\ for\ powerline:h14     " font family and font size.
set antialias                   " macvim: smooth fonts.

if has('mouse')
    set mouse=a                 " enable mouse usage (all modes) in terminal
endif

if has("gui_macvim")
    " macvim shift+arrow-keys behavior (required in .vimrc)
    let macvim_hig_shift_movement = 1

    " command-shift-f for ack
    map <d-f> :ack!<space>

    " command-/ to toggle comments
    nmap <d-/> <plug>commentaryline

    " command-][ to increase/decrease indentation
    vmap <d-]> >gv
    vmap <d-[> <gv
endif

set background=dark
colorscheme molokai             " default terminal color scheme

syntax enable                   " turn on syntax highlighting
set synmaxcol=2048              " syntax coloring too-long lines is slow


