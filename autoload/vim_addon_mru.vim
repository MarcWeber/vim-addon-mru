if !exists('g:vim_addon_mru') | let g:vim_addon_mru = {} | endif | let s:c = g:vim_addon_mru

fun! vim_addon_mru#Read()
  return filereadable(s:c.file)
        \ ? readfile(s:c.file)
        \ : []
endf

fun! vim_addon_mru#ShowMRUList()
  let files = vim_addon_mru#Read()
  call tovl#ui#filter_list#ListView({
        \ 'number' : 1,
        \ 'selectByIdOrFilter' : 1,
        \ 'Continuation' : funcref#Function('exec "e ".escape(substitute(ARGS[0]," |[^|]*$", "", ""), " ")'),
        \ 'items' : files,
        \ 'cmds' : ['wincmd J'],
        \ 'aligned' : 1
        \ })
  " \ 'keys' : ['event', 'file'],
endf

fun! vim_addon_mru#Remember(event)
  if expand('%:p') == '' | return | endif
  " get current file conents 
  let c = vim_addon_mru#Read()
  let n = expand('%:p')
  let item = n.' | '.a:event
  call filter(c, 'stridx(v:val, '.string(n.' ').')'. '!= 0')
  call insert(c, item , 0)
  call writefile(c, s:c.file)
endf
