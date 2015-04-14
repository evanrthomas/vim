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
call vundle#end()

filetype plugin indent on    " required
autocmd BufRead,BufNewFile *go setlocal filetype=go

set noswapfile

let g:ctrlp_switch_buffer=1 "allow ctrlp to open the same file twice
let g:syntastic_java_javac_config_file_enabled=1
let g:syntastic_java_javac_classpath="./build/classes"
let g:go_doc_keywordprg_enabled=0

let mapleader=" "

set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99


" Change colorscheme from default to ron
colorscheme ron

" Turn on line numbering. Turn it on and of with set number and set number!
set nu

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
  autocmd BufWritePre * :call EraseTrailingWhiteSpace()

  "if you change vimrc, resource it
  autocmd BufWritePost  .vimrc  source %
  autocmd BufWritePost */plugin/mystuff/*.vim source %
augroup END


" searching
set ignorecase
set smartcase
set incsearch
set hlsearch
set ic "ignore case
set hls "Higlhight search

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

" Rename tabs to show tab number.
" (Copied from http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1

    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let wn = tabpagewinnr(i,'$')

      let s .= '%#TabNum#'
      let s .= i
      " let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
        if buftype == 'nofile'
          if file =~ '\/.'
            let file = substitute(file, '.*\/\ze.', '', '')
          endif
        else
          let file = fnamemodify(file, ':p:t')
        endif

      if file == ''
        let file = '[No Name]'
      endif

      let s .= ' ' . file . ' '
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction

  set stal=2
  set tabline=%!MyTabLine()
  set showtabline=1
  highlight link TabNum Special
endif


"test functions
"C-W w   moves current split-screen to it's own tab
ca diff :windo diffthis<CR>
ca diffoff :windo diffoff<CR>
noremap mm =
nnoremap <Leader>c :noh<CR>
nnoremap <Leader>h  *
:ca fixlog !python logfilter.py
nnoremap rp ggdG:.!node /home/evan/Desktop/playground/reference/js_ast_try_catch/main.js '%:p'<CR>:set syntax=javascript<CR>G
ca trca node /home/evan/Desktop/playground/reference/js_ast_try_catch/main.js


