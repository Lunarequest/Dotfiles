if &compatible
  set nocompatible
endif

function! s:packager_init(packager) abort
  call a:packager.add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call a:packager.add('https://github.com/preservim/nerdtree.git')
  call a:packager.add('arcticicestudio/nord-vim')
  call a:packager.add('https://github.com/vim-airline/vim-airline.git')
  call a:packager.add('https://github.com/vim-airline/vim-airline-themes.git')
  "call a:packager.add('https://github.com/vim-syntastic/syntastic.git')
  "call a:packager.add('rust-lang/rust.vim')
  call a:packager.add('https://github.com/autozimu/LanguageClient-neovim.git',{ 'branch':'next','do':'bash install.sh'})
  call a:packager.add('junegunn/fzf')
  call a:packager.add('https://github.com/psf/black.git', { 'type':'opt' })
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'))

augroup packager_filetype
   autocmd FileType python packadd black
augroup END

set number
set tabstop=4
set foldenable
set foldmethod=indent
set showmatch

if has('termguicolors')
   set termguicolors
endif

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['~/local/bin/pylsp'],
    \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='deus'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:NERDTreeShowHidden=1

colorscheme nord

autocmd VimEnter * NERDTree | wincmd p

