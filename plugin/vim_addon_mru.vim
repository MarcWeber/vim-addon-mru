" exec vam#DefineAndBind('s:c','g:vim_haxe', '{}')
if !exists('g:vim_addon_mru') | let g:vim_addon_mru = {} | endif | let s:c = g:vim_addon_mru

" mapping
let s:c.lhs = get(s:c, 'lhs', '<m-o><m-r>')
" remember that many files:
let s:c.count = get(s:c, 'count', 1000)
" remember on buf edit events:
let s:c.events = get(s:c, 'events', 'BufRead,BufWrite')

let s:c.file = get(s:c, 'file', $HOME.'/.vim/mru')

augroup VIM_ADDON_MRU
  for event in split(s:c.events,",")
    exec 'autocmd '. event .' * call vim_addon_mru#Remember('.string(event).')'
  endfor
augroup end

exec 'noremap '. s:c.lhs .' :call vim_addon_mru#ShowMRUList()<cr>'
