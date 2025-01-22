" Latex {{{
let g:tex_flavor='latex'
source $VIMRUNTIME/menu.vim
let g:Tex_CustomTemplateDirectory = '~/Documents/LaTeX/templates'
" Xelatex has problems with tikz image remember function
let g:Tex_CompileRule_pdf = 'latexmk -lualatex $*'
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_CompileRule_svg = 'dvisvgm $*.dvi'
let g:Tex_FormatDependency_svg = 'dvi'
let g:Tex_CompileRule_dvi = 'lualatex --output-format=dvi $*'
let g:Tex_GotoError = 0
let g:Tex_SmartKeyQuote = 0
" }}}

let g:lsp_settings = {
 \  'qmlls': {
 \    'args': ['-I', '/Users/henrik/qt/6.7.3/macos/qml'],
 \  },
 \}
