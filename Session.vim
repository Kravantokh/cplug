let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/prog/cplug
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +5 test.c
badd +29 CMakeLists.txt
badd +1 src/cplug.c
badd +1 src/plugin1.c
badd +25 ~/prog/cplug/plugin_api/base
argglobal
%argdel
$argadd test.c
edit src/cplug.c
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 86 + 87) / 174)
exe '2resize ' . ((&lines * 22 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 87 + 87) / 174)
exe '3resize ' . ((&lines * 23 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 87 + 87) / 174)
argglobal
balt CMakeLists.txt
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=20
setlocal fml=1
setlocal fdn=20
setlocal fen
15
normal! zo
let s:l = 43 - ((30 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 43
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/prog/cplug/plugin_api/base", ":p")) | buffer ~/prog/cplug/plugin_api/base | else | edit ~/prog/cplug/plugin_api/base | endif
if &buftype ==# 'terminal'
  silent file ~/prog/cplug/plugin_api/base
endif
balt CMakeLists.txt
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=20
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 46 - ((11 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 46
normal! 014|
wincmd w
argglobal
if bufexists(fnamemodify("CMakeLists.txt", ":p")) | buffer CMakeLists.txt | else | edit CMakeLists.txt | endif
if &buftype ==# 'terminal'
  silent file CMakeLists.txt
endif
balt test.c
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=20
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 39 - ((22 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 39
normal! 043|
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 86 + 87) / 174)
exe '2resize ' . ((&lines * 22 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 87 + 87) / 174)
exe '3resize ' . ((&lines * 23 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 87 + 87) / 174)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
