function! MyGrep(pattern)
  execute "vimgrep /" . a:pattern . "/j %"
  vertical 75 copen
endfunction
command! -nargs=1 F call MyGrep(<f-args>)



