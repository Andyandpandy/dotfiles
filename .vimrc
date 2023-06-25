source $VIMRUNTIME/defaults.vim
syntax on

set nocompatible              " be iMproved, required
filetype off                  " required
filetype indent plugin on

set number
set relativenumber

set encoding=utf-8


set backspace=2
set nowritebackup
set noswapfile
set nobackup
set ruler
set showcmd
set showmode
set incsearch
set laststatus=2
set ttyfast
set hidden
set termwinsize=10x200

" Softtabs, 2 spaces
set autoindent
set tabstop=2
set shiftwidth=2
set shiftround
set nowrap
set textwidth=100
set noerrorbells
set novisualbell

set splitright
set splitbelow
"set diffopt+=vertical

" speed up syntax highlighting
set nocursorcolumn
set nocursorline


call plug#begin('~/.vim/plugged')

" Helpers
" adding surrounding quotes most often or paranthesis
Plug 'tpope/vim-surround'
" Automatically adds ending brackets etc.
Plug 'jiangmiao/auto-pairs'

" js
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
"Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
"Plug 'styled-components/vim-styled-components'

" css
" Shows colors in a css files on hex values etc.
Plug 'ap/vim-css-color'

" c#
Plug 'OmniSharp/omnisharp-vim'

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'javascript.jsx', 'typescript.tsx', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Linting
Plug 'dense-analysis/ale'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'           " Set up fzf and fzf.vim

" Theme
Plug 'sheerun/vim-polyglot'

" no good Plug 'tomasr/molokai'
" no good Plug 'aonemd/kuroi.vim'
" no good Plug 'gryf/wombat256grf'
" no good Plug 'sainnhe/edge'
" no good Plug 'cjgajard/patagonia-vim'
Plug 'sainnhe/gruvbox-material'


" Autocompletion
Plug 'neoclide/coc.nvim'
"Plug 'SirVer/ultisnips'

"Plug 'ycm-core/YouCompleteMe'

"Plug 'mlaursen/vim-react-snippets'

" Statusbar theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" simple exploring of project
Plug 'preservim/nerdtree'
"Plug 'ryanoasis/vim-devicons'

Plug 'stsewd/fzf-checkout.vim'

" Vim markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}


call plug#end()


set t_Co=256
set termguicolors

set background=dark
colorscheme gruvbox-material

let g:airline_theme='bubblegum'

" Set this variable to 1 to fix files when you save them.
"let g:ale_fix_on_save = 1
" In ~/.vim/vimrc, or somewhere similar.
"let g:ale_fixers = {
"\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'javascript': ['eslint'],
"\   'typescript': ['eslint'],
"\   'typescript.tsx': ['eslint', 'prettier']
"\}

" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
"let g:ale_completion_enabled = 1

"let g:ale_fixers = {
"\   'typescript': ['prettier', 'eslint'],
"\}

let g:ale_linters = {}
let g:ale_linters.typescript = ['eslint', 'tsserver']

let g:ale_typescript_prettier_use_local_config = 1

let g:ale_fix_on_save = 1

let g:ale_linters_explicit = 1

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" CoC extensions
"let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json', 'coc-omnisharp']

let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']
"let g:OmniSharp_server_use_mono = 1

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

if !empty(expand(glob("*.sln")))
  let g:coc_global_extensions += ['coc-omnisharp']
endif

" Sync because sometimes highlighting is broken for js/ts/jsx/tsx
" https://github.com/styled-components/vim-styled-components/issues/64
autocmd BufEnter *.{js,ts,jsx,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,ts,jsx,tsx} :syntax sync clear

" ================================================================
" => Normal key mappings
" ================================================================

" Typo fixes
nnoremap :W :w <return>
vnoremap :W :w <return>
nnoremap :Q :q <return>
vnoremap :Q :q <return>

nnoremap <C-s> :w <return>
inoremap <C-s> :w <return>
vnoremap <C-s> :w <return>

" new file buffer
nnoremap <c-p> :Files <return>

" buffers
nnoremap <c-w> :bd <return>

" Terminal
nnoremap <C-.> :terminal <return>
vnoremap <C-.> :terminal <return>
inoremap <C-.> :terminal <return>

tnoremap <Esc> <C-\><C-n>

" toggle nerdtree
map <C-b> :NERDTreeToggle<CR>

" Coc normal mappings
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" ================================================================
" => Leader key mappings
" ================================================================

let mapleader = " "

" git
noremap <leader>gc :GCheckout <return>
noremap <leader>gprs :!gh pr status <return>

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" window control
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>vs :vne <return>
noremap <leader>ss :split <return>
noremap <leader>n :new <return>
noremap <leader>c <c-w>c <return>
noremap <leader>p :Buffers <return>
"noremap <leader>q <c-w>q <return>

" terminal
noremap <leader>t :terminal <return>

" vim config
noremap <leader>vim :e ~/.vimrc <return>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>sf <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)
"
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
