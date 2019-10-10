" Source Plugins
scriptencoding utf-8

call plug#begin()

Plug 'jiangmiao/auto-pairs'                    " Insert or delete brackets, parens, quotes in pair.
Plug 'tpope/vim-vinegar'                       " Add functionality to netrw
Plug 'tpope/vim-commentary'                    " Comment objects
Plug 'tpope/vim-repeat'                        " Enable . repeating for more
Plug 'tpope/vim-surround'                      " Surround objects with anything
Plug 'yuttie/comfortable-motion.vim'           " Physics-based smooth scrolling
Plug 'christoomey/vim-tmux-navigator'          " Navigate seamlessly between vim and tmux
Plug 'sickill/vim-pasta'                       " Context aware pasting
Plug 'Yggdroot/indentLine'                     " Vertical indent guide lines
Plug 'wincent/loupe'                           " More resonable search settings
Plug 'mattn/webapi-vim'                        " Interface to WEB APIs
Plug 'wincent/terminus'                        " Cursor shape change in insert and replace mode
                                               " Improved mouse support
                                               " Focus reporting (Reload buffer on focus if it has been changed externally )
                                               " Bracketed Paste mode
Plug 'vim-scripts/vim-auto-save'               " Enables auto save
Plug 'ntpeters/vim-better-whitespace'          " Highlight trailing whitespace in red
Plug 'editorconfig/editorconfig-vim'           " Makes use of editorconfig files
Plug 'tpope/vim-projectionist'                 " Projection and alternate navigation
Plug 'machakann/vim-highlightedyank'           " Highlight yanked text
Plug 'janko-m/vim-test'                        " Context start tests
Plug 'vim-scripts/ReplaceWithRegister'         " Replace with registery content

                                               " TEXTOBJECTS
Plug 'kana/vim-textobj-indent'                 " Creates an object of the current indent level
Plug 'kana/vim-textobj-line'                   " Creates the line object to exclude whitespace before the line start
Plug 'kana/vim-textobj-user'                   " Enables the creation of new objects

                                               " FUZZY FILESEARCH
Plug 'junegunn/fzf',
            \ { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

                                               " GIT PLUGINS
Plug 'airblade/vim-gitgutter'                  " Shows changed lines compared to last git commit
Plug 'tpope/vim-fugitive'                      " Git wrapper
Plug 'shumphrey/fugitive-gitlab.vim'           " GitLab fugitive handler
Plug 'tpope/vim-rhubarb'                       " Github fugitive handler

" THEME AND STATUSLINE
Plug 'altercation/vim-colors-solarized'        " Solarized theme for vim
Plug 'vim-airline/vim-airline'                 " Status line configuration
Plug 'vim-airline/vim-airline-themes'          " Status line themes
Plug 'edkolev/tmuxline.vim'                    " Makes tmux status line match vim status line

call plug#end()

" Basic settings
syntax enable             " enable syntax highlighting
colorscheme solarized     " solarized colorscheme
set background=dark       " solarized dark
set termguicolors
set expandtab             " to insert space characters whenever the tab key is pressed
set shiftwidth=2          " number of spaces used when indenting
set softtabstop=4         " number of spaces used when indenting using tab
set tabstop=4             " Number of spaces that a <Tab> in the file counts for
set fileencodings=utf-8   " set output encoding of the file that is written
set clipboard=unnamedplus " everything you yank in vim will go to the unnamed register, and vice versa.
set number relativenumber " each line in your file is numbered relative to the line you’re currently on
set breakindent           " brake lines to the indent level
set linebreak             " brake lines at words
set hidden                " bufferswitching without having to save first.
set splitbelow            " Creates new splits below
set splitright            " Creates new splits to the right
set updatetime=250        " Time in milliseconds between saving of the swap-file, also uppdates gitgutter
filetype plugin on        " Enable use of filespesiffic settings files
set foldmethod=indent     " Fold on indentations
set foldlevel=99          " The level that is folded when opening files
set diffopt=vertical      " Diff opens side by side
set lazyredraw            " Don't bother updating screen during macro playback
set scrolloff=3           " Start scrolling 3 lines before edge of window
set cursorline            " Highlights the line the cursor is on
set shortmess+=A          " don't give the ATTENTION message when an existing swap file is found.
set inccommand=split      " enables live preview of substitutions

augroup general_autocmd

  " Autosave on focus change or buffer change (terminus plugin takes care of reload)
  autocmd BufLeave,FocusLost * silent! wall

  " Open files with cursor at last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Start git commit editing in insert mode
  autocmd FileType gitcommit startinsert

augroup END

" Underline matching bracket and remove background color
hi MatchParen cterm=underline ctermbg=none

" THEME SETTINGS
" SingColumn color and LineNr cleared
highlight clear LineNr
" set color for the terminal cursor in terminal mode
hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" Configure hidden files
if !isdirectory($HOME.'/.config/nvim/tmp')
    call mkdir($HOME.'/.config/nvim/tmp', '', 0700)
endif
if !isdirectory($HOME.'/.config/nvim/tmp/backup')
    call mkdir($HOME.'/.config/nvim/tmp/backup', '', 0700)
endif
if exists('$SUDO_USER')
  set nobackup                               " don't create root-owned files
  set nowritebackup                          " don't create root-owned files
else
  set backupdir+=~/.config/nvim/tmp/backup   " keep backup files out of the way
  set backupdir+=.
endif

if !isdirectory($HOME.'/.config/nvim/tmp/swap')
    call mkdir($HOME.'/.config/nvim/tmp/swap', '', 0700)
endif
if exists('$SUDO_USER')
  set noswapfile                             " don't create root-owned files
else
  set directory+=~/.config/nvim/tmp/swap//   " keep swap files out of the way
  set directory+=.
endif

if !isdirectory($HOME.'/.config/nvim/tmp/undo')
    call mkdir($HOME.'/.config/nvim/tmp/undo', '', 0700)
endif
if exists('$SUDO_USER')
  set noundofile                             " don't create root-owned files
else
  set undodir+=~/.config/nvim/tmp/undo       " keep undo files out of the way
  set undodir+=.
  set undofile                               " actually use undo files
endif

if !isdirectory($HOME.'/.config/nvim/tmp/viminfo')
    call mkdir($HOME.'/.config/nvim/tmp/viminfo', '', 0700)
endif
if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                             " don't create root-owned files
  else
    set viminfo+=n~/.config/nvim/tmp/viminfo " override ~/.viminfo default
    if !empty(glob('~/.config/nvim/tmp/viminfo'))
      if !filereadable(expand('~/.config/nvim/tmp/viminfo'))
        echoerr 'warning: ~/.config/nvim/tmp/viminfo exists but is not readable'
      endif
    endif
  endif
endif

" KEYMAPPINGS
"===========
" Leader
nnoremap <SPACE> <Nop>
let g:mapleader = ' '

" Runs current line as a command in zsh and outputs stdout to file
noremap Q !!zsh<CR>

"To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

" Remap visual block
nnoremap <Leader>v <c-v>

" Remap H L
nnoremap H 5H
nnoremap L 5L

" H in commandlinemode now runs Helptags
command! H Helptags

" GitGutter settings
nmap <Leader>ca <Plug>(GitGutterStageHunk) <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
nmap <Leader>cu <Plug>(GitGutterUndoHunk)
nmap <Leader>cp <Plug>(GitGutterPreviewHunk)

" Projections alternate binding
map <Leader>a :A<cr>

" ALE
nmap <Leader>p <Plug>(ale_fix)
" nmap ]e <Plug>(ale_next_wrap) zz
" nmap [e <Plug>(ale_previous_wrap)
" nmap <Leader>e <Plug>(ale_detail)

" Toggle Quickfix Window
nmap <Leader>q <Plug>window:quickfix:toggle

" Close Preview window
nmap <silent><Leader>w :pclose<CR>

" Search for selected text using git grep in current project
vnoremap <Leader>s y:Ggrep "<c-r>""

" vim-test
nmap <Leader>t :TestNearest<CR>


" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#max_list = 20
" close the preview window when you're not using it
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Deoplete sources
set completeopt=longest,menuone,preview

" auto-pairs settings
scriptencoding utf-8
let g:AutoPairsShortcutFastWrap='<C-e>'

" Ultisnips settings
let g:UltiSnipsExpandTrigger='<C-Space>'
let g:UltiSnipsJumpForwardTrigger='<C-Space>'
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Indentline settings
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'abap', 'vim', 'json', 'snippets', 'fzf']
let g:indentLine_char = '⎸▏'

" vim-auto-save settins
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" fugitive-gitlab.vim settings
let g:fugitive_gitlab_domains = ['https://innersourcs', 'https://innersource.soprasteria.com']

" EditorConfig settings
" To ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" vim-test
let test#strategy = "neovim"
let test#neovim#term_position = "vsplit"

function! s:GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleLocationList()
  let curbufnr = winbufnr(0)
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if curbufnr == bufnum
      lclose
      return
    endif
  endfor

  let winnr = winnr()
  let prevwinnr = winnr("#")

  let nextbufnr = winbufnr(winnr + 1)
  try
    lopen
  catch /E776/
      echohl ErrorMsg 
      echo "Location List is Empty."
      echohl None
      return
  endtry
  if winbufnr(0) == nextbufnr
    lclose
    if prevwinnr > winnr
      let prevwinnr-=1
    endif
  else
    if prevwinnr > winnr
      let prevwinnr+=1
    endif
  endif
  " restore previous window
  exec prevwinnr."wincmd w"
  exec winnr."wincmd w"
endfunction

function! ToggleQuickfixList()
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  if exists("g:toggle_list_copen_command")
    exec(g:toggle_list_copen_command)
  else
    copen
  endif
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <script> <silent> <leader>e :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>


" ESC to close fzf buffer
augroup fzf_esc_close
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END

map <expr> <Leader>f system('git rev-parse --is-inside-work-tree') =~ 'true' ? ':GitLsFiles<cr>' : ':Files<cr>'
map <Leader>F :Files
map <Leader>b :Buffers<cr>
map <Leader>l :Ag<cr>
map <Leader>H :Helptags<cr>
map <Leader>m :Marks<cr>
map <Leader>g :GFiles?<cr>

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

" Created new GitLsFiles that does the same as GFiles with a preview
command! -bang -nargs=0 -complete=dir GitLsFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
