" syntax highlighting on
syntax on

" default paste
set paste

" tab settings
set ts=2
set expandtab

" show lineno
:set nu

" auto-indenting
"set ai

" 'visual bell', quieter than the 'audio blink'
set vb

" show matching brackets.
set showmatch

" behave in a more useful way
set nocompatible

" auto reload files
set autoread

" searching
set ignorecase
set smartcase
set incsearch

" http://www.abbeyworkshop.com/howto/osx/osxVim/index.html
" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set binary noeol

" make that backspace key work the way it should
set backspace=indent,eol,start
