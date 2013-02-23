" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=100 " keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set cmdheight=2

set encoding=utf-8

" Maintain more context around the cursor
set scrolloff=3

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif

if has("gui_gtk2")
  set guifont=Neep\ 14
elseif has("gui_macvim")
  set guifont=Inconsolata:h18
end

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END

" autoreload vimrc when saving it; from Drew Neil's vimcast
autocmd bufwritepost .vimrc source $MYVIMRC

" avoid trailing whitespace - https://github.com/bbatsov/ruby-style-guide
autocmd BufWritePre * :%s/\s\+$//e

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

set guioptions-=T " disable toolbar
set statusline=%F%m%r%h%w\ [POS=%04l,%04v][%p%%]\ [TYPE=%Y]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2

let mapleader = ","

" Enable extended % matching
runtime macros/matchit.vim

" auto-open error window
let g:syntastic_auto_loc_list=1

",r brings up my .vimrc
nmap <leader>r :tabedit $MYVIMRC<CR>

" easier line completion
inoremap ^L ^X^L

" easier keyword completion
inoremap  

colorscheme ir_black
set background=dark

" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

" NERDtree
map <leader>n :NERDTree<cr>

set cursorline

" quickly nav to different windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Vertical split then hop to new buffer
":noremap ,v :vsp^M^W^W<cr>
:noremap ,v :vsplit^M^W^W<cr>:CommandT<cr>
:noremap ,h :split<cr>:CommandT<cr>

" in visual mode make indent reselect the selected text, and make tab indent as well
vmap > >gv
vmap <Tab> >gv
vmap < <gv
vmap <Tab> <gv

" softabs
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" don't worry about files changed on disk, just reload
set autoread

" no swap files!
set nobackup
set nowritebackup
set noswapfile

" searching and replacing
set hlsearch
set incsearch		" do incremental searching
set ignorecase
set smartcase  " ignore case if search pattern is all lowercase, case-sensitive otherwise
set gdefault " applies substitutions globally on lines.
set showmatch  " set show matching parenthesis

" disable search result highlighting when no longer needed
nmap <silent> <leader><space> :nohlsearch<CR>

" force 'magic' regexes, aka NORMAL regexes
nnoremap / /\v
vnoremap / /\v

set hidden " lets you open new files in a window without saving the buffer
set nowrap
set copyindent " copy the previous indentation on autoindenting
set number     " always show line numbers
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set visualbell " don't beep
set wildmenu " enhance command line completion
set wildmode=list:longest
set shortmess=atI " Stifle many interruptive prompts

" read http://nvie.com/posts/how-i-boosted-my-vim/ for how to use this
nnoremap ; :

" speed up command-T and other listings to ignore various unimportant directories
set wildignore+=*.o,*.obj,.git,vendor/**,log/**,tmp/**,oldcode/**,AngbandTk/**,*.pyc,.bundle/**,public/**

nmap <leader>b :tabedit<cr>:CommandT<cr>
nmap <leader>t :CommandT<cr>
nmap <leader>f :CommandTFlush<cr>
nmap <leader>o :only<cr>

" XML lint the current doc
nmap <leader>x :silent 1,$!xmllint --format --recover - 2>/dev/null

" Map Command-# and Ctrl-# to switch tabs
map  <D-0> 0gt
imap <D-0> <Esc>0gt
map  <C-0> 0gt
imap <C-0> <Esc>0gt
map  <D-1> 1gt
imap <D-1> <Esc>1gt
map  <C-1> 1gt
imap <C-1> <Esc>1gt
map  <D-2> 2gt
imap <D-2> <Esc>2gt
map  <D-3> 3gt
imap <D-3> <Esc>3gt
map  <D-4> 4gt
imap <D-4> <Esc>4gt
map  <D-5> 5gt
imap <D-5> <Esc>5gt
map  <D-6> 6gt
imap <D-6> <Esc>6gt
map  <D-7> 7gt
imap <D-7> <Esc>7gt
map  <D-8> 8gt
imap <D-8> <Esc>8gt
map  <D-9> 9gt
imap <D-9> <Esc>9gt

" use OS X clipboard
"vmap <D-c> y:call system("pbcopy", getreg("\""))<CR>
"nmap <D-v> :call setreg("\"",system("pbpaste"))<CR>p
"set clipboard=unnamed

" Command-T configuration
let g:CommandTMaxHeight=20

" all these files are ruby
au BufRead,BufNewFile {Gemfile,.autotest,Guardfile,Rakefile,Vagrantfile,Thorfile,config.ru,.*.rabl} set ft=ruby

nnoremap <leader>a :Ack<space>
nnoremap <leader><tab> :Scratch<cr>

" Map ,e to open files in the same directory as the current file
map <leader>e :e <C-R>=expand("%:h")<cr>/

" since iterm doesn't set TERM properly
let &t_Co=256

" copy current file bath to unnamed buffer
" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
:nmap cp :let @" = expand("%")<cr>

" don't search included files for autocompletion; http://stackoverflow.com/questions/2169645/vims-autocomplete-is-excruciatingly-slow
set complete-=i
let g:UltiSnipsNoPythonWarning = 1

map <leader>s :%s/

let g:syntastic_ruby_exec = "/Users/subelsky/.rvm/rubies/ruby-1.9.3-p194/bin/ruby"
