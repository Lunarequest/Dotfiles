" Packager
if &compatible
  set nocompatible
endif
function! s:packager_init(packager) abort
  " plugin manager
  call a:packager.add('kristijanhusak/vim-packager', {'type':'opt'})
  " theme
  call a:packager.add('kaicataldo/material.vim', { 'branch': 'main' })
  " nerd tree file explorer
  call a:packager.add('preservim/nerdtree')
  " black formater
  call a:packager.add('psf/black', { 'branch': 'stable','type':'opt' })
  " airline
  call a:packager.add('vim-airline/vim-airline')
  " air line themes
  call a:packager.add('vim-airline/vim-airline-themes')
  call a:packager.add('prabirshrestha/vim-lsp')
  call a:packager.add('mattn/vim-lsp-settings')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'))
packadd nerdtree
" settings
set number
set tabstop=4
set foldenable
set foldmethod=indent

if has('termguicolors')
  set termguicolors
endif
" Load plugins only for specific filetype
augroup packager_filetype
  autocmd!
  " load black for python files
  autocmd FileType python packadd black
augroup END

syntax on

let g:airline_powerline_fonts = 1
let g:airline_theme = 'wombat'

let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1
colorscheme material 

nnoremap <space> za

let g:NERDTreeShowHidden = 1

"start nerd tree drop cursor in other window
autocmd VimEnter * NERDTree | wincmd p
