if !exists('g:vim_addon_mru') | let g:vim_addon_mru = {} | endif | let s:c = g:vim_addon_mru

let s:c.buffer_only = get(s:c, 'buffer_only', 1)

fun! vim_addon_mru#Read()
  return filereadable(s:c.file)
        \ ? readfile(s:c.file)
        \ : []
endf

fun! vim_addon_mru#ShowMRUList()
  " use different buffer so that no 'want to reload' pops up over and over
  " again if you use gf to visit many files
  enew
  exec 'r '.fnameescape(s:c.file)
  " normal 200u
  setlocal noswapfile
  nnoremap <buffer> <cr> gf
  redraw
  call feedkeys("/")
  return
endf

fun! vim_addon_mru#Remember(event)
  if expand('%:p') == '' | return | endif
  " get current file conents 
  let c = vim_addon_mru#Read()
  let n = expand('%:p')
  let item = n.' | '.a:event
  call filter(c, 'stridx(v:val, '.string(n.' ').')'. '!= 0')
  call insert(c, item , 0)
  let c = c[:s:c.count]
  call writefile(c, s:c.file)
endf
