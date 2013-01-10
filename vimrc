" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good
" choice.
"              If you're a more advanced user, building your own .vimrc
" based
"              on this file is still a good idea.

"------------------------------------------------------------
" Pathogen setup wit submodules {{{1
" these options start the pathogen configuration on the bundle directory
" this is this way to keep pathogen under source control.
 runtime bundle/vim-pathogen/autoload/pathogen.vim
 execute pathogen#infect()
 Helptags

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
" set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
 filetype indent plugin on

" Enable syntax highlighting
 syntax on

 set t_Co=256
"------------------------------------------------------------
" Must have options {{{1

" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple
" files
" in the same editor window. Users can use multiple split windows or
" multiple
" tab pages to edit multiple files, but it is still best to enable an option
" to
" allow easier switching between files.

" One such option is the 'hidden' option, which allows you to re-use the
" same
" window and switch from an unsaved buffer without saving it first. Also
" allows
" you to keep an undo history for multiple files when re-using the same
" window
" in this way. Note that using persistent undo also lets you undo in
" multiple
" files even in the same window, but is less efficient and is actually
" designed
" for keeping undo history after closing Vim entirely. Vim will complain if
" you
" try to quit without saving, and swap files will keep you safe if your
" computer
" crashes.
 set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the
" same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
" Wildmenu completion {{{
 set wildmenu
 set wildmode=list:longest
 set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
 set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
 set wildignore+=*.luac                           " Lua byte code
 set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
 set wildignore+=*.pyc                            " Python byte code
 set wildignore+=*.spl                            " compiled spelling word lists
 set wildignore+=*.sw?                            " Vim swap files
 set wildignore+=*.DS_Store?                      " OSX bullshit
" }}}

" Show partial commands in the last line of the screen
 set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see
" the
" mapping of <C-L> below)
 set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1

" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
 set ignorecase
 set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
 set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled,
" keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
 set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
 set nostartofline

" Display the cursor position on the last line of the screen or in the
" status
" line of a window
 set ruler
"
" Always display the status line, even if only one window is displayed
 set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
 set confirm

" Use visual bell instead of beeping when doing something wrong
 set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
" set t_vb=
"
" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
"press <Enter> to continue"
 set cmdheight=2

" Display line numbers on the left
 set number

" Quickly time out on keycodes, but never time out on mappings
 set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
 set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1

" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
 set shiftwidth=2
 set softtabstop=2
 set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
" set shiftwidth=2
" set tabstop=2


"------------------------------------------------------------
" Mappings {{{1

" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
 map Y y$

 let mapleader=","
 " mostrar caracteres especiales
 set list
 set listchars=tab:▸\ ,eol:¬

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
 nnoremap <C-L> :nohl<CR><C-L>
"
"
" statusline {{{
   set statusline=
   set statusline+=%f\ %{SyntasticStatuslineFlag()}
   set statusline+=%{FugitiveStatuslineShort()}
   set statusline+=%<%h%m%r%=%-0.(%{HasPaste()}\%2*%{HasNeoComplcache()}\ L%03l/%L\ C%02c%V%)\%h%m%r%=%-16(\B%{BufferWidget()}\ %y%)
   set statusline+=%3*%P%=%{FileTime()}
   set rulerformat=%15(%c%V\ %p%%%)
   fun! FileTime() "{{{
        let ext=tolower(expand("%:e"))
        let fname=tolower(expand('%<'))
        let filename=fname . '.' . ext
        let msg=""
        let msg=msg." ".strftime("(Mod %b,%d %y %H:%M:%S)",getftime(filename))
        return msg
   endfunction
    "}}}
   fun! HasPaste() "{{{
       return &paste ? "paste" : ""
   endf "}}}
   fun! HasNeoComplcache() "{{{
      return !neocomplcache#is_locked() ? "nCC" : ""
   endf "}}}
   fun! FugitiveStatuslineShort() "{{{
      return substitute(fugitive#statusline(),"master","M","g")
   endf "}}}
" }}}
" NERDtree {{{
   nnoremap <silent><leader>n :NERDTreeToggle<CR>
   let NERDTreeShowBookmarks=1
" }}}
" Syntastic {{{
   let g:syntastic_enable_signs = 0
   let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
   let g:syntastic_mode_map = { 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['tex','html'] }
" }}}
" neocomplcache {{{
    let g:neocomplcache_enable_at_startup = 1
    "let g:neocomplcache_snippets_disable_runtime_snippets = 1
    let g:neocomplcache_snippets_dir='~/.vim/bundle/snipmate-snippets/snippets'
    nnoremap <silent><leader>nt :NeoComplCacheToggle<CR>
" }}}
" BufferWidget {{{
    let g:buffer_widget_view='bars'
" }}}
" Ack {{{
  " you have to install ack
  nn <leader>a :Ack! --nobinary <cword><CR>
" }}}
"------------------------------------------------------------
