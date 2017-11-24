if &compatible
    set nocompatible
endif

" Better leader, and ',,' is a ','
let mapleader = ','
let maplocalleader = ","
nnoremap <leader>, :normal ,<CR>:<CR>

inoremap jk <ESC>
"nnoremap ; :

" BS goto previous buffer
nnoremap <BS> <C-^>

autocmd InsertEnter * set timeoutlen=250
autocmd InsertLeave * set timeoutlen=1000

set number                      " Line numbers on
set relativenumber              " Relative numbers
set cursorline                  " Highlight current line

" ,/ turns off last search
nmap <silent> <leader>/ :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Autoindent whole file and return cursor to position
nmap <leader>ai mzgg=G`z`i

command Paste set paste | set nornu nonu
command NoPaste set nopaste | set rnu nu

" Allow saving of files as sudo when I forgot to start vim using sudo.
command SudoWrite w !sudo tee > /dev/null %

set updatetime=250

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
let dein_path = expand('~/.vim/dein')

if dein#load_state(dein_path)
    call dein#begin(dein_path)
    call dein#add('Shougo/dein.vim')

    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#add('Shougo/vimshell')
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

    "call dein#add('ctrlpvim/ctrlp.vim', { 'on_cmd' : 'CtrlPMRUFiles' })
    "call dein#add('FelikZ/ctrlp-py-matcher')
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    call dein#add('jreybert/vimagit', {'on_cmd': ['Magit', 'MagitOnly']})

    call dein#add('vim-syntastic/syntastic')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('christoomey/vim-tmux-navigator')

    "call dein#add('Raimondi/delimitMate', {'on_map' : { 'i' : ['(', '[', '{' ] }})
    "call dein#add('terryma/vim-multiple-cursors', { 'on_map' : { 'n' : ['<C-n>', '<C-p>'], 'x' : '<C-n>'}})
    "call dein#add('easymotion/vim-easymotion')

    call dein#add('airblade/vim-gitgutter')

    call dein#add('jsfaint/gen_tags.vim')
    call dein#add('majutsushi/tagbar')

    call dein#add('tpope/vim-repeat', {'on_map' : '.'})
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround', {
                \ 'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
    "call dein#add('tpope/vim-fugitive', {
    "            \ 'on_cmd': [ 'Git', 'Gstatus', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff', ] })

    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('mbbill/undotree')

    call dein#add('icymind/NeoSolarized')

    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('Shougo/denite.nvim')
    call dein#add('ozelentok/denite-gtags')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif


silent function! OSX()
return has('macunix')
endfunction
silent function! LINUX()
return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
return  (has('win32') || has('win64'))
endfunction


" ===== Defaults ======
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set synmaxcol=256
syntax sync minlines=256
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set guioptions=M
"set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " Visual spaces per tab
set softtabstop=4               " # of spaces per tab when editting
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
"set pastetoggle=<F12>           " pastetoggle (sane pindentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
set backspace=indent,eol,start
set complete-=i
set smarttab
set nobackup
set noswapfile

set nrformats-=octal                " Don't operate on octal numbers (helps with leading 0's)

"set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
" set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

set winminheight=0              " Windows can be 0 line high
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set smartcase                   " /Case sensitive when uc present
set gdefault
set wildmenu                    " Show list instead of just completing
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o " ignore some extensions for tab completion
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set sidescrolloff=5

set foldenable                  " Auto fold code
set foldlevelstart=10           " open most folds by default
set foldnestmax=10              " 10 nested fold max
set foldmethod=indent           " fold based on indent level

set list
set listchars=tab:▸\ ,trail:•,extends:#,nbsp:. " Highlight whitespace (tab:›\ ,,eol:¬,)
set display+=lastline
set autoread
set laststatus=2
set ruler

set lazyredraw                " More efficent redraw (needed to syntax + cursorline)

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Cursorline will have same background color in relative mode

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Remove trailing whitespaces and ^M chars
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql
            \ autocmd BufWritePre <buffer> call StripTrailingWhitespace()


" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &history < 1000
    set history=1000
endif

if &tabpagemax < 50
    set tabpagemax=50
endif

if !empty(&viminfo)
    set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

inoremap <C-U> <C-G>u<C-U>

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif


" =============== grep ===============
" bind K to grep word under cursor and quickfix
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

"if executable('rp')
"    set grepprg=rg\ --color=never
"elseif executable('ag')
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack-grep')
    set grepprg=ack-grep\ --nocolor\ -f
elseif executable('ack')
    set grepprg=ack\ --nocolor\ -f
endif


" =============== solarized ===============
set termguicolors
set background=dark
colorscheme NeoSolarized

"let g:solarized_termtrans=1
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


" =============== airline ===============
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'

let g:airline_powerline_fonts=1 " or use:
"let g:airline_left_sep='›'  " Slightly fancier than '>'
"let g:airline_right_sep='‹' " Slightly fancier than '<'

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = '%3p%% %3l/%L:%3v'


" =============== indent-guides ===============
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


" =============== ctags ===============
set tags=./tags;/,~/.vimtags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif


" =============== syntastic ===============
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" =============== tagbar ===============
nnoremap <silent> <leader>tt :TagbarToggle<CR>


" =============== undotree ===============
nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1


" =============== vim-tmux-navigator ===============
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-k> :TmuxNavigateDown<cr>
nnoremap <silent> <c-j> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>


" =============== fzf ===============
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
nnoremap <c-p> :FZF<cr>


" =============== ctrlp ===============
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

let g:ctrlp_working_path_mode = 'ra'
"nnoremap <silent> <D-t> :CtrlP<CR>
"nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

"if executable('rp')
"    let s:ctrlp_fallback = 'rg %s --hidden --color=never --glob ""'
"    let g:ctrlp_use_caching = 0
"elseif executable('ag')
if executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor --hidden -l -g ""'
    let g:ctrlp_use_caching = 0
elseif executable('ack-grep')
    let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
    let s:ctrlp_fallback = 'ack %s --nocolor -f'
elseif WINDOWS()
    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif

let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
            \ }

" CtrlP extensions
" let g:ctrlp_extensions = ['funky']
" nnoremap <Leader>fu :CtrlPFunky<Cr>

let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }


" =============== Deoplete ===============
let g:deoplete#enable_at_startup = 1

"Use TAB to complete when typing words, else inserts TABs as usual.
function! Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>


" =============== denite ===============
call denite#custom#var('file_rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" Change matchers.
call denite#custom#source(
    \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_cpsm'])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Define alias
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
        \ [ '.git/', '.ropeproject/', '__pycache__/',
        \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])


nnoremap <leader>a :DeniteCursorWord -buffer-name=gtags_context gtags_context<cr>
nnoremap <leader>d :DeniteCursorWord -buffer-name=gtags_def gtags_def<cr>
nnoremap <leader>r :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<cr>
nnoremap <leader>g :DeniteCursorWord -buffer-name=gtags_grep gtags_grep<cr>
nnoremap <leader>t :Denite -buffer-name=gtags_completion gtags_completion<cr>
nnoremap <leader>f :Denite -buffer-name=gtags_file gtags_file<cr>
nnoremap <leader>p :Denite -buffer-name=gtags_path gtags_path<cr>

autocmd QuickFixCmdPost *grep* cwindow

" vim:set ft=vim et sw=4:
