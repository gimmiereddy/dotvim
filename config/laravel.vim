" Easily create class.
function! Class()
    let name = input('Class Name? ')
    let namespace = input('Any Namespace? ')

    if strlen(namespace)
        exec "normal i<?php namespace " . namespace . ";\<C-m>\<C-m>"
    else
        exec "normal i<?php \<C-m>\<C-m>"
    endif

    " Open class
    exec "normal iclass " . name . " {\<C-m>}\<Esc>O"

    exec "normal i\<C-m>public function __construct()\<C-m>{\<C-m>}\<Esc>O"
endfunction

function! AddDependency()
    let dependency = input('Var Name: ')
    let namespace = input('Class Path: ')
    
    let segments = split(namespace, '\')
    let typehint = segments[-1]
    
    exec 'normal gg/construct^M%i, '  . typehint . ' $' . dependency . '^[/}^MO$this->^[a' . dependency . ' = $' . dependency . ';^[==o^[?{^MkO protected $' . dependency . ';^M^[?{^MOuse ' . namespace . ';^M^['
    
    " Remove opening comma if there is only one dependency
    exec 'normal :%s/(, /(/g^M'
endfunction
" vim: set ts=4 sw=4 tw=80 :
