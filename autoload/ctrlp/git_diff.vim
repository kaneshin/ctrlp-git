if exists('g:loaded_ctrlp_git_diff') && g:loaded_ctrlp_git_diff
  finish
endif
let g:loaded_ctrlp_git_diff = 1

let s:git_diff_var = {
  \ 'init':   'ctrlp#git_diff#init()',
  \ 'accept': 'ctrlp#git_diff#accept',
  \ 'lname':  'git-diff',
  \ 'sname':  'git-diff',
  \ 'type':   'line',
  \ 'enter':  'ctrlp#git_diff#enter()',
  \ 'exit':   'ctrlp#git_diff#exit()',
  \ 'sort':   0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_diff_var)
else
  let g:ctrlp_ext_vars = [s:git_diff_var]
endif

function! ctrlp#git_diff#init()
  return s:log
endfunc

function! ctrlp#git_diff#accept(mode, str)
  call ctrlp#exit()
  let hash = substitute(a:str, "^\\(.\\+\\)\\s|.*$", "\\1", "")
  exe "new"
  nnoremap <buffer> q <C-w>c
  setlocal bufhidden=hide buftype=nofile noswapfile nobuflisted
  exe "r !git diff ".hash
  let &ft = "diff"
  silent! normal! ggdd
endfunction

" Do something before enterting ctrlp
function! ctrlp#git_diff#enter()
  let s:log = split(system('git log --oneline -100 --pretty=format:"%h | %cr, %an - %s"'), "\n")
endfunction

" Do something after exiting ctrlp
function! ctrlp#git_diff#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git_diff#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
