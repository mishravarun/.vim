" Varun's vimrc
" Load pathogn
execute pathogen#infect()

filetype on
syntax on

" visual
colorscheme Tomorrow-Night
set guifont=Menlo\ Regular:h18
set colorcolumn=80
set number

" leader key is set to space
let mapleader = "\<Space>"
map <leader>s :source ~/.vimrc<CR>

" Keep more info in memory to speed things up:
set hidden
set history=100

"  Basic indenting logic. Specific filetypes are in ~/.vimrc/ftplugin
filetype plugin on
filetype plugin indent on
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
" show matching parenthesis.
set showmatch

" remove whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" better search
" highlight search words
set hlsearch
" esc to cancel search
" nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" command-T config
"set wildignore+=*.log,*.sql,*.cache
"reload cache
"noremap <Leader>r :CommandTFlush<CR>

" lightline config
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified'
      \ },
      \ 'separator': { 'left': '|', 'right': '|' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "RO"
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction
