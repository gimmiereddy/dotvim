" vim: set ts=4 sw=4 tw=79 :
" ----------------------------------------------------------------------------
" Vundle
" ----------------------------------------------------------------------------
" Vundle init
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" My Bundles here:
"
" repos on github
Bundle 'rking/ag.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tomasr/molokai'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tobyS/pdv'
Bundle 'ervandew/supertab.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'SirVer/ultisnips.git'
"Bundle 'Lokaltog/vim-easymotion'
Bundle 'kchmck/vim-coffee-script'
Bundle 'joonty/vim-phpqa.git'
Bundle 'joonty/vim-sauce.git'
Bundle 'joonty/vdebug.git'
Bundle 'joonty/vim-phpunitqf.git'
Bundle 'joonty/vim-taggatron.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'joonty/vim-tork.git'

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
" SuperTab          https://github.com/ervandew/supertab.git
" unimpaired        git://github.com/tpope/vim-unimpaired.git
" powerline         https://github.com/Lokaltog/powerline.git
                    python from powerline.vim import setup as powerline_setup
                    python powerline_setup()
                    python del powerline_setup
" UltiSnips         https://github.com/SirVer/ultisnips.git
" vim-unimpaired    https://github.com/tpope/vim-unimpaired.git

function! SourceMyScripts()
  let file_list = split(globpath("~/.vim/config", "*.vim"), '\n')

  for file in file_list
    execute( 'source '.file )
  endfor
endfunction

call SourceMyScripts()
