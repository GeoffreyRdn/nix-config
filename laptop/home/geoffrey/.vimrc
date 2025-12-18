" ~/.vimrc

set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

runtime! plugin/sensible.vim

set encoding=utf-8 fileencodings=
syntax on
syntax enable

" indentation
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

set number
set cc=80
set scrolloff=10

set wildmenu

set autoread
set autowrite

set list
set listchars=tab:»\ ,trail:·,eol:$

set termguicolors
colorscheme bat

autocmd Filetype make setlocal noexpandtab
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" per .git vim configs
" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository
" change syntax settings for this repository
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif

function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
 
autocmd BufWritePre *.[ch],*.hh,*.cc :call FormatBuffer()

