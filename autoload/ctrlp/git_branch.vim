if exists('g:loaded_ctrlp_git_branch') && g:loaded_ctrlp_git_branch
  finish
endif
let g:loaded_ctrlp_git_branch = 1

let s:git_branch_var = {
  \ 'init':   'ctrlp#git_branch#init()',
  \ 'accept': 'ctrlp#git_branch#accept',
  \ 'lname':  'git-branch',
  \ 'sname':  'git-br',
  \ 'type':   'line',
  \ 'enter':  'ctrlp#git_branch#enter()',
  \ 'exit':   'ctrlp#git_branch#exit()',
  \ 'sort':   0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_branch_var)
else
  let g:ctrlp_ext_vars = [s:git_branch_var]
endif

function! ctrlp#git_branch#init()
  return s:branch
endfunc

function! ctrlp#git_branch#accept(mode, str)
  call ctrlp#exit()
  echo system('git checkout '.a:str[2:])
endfunction

" Do something before enterting ctrlp
function! ctrlp#git_branch#enter()
  let s:branch = split(system('git branch'), "\n")
endfunction

" Do something after exiting ctrlp
function! ctrlp#git_branch#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git_branch#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
