set nocompatible " Disable vi-compatibility
set backspace=2
filetype plugin on
filetype indent on
set encoding=utf-8

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

set scrolloff=1
set incsearch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set autoindent
set nu
set undofile
syntax on
set wrap
set textwidth=150
set formatoptions=qrn1
set laststatus=2 " Always show the statusline
nmap ø :w<Esc>
nmap ö :w<Esc>
imap fd <Esc>
set winaltkeys=no
set clipboard=unnamed,unnamedplus
set notitle
" Shift-j/k inserts blank line below/above
nnoremap <S-k> m`O<esc>``
nnoremap <S-j> m`o<esc>``

" Vsplit ordnung
set splitright
"
" Jump to the last position when reopening a file
if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif
endif

""""""""""""""" MESSING AROUND WITH DIRECTORIES """"""""""""""""""
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup
" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
""""""""""" DONE MESSING AROUND WITH DIRECTORIES """"""""""""

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Use colors to signify if we're in insert mode or nor
au InsertEnter * hi StatusLine ctermfg=Red
au InsertLeave * hi StatusLine ctermfg=Green
hi StatusLine ctermfg=Green

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Recognize .h++ files as C++ source files
autocmd BufNewFile,BufRead *.h++ setfiletype cpp

set path+=**
set wildmenu
set wildmode=longest:full
