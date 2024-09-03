" Basic settings
set relativenumber           " Show relative line numbers
set number                   " Show absolute line number for the current line
syntax on                    " Enable syntax highlighting

" Mapping for inserting pairs of characters
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>

" Cursor and editing behavior
set cursorline               " Highlight the current line
set cursorcolumn             " Highlight the current column
set tabstop=4                " Set tab width to 4 spaces
set shiftwidth=4             " Indent by 4 spaces when using >> or <<
set expandtab                " Convert tabs to spaces
set nobackup                 " Disable backup files
set ignorecase               " Ignore case in search patterns
set smartcase                " Override ignorecase if search pattern contains uppercase letters
set showcmd                  " Display incomplete commands
set showmatch                " Highlight matching parentheses
set wildmenu                 " Visual autocomplete for command menu
set wildmode=list:longest    " Complete longest common string and list options

" Indentation settings
set smartindent              " Smart auto-indenting
set autoindent               " Copy indent from current line when starting a new line
set cindent                  " C-like auto-indenting
set indentexpr=              " Clear indent expression

" Plugin management via Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim', { 'as': 'dracula' }  " Dracula color scheme

call plug#end()

" Apply the Dracula color scheme
colorscheme dracula

" NERDTree key mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Additional recommended settings
set clipboard=unnamedplus    " Use the system clipboard for copy/paste
set undofile                 " Enable persistent undo
set hlsearch                 " Highlight search results
set incsearch                " Show search matches as you type
set splitbelow               " Horizontal splits will open below
set splitright               " Vertical splits will open to the right
