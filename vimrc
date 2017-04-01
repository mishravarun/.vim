" Varun's vimrc
" Load pathogn
execute pathogen#infect()

set encoding=utf-8

filetype on
syntax on

:set mouse=a

" visual
"set textwidth=100
command! -nargs=* Wrap set wrap linebreak nolist

"colorscheme Tomorrow-Night
syntax enable
set background=dark
colorscheme solarized
"let g:solarized_termcolors=256
set guifont=Menlo\ Regular:h18
set colorcolumn=100
set number

" handle tab
nnoremap <leader>t :tabe<CR>
" leader key is set to space
let mapleader = "\<Space>"
map <leader>s :source ~/.vimrc<CR>

" make sure backspace works
set backspace=start,eol,indent

 "system clipboard
set clipboard=unnamed

" Keep more info in memory to speed things up:
set hidden
set history=100

"spell check
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.tex set spell spelllang=en_us

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

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold

autocmd FileType python nnoremap <buffer> <leader>r :exec 'w !python' shellescape(@%, 1)<cr>
" better search
" highlight search words
set hlsearch!
" esc to cancel search
nnoremap <leader>/ :set hlsearch!<CR>

" command-T config
"set wildignore+=*.log,*.sql,*.cache
"reload cache
"noremap <Leader>r :CommandTFlush<CR>

"vim splits
set splitbelow
set splitright


"nerd tree config
"Always open the tree when booting Vim, but don’t focus it:
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:nerdtree_tabs_open_on_console_startup=1


" Hit the right arrow to open a node:
let NERDTreeMapActivateNode='<right>'

"Display hidden files
let NERDTreeShowHidden=1
"Toggle display of the tree with <Leader> + n
nmap <leader>n :NERDTreeToggle<CR>

"Locate the focused file in the tree with <Leader> + j
nmap <leader>j :NERDTreeFind<CR>

"Do not display some useless files in the tree:
let NERDTreeIgnore=['\.DS_Store','\.swp']

" auto complete features
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Vim Note taking
:let g:notes_directories = ['~/Google Drive/Notes']
:let g:notes_suffix = '.txt'

"Add header info to new python files
autocmd bufnewfile *.py 0r ~/.vim/header/python.template
autocmd bufnewfile *.py exe "2," . 6 . "g/File name:.*/s//File name: " .expand("%")
autocmd bufnewfile *.py exe "3," . 6 . "g/Date created:.*/s//Date created: " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.py execute "normal ma"
autocmd Bufwritepre,filewritepre *.py exe "3," . 6 . "g/Date last modified:.*/s/Date last modified:.*/Date last modified: " .strftime("%c")
autocmd bufwritepost,filewritepost *.py execute "normal `a"


"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Latex settings
let g:Tex_BIBINPUTS = '~/Development/Papers/bibliography'
let g:Tex_UseSimpleLabelSearch = 1
let g:Tex_RememberCiteSearch = 1
"let g:tex_flavor='latex'
let g:tex_flavor='pdflatex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf,pdf'

let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_ps = 'open -a Preview'
let g:Tex_ViewRule_pdf = 'open -a Preview'
autocmd FileType tex exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
set completeopt=menuone,longest,preview
set complete+=k

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
