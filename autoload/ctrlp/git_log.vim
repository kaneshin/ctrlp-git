if exists('g:loaded_ctrlp_git_log') && g:loaded_ctrlp_git_log
  finish
endif
let g:loaded_ctrlp_git_log = 1

let s:git_log_var = {
  \ 'init':   'ctrlp#git_log#init()',
  \ 'accept': 'ctrlp#git_log#accept',
  \ 'lname':  'git-log',
  \ 'sname':  'git-log',
  \ 'type':   'line',
  \ 'enter':  'ctrlp#git_log#enter()',
  \ 'exit':   'ctrlp#git_log#exit()',
  \ 'sort':   0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_log_var)
else
  let g:ctrlp_ext_vars = [s:git_log_var]
endif

function! ctrlp#git_log#init()
  return s:log
endfunc

function! ctrlp#git_log#accept(mode, str)
  call ctrlp#exit()
  let hash = substitute(a:str, "^\\(.\\+\\)\\s|.*$", "\\1", "")
  echo system('git show '.hash)
endfunction

" Do something before enterting ctrlp
function! ctrlp#git_log#enter()
  let s:log = split(system('git log --oneline -100 --pretty=format:"%h | %cr, %an - %s"'), "\n")
endfunction

" Do something after exiting ctrlp
function! ctrlp#git_log#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git_log#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
