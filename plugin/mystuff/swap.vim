function! Swap(type, ...)
let still = input("")
python << EOF
import vim
def swap(fulltext, still):
  s,e = fulltext.find(still), fulltext.find(still) + len(still)
  while fulltext[s - 1] == ' ': s -=1
  while fulltext[e] == ' ': e += 1
  return fulltext[e:] + fulltext[s:e] + fulltext[:s]
buf = vim.current.buffer
if vim.eval("a:0") == "0":
  sline, scol = buf.mark("[")
  eline, ecol = buf.mark("]")
else:
  sline, scol = buf.mark("<")
  eline, ecol = buf.mark(">")

  sline -=1; eline -=1; ecol += 1
  still =  vim.eval("still")
  buf[sline] = buf[sline][:scol] + swap(buf[sline][scol:ecol], still)  + buf[sline][ecol:]
EOF
endfunction
nnoremap <silent> ss :set opfunc=Swap<CR>g@
vnoremap <silent> ss :call Swap(visualmode(), 1)<CR>
