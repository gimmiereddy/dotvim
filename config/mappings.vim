" ----------------------------------------------------------------------------
"  Filename: mappings.vim
"  Description: This file contains all my key mappings
" ----------------------------------------------------------------------------

let mapleader=","               " lead with ,
let g:mapleader=","             " ...and again
let maplocalleader="\\"         " for certain plugins that use localleader

" editing .vimrc
nmap <leader>v :e $MYVIMRC<cr>

" remap ; to :
nnoremap ; :

" quicker shell commands
nmap ! :!

" fix y so it behaves like d
nnoremap y y$

" remap jj to <esc> because i just like it much better
inoremap jj <esc>

" do not attempt to display manual
nnoremap k <nop>

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
vnoremap <down> gj
vnoremap <up> gk
" inoremap <down> <c-o>gj
" inoremap <up> <c-o>gk

" unimpaired -- bubble single and multiple lines
nmap <c-up> [e
nmap <c-down> ]e
vmap <c-up> [egv
vmap <c-down> ]egv

" press space bar to turn off search highlighting and clear any message displayed
nnoremap <silent> <space> :nohl<bar>:echo<cr>

" substitute
nnoremap <leader>s :%s//g<left><left>

" Append modeline after last line in buffer.  Use substitute() instead of printf() to handle '%%s' modeline
function! AppendModeline()
    let l:modeline = printf(" vim: set ft=%s ts=%d sw=%d tw=%d :", &filetype, &tabstop, &shiftwidth, &textwidth)
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
 endfunction

nnoremap <silent> <leader>ml :call AppendModeline()<cr>

" uppercase
nnoremap <c-u> guiw
inoremap <c-u> <esc>guiwea

" reflow paragraph with q in normal and visual mode
nnoremap q gqap
vnoremap q gq

" retab a source file
nmap <leader>rr :retab!<cr>

" remove the windows ^m - when the encodings gets messed up
noremap <leader>mm mmhmt:%s/<c-v><cr>//ge<cr>'tzt'm

" toggle whitespace characters
nmap <leader>l :set list!<cr>

" strip trailing whitespace
function! <sid>striptrailingwhitespaces()
    " preparation : save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    silent! call cursor(l, c)
endfunction

nnoremap <silent> <leader>w :call <sid>striptrailingwhitespaces()<cr>

" make the directory that contains the file in the current buffer.
" this is useful when you edit a file in a directory that doesn't
" (yet) exist
nmap <leader>md :!mkdir -p %:p:h

" opens an edit command with the path of the currently edited file filled in
" normal mode: <leader>e
map <leader>e :e <c-r>=expand("%:p:h") . "/" <cr>

" inserts the path of the currently edited file into a command
" command mode: ctrl+p
cmap <c-p> <c-r>=expand("%:p:h") . "/" <cr>
