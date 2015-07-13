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


function! ClipboardPaste()
  execute 'r !xclip -selection clipboard -o'
endfunction
nnoremap <leader>p :call ClipboardPaste()<CR>
