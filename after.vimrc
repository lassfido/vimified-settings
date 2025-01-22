set number
set ignorecase
set smartcase
set ruler

let s:templateDir = "~/Documents/vimTemplates/"
augroup templates
	" Special Templates
	autocmd BufNewFile opt*.com silent! execute "0r" . s:templateFilename . "opt_freq"
	autocmd BufNewFile chemsh_* silent! execute "0r" . s:templateDir . "submit_chemsh"
	autocmd BufNewFile charmm_*.sh silent! execute "0r" . s:templateDir . "submit_charmm"
	autocmd BufNewFile nx_initcond*.sh execute "0r" . s:templateDir . "submit_nx_initcond"
	let s:templateFilename = '0r' . s:templateDir
	autocmd BufNewFile *.* silent! execute s:templateFilename.expand("<afile>:e")
	let filename = expand("%:t:r")
	autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END
execute "au BufNewFile *.sub 0r" . s:templateDir . "sbatch"
filetype plugin on
filetype plugin indent on    " required

cabbrev tn tabnew
cabbrev th tabp
cabbrev tl tabn
cabbrev te tabe

command -nargs=* -complete=file Ex :w | ! ./% <args>

"Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

if filereadable("~/.vimrc-local")
	source "~/.vimrc-local"
endif

colorscheme hybrid
let g:ycm_global_ycm_extra_conf = '-Wall -Wextra -Werror'

" vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.qml,*.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction
" NOTE: You can use other key to expand snippet.
" u {{{

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

augroup my_vim
    autocmd!
    autocmd Filetype vim nnoremap <buffer> <localleader>fo O<c-u>" Placeholder {{{<esc>2bve<c-G>
    autocmd Filetype vim nnoremap <buffer> <localleader>fc o<c-u>" }}}<esc>
    autocmd Filetype vim nnoremap <buffer> <localleader>s :source %<cr>
    autocmd Filetype vim nnoremap <buffer> <localleader>yf bve"fy
    autocmd Filetype vim nnoremap <buffer> <localleader>e :call function(@f)()
augroup END
