"{ An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
"set incsearch		 do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  set nocp
  syntax on
  filetype plugin indent on
  call pathogen#infect('~/.vim/bundle')

  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vim

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

set nocompatible
set number
set tabstop=4
set paste
set expandtab
set shiftwidth=4
syntax on
let php_folding=1
set nofoldenable
highlight LineNr term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE
highlight Folded ctermfg=grey ctermbg=black
highlight Comment ctermfg=LightBlue

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

map <C-H> <C-W>h<C-W>|
map <C-L> <C-W>l<C-W>|


map <F5> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>
let mapleader=","
set ic

let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"

"let g:CommandTSelectNextMap=['<j>', '<Up>']
"let g:CommandTSelectPrevMap=['<k>', '<Down>']

let g:CommandTMaxFiles=1000000
let g:CommandTMaxDepth=5
let g:CommandTCancelMap='<ESC>'

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
" autocmd FileType python map <buffer> <F3> :call Flake8()<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_working_path_mode = 0

nnoremap <leader>t :SyntasticCheck<CR>
let g:syntastic_auto_jump=1
let g:syntastic_loc_list_height=15
let g:syntastic_auto_loc_list=1
