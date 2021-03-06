if &compatible
    set nocompatible
endif

" Better leader, and ',,' is a ','
let mapleader = ','
let maplocalleader = ","
nnoremap <leader>, :normal ,<CR>:<CR>

inoremap jk <ESC>
"vnoremap jk <ESC>

nnoremap ; :

set updatetime=250

autocmd InsertEnter * set timeoutlen=250
autocmd InsertLeave * set timeoutlen=1000

set number                      " Line numbers on
"set relativenumber              " Relative numbers
"set cursorline                  " Highlight current line

" CR turns off last search
"nmap <silent> <CR> :noh<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR> :redraw!<CR>
nnoremap <silent> \ :noh<return>

" Automatically equalize splits on window resize (like tmux zoom)
autocmd VimResized * wincmd =

" Fix when syntax highlight goes awry
"nnoremap <silent> <leader>S :syntax sync fromstart<CR>
"autocmd FileType markdown syntax sync fromstart

" Autoindent whole file and return cursor to position
nmap <leader>ai mzgg=G`z`i

" Command to convert a file to Unit format
command ToUnix set ff=unix

vnoremap > >gv
vnoremap < <gv

"nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> + :resize +1<CR>
"nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> - :resize -1<CR>

command Paste set paste | set signcolumn=no | GitGutterDisable | set nornu nonu
command NoPaste set nopaste | set signcolumn=yes | GitGutterEnable | set rnu nu

" Allow saving of files as sudo when I forgot to start vim using sudo.
command SudoWrite w !sudo tee > /dev/null %

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength '\%>100v.\+'

set undofile
set undodir=~/.vim/undo//

set backupdir=~/.vim/backup//
if !has('nvim')
    set backup
else
    " Normally we would want to have it turned on, but See bug and workaround below.
    " OBS: It's a known-bug that backupdir is not supporting the correct double slash filename
    " expansion see: https://code.google.com/p/vim/issues/detail?id=179
    set nobackup

    " This is the workaround for the backup filename expansion problem.
    autocmd BufWritePre * :call SaveBackups()

    function! SaveBackups()
        if expand('%:p') =~ &backupskip | return | endif

        " If this is a newly created file, don't try to create a backup
        if !filereadable(@%) | return | endif

        for l:backupdir in split(&backupdir, ',')
            :call SaveBackup(l:backupdir)
        endfor
    endfunction

    function! SaveBackup(backupdir)
        let l:filename = expand('%:p')
        if a:backupdir =~ '//$'
            let l:backup = escape(substitute(l:filename, '/', '%', 'g')  . &backupext, '%')
        else
            let l:backup = escape(expand('%') . &backupext, '%')
        endif

        let l:backup_path = a:backupdir . l:backup
        :silent! execute '!cp ' . resolve(l:filename) . ' ' . l:backup_path
    endfunction

    " Other way to fix this
    "autocmd BufWritePre * let &backupext = substitute(expand('%:p:h'), '/', '%', 'g')
endif

" - font type and size setting.
if has('win32')
    set guifont=Consolas:h12                            " Win32
elseif has('gui_macvim')
    set guifont=FuraCodeNerdFontCompleteM-Regular:h12   " OSX
else
    set guifont=Monospace\ 12                           " Linux
endif

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

    call dein#add('junegunn/vim-easy-align')
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    call dein#add('vim-syntastic/syntastic')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('HunterWare/tmux-navigate')

    call dein#add('tmux-plugins/vim-tmux-focus-events')

    "call dein#add('Raimondi/delimitMate', {'on_map' : { 'i' : ['(', '[', '{' ] }})
    "call dein#add('terryma/vim-multiple-cursors', {
    "       \ 'on_map' : { 'n' : ['<C-n>', '<C-p>'], 'x' : '<C-n>'}})

    call dein#add('airblade/vim-gitgutter')

    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('skywind3000/gutentags_plus')

    call dein#add('majutsushi/tagbar')

    call dein#add('tpope/vim-repeat', {'on_map' : '.'})
    call dein#add('tpope/vim-abolish')
    call dein#add('tpope/vim-fugitive', {
            \ 'on_cmd': ['Git', 'Gstatus', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff']})
    call dein#add('tpope/vim-surround', {
            \ 'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
    call dein#add('tpope/vim-unimpaired')

    call dein#add('justinmk/vim-sneak', {'depends' : 'vim-repeat'})
    call dein#add('rhysd/clever-f.vim')

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


" Utility checks for OS dependance
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
filetype plugin indent on       " Automatically detect file types.
set autoindent                  " Indent to level of prev line for txt files
set cino+=(0
set shiftwidth=4                " Use indents of 4 spaces
set tabstop=8                   " Visual spaces per tab
set softtabstop=4               " # of spaces per tab when editting
set expandtab                   " Tabs are spaces, not tabs
syntax on                       " Syntax highlighting
set synmaxcol=256
syntax sync minlines=256
set mouse=a                     " Automatically enable mouse usage
set mousehide                   " Hide the mouse cursor while typing
scriptencoding utf-8
set guioptions=M
"set nowrap                      " Do not wrap long lines
set nojoinspaces                " Prevents inserting spaces after punctuation on a join
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
set backspace=indent,eol,start
set complete-=i
set noswapfile
set noshowmode                  " Don't need this with a statusline

set nrformats-=octal            " Don't operate on octal numbers (helps with leading 0's)

"set autowrite                   " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore         " Allow for cursor beyond last character
"set spell                       " Spell checking on
set hidden                      " Allow buffer switching without saving
set iskeyword-=.                " '.' is an end of word designator
set iskeyword-=#                " '#' is an end of word designator
set iskeyword+=-                " '-' is not end of word designator

set winminheight=0              " Windows can be 0 line high
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Show all matches of incsearch
set ignorecase                  " Case insensitive search
set infercase                   " Smarter case sensitive search
set smartcase                   " /Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o " ignore some extensions for tab completion
set wildmode=longest:full,full  " tab compl: compl longest common part and list
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=0                 " Minimum lines to keep above and below cursor
set sidescrolloff=0

set foldenable                  " Auto fold code
set foldlevelstart=10           " open most folds by default
set foldnestmax=10              " 10 nested fold max
set foldmethod=indent           " fold based on indent level
set breakindent                 " wrap lines at current indent
set showbreak=\\\\\             " wrap marker

set list
set listchars=tab:▸\ ,trail:•,extends:#,nbsp:. " Highlight whitespace (tab:›\ ,,eol:¬,)
set display+=lastline
set autoread
set laststatus=2
set ruler

set lazyredraw                  " More efficent redraw (needed to syntax + cursorline)

"set signcolumn=yes              " always show signcolumn
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd FileType tagbar,nerdtree setlocal signcolumn=no

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Cursorline will have same background color in relative mode

" Wrapped lines goes down/up to next row, rather than next line in file
" long jumps are relative (skip wrapped lines) and jumps show in jumplist
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

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
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql,vim
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

" Ensure C-U and C-W are undoable
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" use tmux over OSX clipboard if we are in it. You want this before setting
" the clipboard variable
if has('nvim') && exists('$TMUX') && executable('tmux')
    let g:clipboard = {
          \   'name': 'myClipboard',
          \   'copy': {
          \      '+': 'tmux load-buffer -',
          \      '*': 'tmux load-buffer -',
          \    },
          \   'paste': {
          \      '+': 'tmux save-buffer -',
          \      '*': 'tmux save-buffer -',
          \   },
          \   'cache_enabled': 1,
          \ }
endif

" yank to clipboard
if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard (+ reg)
    if has("unnamedplus") " X11 support (* reg)
        set clipboard+=unnamedplus
    endif
endif

" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif


" =============== vim-sneak ===============

let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#label_esc = "<CR>"

"nmap f <Plug>Sneak_f
"nmap F <Plug>Sneak_F
"xmap f <Plug>Sneak_f
"xmap F <Plug>Sneak_F
"omap f <Plug>Sneak_f
"omap F <Plug>Sneak_F
"
"nmap t <Plug>Sneak_t
"nmap T <Plug>Sneak_T
"xmap t <Plug>Sneak_t
"xmap T <Plug>Sneak_T
"omap t <Plug>Sneak_t
"omap T <Plug>Sneak_T

" =============== clever-f ===============

let g:clever_f_chars_match_any_signs = ';'


" =============== vim-easy-align ===============

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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
" Helps with vim inside of screen/tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set termguicolors
set background=dark
colorscheme NeoSolarized

"let g:solarized_termtrans=1
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


" =============== airline ===============
let g:airline_theme='solarized'

let g:airline_powerline_fonts=1

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = '%3p%% %3l/%L:%3v'

let g:airline#extensions#branch#enabled = 0
"let g:airline#extensions#hunks#enabled = 0


" =============== indent-guides ===============
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


" =============== syntastic ===============
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_debug = 3

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_c_include_dirs = [ $WS.'/ifcs/include',
                                \  $WS.'/ifcs/src',
                                \  $WS.'/ifcs/drivers/src/linux_module/ipd_enet',
                                \  $WS.'/ifcs/test/arm/include',
                                \  $WS.'/ifcs/test/cengine/include',
                                \  $WS.'/pen/include',
                                \  $WS.'/pen/include/emulation',
                                \  $WS.'/pen/include/emulation_cmn',
                                \  $WS.'/pen/include/emulation_k2',
                                \  $WS.'/pen/include/emulation_tl',
                                \  $TARGET_KERNEL.'/include',
                                \ '../include',
                                \'include' ]
let g:syntastic_c_compiler_options = '-DMCUNUM=0 -std=c99'
let g:syntastic_c_remove_include_errors = 1

let g:syntastic_cpp_include_dirs = [ $ZEBU_ROOT.'/include',
                                \ $ZEBU_IP_ROOT.'/include']
let g:syntastic_cpp_compiler_options = '-D_GLIBCXX_USE_CXX11_ABI=0'

"disable syntastic on a per buffer basis (some work files blow it up)
function! SyntasticDisableBuffer()
    let b:syntastic_skip_checks = 1
    SyntasticReset
    echo 'Syntastic disabled for this buffer'
endfunction
command! SyntasticDisableBuffer call SyntasticDisableBuffer()


" =============== tagbar ===============
nnoremap <silent> <leader>tt :TagbarToggle<CR>

let g:tagbar_zoomwidth = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_previewwin_pos = "aboveleft"
"let g:tagbar_autopreview = 1


" =============== undotree ===============
nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1


" =============== fzf ===============
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)


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


call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Use Ag to search for files from current directory
call denite#custom#var('file/rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Use git to seach for files in project
call denite#custom#var('file/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Change matchers.
call denite#custom#source(
    \ 'file_git', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_fuzzy'])

call denite#custom#option('default', 'prompt', '➤ ')

function FindProjectRoot()
    let l:scm = {'type': '', 'root': ''}
    let l:scm_list = ['.root', '.git', '.hg', '.svn']

    for l:item in l:scm_list
        let l:dir = finddir(l:item, '.;')
        if !empty(l:dir)
            let l:scm['type'] = l:item
            let l:scm['root'] = substitute(l:dir, '/' . l:scm['type'], '', 'g')
            return l:scm
        endif
    endfor

    return l:scm
endfunction

function DoDenite()
    let l:result = FindProjectRoot()
    if (l:result['type'] ==? '.git')
        execute "DeniteProjectDir -path=". l:result['root'] "file/git"
    else
        execute "DeniteProjectDir -path=". l:result['root'] "file/rec"
    endif
endfunction

nnoremap <silent> <C-p> :<C-u>call DoDenite()<CR>

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

" =============== Terminal ===============
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk  <C-\><C-n>
endif


" =============== gutentags ===============
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1


" =============== gitgutter ===============
let g:gitgutter_max_signs=1000

" vim:set ft=vim et sw=4:
