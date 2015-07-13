"When moving to a new vim
"Copy vimrc
"Install vundle https://github.com/gmarik/vundle#about
"run :BundleInstall Syntastic
"run :BundleInstall Valloric/YouCompleteMe (you may have to install vim from source to to get this working)
"compile you complete me
"remove dumb 80 character line limit from ~/.vim/bundle/YouCompleteMe/style_format.sh
"run :Bundleinstall terryma/vim-multiple-cursors
"download vim fanfingtastic and put in ~/.vim/plugins
"
":CtrlPClearCache


" Things required for vundle
set nocompatible              " be iMproved, required
filetype off                  " required


set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'Syntastic'
if v:version > 703
  Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'rosenfeld/conque-term'
Plugin 'bitc/vim-hdevtools'
Plugin 'tpope/vim-surround'
Plugin 'amoffat/snake'


call vundle#end()

filetype plugin indent on    " required
autocmd BufRead,BufNewFile *go setlocal filetype=go

set noswapfile

let g:ctrlp_switch_buffer=1 "allow ctrlp to open the same file twice
let g:syntastic_java_javac_config_file_enabled=1
let g:syntastic_java_javac_classpath="./build/classes"
let g:go_doc_keywordprg_enabled=0

let mapleader=" "

"set backspace=indent,eol,start
"set foldmethod=indent
"set foldlevel=99
"set foldlevelstart=99


" Change colorscheme from default to ron
colorscheme ron

" Turn on line numbering. Turn it on and of with set number and set number!
set nu
set rnu

" Set syntax on
syntax on

function! EraseTrailingWhiteSpace()
  if search('\s\+$', 'nw') != 0
    %s/\s\+$//e
    normal!``
  endif
endfunction

augroup mygroup
  "every time you source ~/.vimrc, it re-adds everything in this group
  "multiple source ~/.vimrc will end up with multiple copies of the same autocmd
  "therefore erase this group before making all the autocmds,
  autocmd!

  "open vim with with cursor position where it was last
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  "erase whitespace at the end of new lines
  autocmd BufWritePre *
    \ if  argv(0) != ".git/addp-hunk-edit.diff" |
    \   call EraseTrailingWhiteSpace() |
    \ endif

  "if you change vimrc, resource it
  autocmd BufWritePost  .vimrc  source %
  autocmd BufWritePost */plugin/mystuff/*.vim source %
augroup END


" searching
set smartcase
set incsearch
set ic "ignore case
"set hls "Higlhight search

" Wrap text instead of being on one line
"set lbr

"tabs
set expandtab "Use spaces instead of tabs
set smarttab "Be smart when using tabs ;)
" 1 tab == 2 spaces
set shiftwidth=2
set softtabstop=2
set ai "Auto indent (copy indent from current line onto next line)
set si "Smart indent (indent where the syntax would want an indent)
set wrap "Wrap lines
" Indent automatically depending on filetype
filetype indent on



set laststatus=2



"test functions
"C-W w   moves current split-screen to it's own tab
ca diff :windo diffthis<CR>
ca diffoff :windo diffoff<CR>
noremap mm =
nnoremap <silent> <Leader>n  :set rnu!<CR>
au FileType haskell nnoremap <silent> <buffer> <Leader>ht :HdevtoolsType<CR>
au FileType haskell nnoremap <silent> <buffer> <Leader>hc :HdevtoolsClear<CR>
au FileType haskell nnoremap <silent> <buffer> <Leader>hi :HdevtoolsInfo<CR>
nnoremap <silent> <leader>sr :SyntasticReset<CR>
set splitright
nnoremap n /<CR>
nnoremap N ?<CR>
xnoremap <leader>a :norm! @1<CR>
"let g:syntastic_python_python_exec = 'python3'

