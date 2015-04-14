command! -nargs=1 F "mygrep
      \ execute "vimgrep /" . a:pattern . "/j %"
      \ vertical 75 copen

function! ClipboardPaste()
  execute 'r !xclip -selection clipboard -o'
endfunction
nnoremap <leader>p :call ClipboardPaste()<CR>


function! ClipboardCopy()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    let output = join(lines, "\n")
    let _ = system('xclip -selection clipboard', output)
endfunction
xnoremap <leader>y :call ClipboardCopy()<CR>
xnoremap <leader>c :call ClipboardCopy()<CR>

function! OverwriteCurrentBuffer(content)
  redir @z "put it in z register
  silent echo a:content
  redir END
  normal ggdG
  normal "zp
endfunction

function! RunCommandToNewBuffer(cmd)
  echo "RunCommandToNewBuffer"
  let l:contents = join(getline(1,'$'), "\n")
  let l:output = system(a:cmd, l:contents)
  if exists("t:RunBuffer") && bufnr(t:RunBuffer) != -1
    windo if bufnr('%') == t:RunBuffer |
          \   call OverwriteCurrentBuffer(l:output) |
          \ endif
  else
    rightbelow vertical new
    let t:RunBuffer=bufnr('%')
    au BufHidden,BufDelete <buffer> unlet t:RunBuffer
    call OverwriteCurrentBuffer(l:output)
  endif
endfunction

command! -nargs=1 R call RunCommandToNewBuffer(<f-args>)


ca path echo expand('%:p')<CR>

ca genCtags !ctags `find .`<CR>
ca csh  ConqueTerm bash <CR>
