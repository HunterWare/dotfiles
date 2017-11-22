;; ============================================================================
;; Loads
;; ============================================================================
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(mapc
 (lambda (package)
   (or (package-installed-p package)
       (package-install package)))
 '(powerline helm-ag color-theme-solarized dracula-theme delight realgud diminish helm-descbinds helm-git helm-ls-git helm-projectile highlight-indent-guides magit helm-cscope helm-gtags helm zenburn-theme nlinum diffview other-frame-window python))

;; ============================================================================
;; Theme
;; ============================================================================
;(setq ns-use-srgb-colorspace nil)

(require 'powerline)
(powerline-default-theme)

(setq powerline-color1 "grey22")
(setq powerline-color2 "grey40")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:inherit region :foreground "white"))))
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil))))
 '(which-func ((t nil))))

(load-theme 'solarized t)
;(load-theme 'dracula t)

;; ============================================================================
;; Helm
;; ============================================================================
(require 'helm-config)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-enable-caching t)

(with-eval-after-load 'helm-projectile
  (defvar helm-source-file-not-found
    (helm-build-dummy-source
        "Create file"
      :action (lambda (cand) (find-file cand))))
  (add-to-list 'helm-projectile-sources-list helm-source-file-not-found t))


(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-projectile)

;(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'go-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'python-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'ruby-mode-hook (lambda () (helm-gtags-mode)))

(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-l") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-f") 'helm-gtags-find-files)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))

;(require 'helm-descbinds)
;(helm-descbinds-mode)

(helm-mode 1)

;; ============================================================================
;; indent guides
;; ===========================================================================

;(require 'highlight-indent-guides)
;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;(setq highlight-indent-guides-auto-enabled nil)

;(setq highlight-indent-guides-method 'character)
;(setq highlight-indent-guides-character ?\┆)

;; ============================================================================
;; Misc Packages
;; ============================================================================

;; Version Control
;(require 'vc-hooks)
(setq vc-handled-backends nil)

;; Which function in modeline
(load "which-func")
(which-func-mode)
(add-to-list 'load-path (concat (expand-file-name "~hware") "/emacs"))

(whitespace-mode)

(require 'delight)
(delight '((abbrev-mode " Abv" abbrev)
           (helm-mode " Hm" "helm-mode")
           (python-mode "Py" "python-mode")
           (helm-gtags-mode " HmG" "helm-gtags")
           (emacs-lisp-mode "El" :major)))

;; ============================================================================
;; Misc Setup
;; ============================================================================

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;; Set up the keyboard so the delete key on both the regular keyboard and the
;; keypad delete the character under the cursor and to the right under X,
;; instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

;; Always only ask y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; rsync: match subdirectories and python files, in order to get *.py and */*.py
(setq compile-command "rsync -avz --include '*/' --include '*.py' --exclude '*' $PROJ_ROOT/sw/ifcs/shell/ edk4:hware/")

;:* don't invert colors when grabbing a password
;:  (because sometimes it screws up and leaves the frame
;:  with dorked up colors).
(setq passwd-invert-frame-when-keyboard-grabbed nil)

;; set the TERM to something colorgcc will understand
(setenv "TERM" "emacs")

;; ============================================================================
;; Remote Editing
;; ============================================================================

;(require 'tramp)
;(require 'tramp-util)
;(setq tramp-default-method "ssh")

;; ============================================================================
;; XCSCOPE
;; ===========================================================================

;; (require 'xcscope)
;; (cscope-setup)

;; ;(define-key global-map "\C-\\" nil)
;; (add-hook 'cscope-minor-mode-hooks
;;           '(lambda ()
;; 	     (define-key global-map "\C-\\" nil)
;;              (define-key global-map "\C-\\s" 'cscope-find-this-symbol)

;; 	     (define-key global-map "\C-\\s" 'cscope-find-this-symbol)
;; 	     (define-key global-map "\C-\\d" 'cscope-find-global-definition)
;; 	     (define-key global-map "\C-\\g" 'cscope-find-global-definition)
;; 	     (define-key global-map "\C-\\G" 'cscope-find-global-definition-no-prompting)
;; 	     (define-key global-map "\C-\\=" 'cscope-find-assignments-to-this-symbol)
;; 	     (define-key global-map "\C-\\c" 'cscope-find-functions-calling-this-function)
;; 	     (define-key global-map "\C-\\C" 'cscope-find-called-functions)
;; 	     (define-key global-map "\C-\\t" 'cscope-find-this-text-string)
;; 	     (define-key global-map "\C-\\e" 'cscope-find-egrep-pattern)
;; 	     (define-key global-map "\C-\\f" 'cscope-find-this-file)
;; 	     (define-key global-map "\C-\\i" 'cscope-find-files-including-file)

;; 	     (define-key global-map "\C-\\b" 'cscope-display-buffer)
;; 	     (define-key global-map "\C-\\B" 'cscope-display-buffer-toggle)
;; 	     (define-key global-map "\C-\\n" 'cscope-history-forward-line-current-result)
;; 	     (define-key global-map "\C-\\N" 'cscope-history-forward-file-current-result)
;; 	     (define-key global-map "\C-\\p" 'cscope-history-backward-line-current-result)
;; 	     (define-key global-map "\C-\\P" 'cscope-history-backward-file-current-result)
;; 	     (define-key global-map "\C-\\u" 'cscope-pop-mark)

;; 	     (define-key global-map "\C-\\a" 'cscope-set-initial-directory)
;; 	     (define-key global-map "\C-\\A" 'cscope-unset-initial-directory)

;; 	     (define-key global-map "\C-\\L" 'cscope-create-list-of-files-to-index)
;; 	     (define-key global-map "\C-\\I" 'cscope-index-files)
;; 	     (define-key global-map "\C-\\E" 'cscope-edit-list-of-files-to-index)
;; 	     (define-key global-map "\C-\\W" 'cscope-tell-user-about-directory)
;; 	     (define-key global-map "\C-\\S" 'cscope-tell-user-about-directory)
;; 	     (define-key global-map "\C-\\T" 'cscope-tell-user-about-directory)
;; 	     (define-key global-map "\C-\\D" 'cscope-dired-directory)
;; 	     ))

;; ============================================================================
;; Modes
;; ============================================================================

(setq auto-mode-alist
      '(("\\.c\\'" . c-mode)
        ("\\.h\\'" . c-mode)
        ("\\.idl\\'" . c++-mode)
        ("\\.cc\\'" . c++-mode)
        ("\\.hh\\'" . c++-mode)
        ("\\.hpp\\'" . c++-mode)
        ("\\.C\\'" . c++-mode)
        ("\\.H\\'" . c++-mode)
        ("\\.cpp\\'" . c++-mode)
        ("\\.[cC][xX][xX]\\'" . c++-mode)
        ("\\.hxx\\'" . c++-mode)
        ("\\.c\\+\\+\\'" . c++-mode)
        ("\\.h\\+\\+\\'" . c++-mode)
        ("\\.m\\'" . objc-mode)
        ("\\.java\\'" . java-mode)
        ("\\.ma?k\\'" . makefile-mode)
        ("\\(M\\|m\\|GNUm\\)akefile\\(\\.in\\)?" . makefile-mode)
        ("\\.am\\'" . makefile-mode)
        ("\\.mms\\'" . makefile-mode)
        ("\\.s\\'" . asm-mode)
        ("\\.S\\'" . asm-mode)
        ("\\.inc\\'" . asm-mode)
        ("ChangeLog\\'" . change-log-mode)
        ("change\\.log\\'" . change-log-mode)
        ("changelo\\'" . change-log-mode)
        ("ChangeLog\\.[0-9]+\\'" . change-log-mode)
        ("changelog\\'" . change-log-mode)
        ("changelog\\.[0-9]+\\'" . change-log-mode)
        ("\\$CHANGE_LOG\\$\\.TXT" . change-log-mode)
        ("\\.[ck]?sh\\'\\|\\.shar\\'\\|/\\.z?profile\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\(bash_profile\\|z?login\\|bash_login\\|z?logout\\)\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\(bash_logout\\|[kz]shrc\\|bashrc\\|t?cshrc\\|esrc\\)\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\([kz]shenv\\|xinitrc\\|startxrc\\|xsession\\)\\'" . sh-mode)
        ("\\.article\\'" . text-mode)
        ("\\.letter\\'" . text-mode)
        ("\\.tar\\'" . tar-mode)
        ("\\.diff\\'" . diff-mode)
        ("\\.\\(arc\\|zip\\|lzh\\|zoo\\|jar\\)\\'" . archive-mode)
        ("\\.\\(ARC\\|ZIP\\|LZH\\|ZOO\\|JAR\\)\\'" . archive-mode)
        ("\\.y\\'" . c-mode)
        ("\\.lex\\'" . c-mode)
        ("\\.l\\'" . lisp-mode)
        ("\\.lsp\\'" . lisp-mode)
        ("\\.lisp\\'" . lisp-mode)
        ("\\.ml\\'" . lisp-mode)
        ("\\.el\\'" . emacs-lisp-mode)
        ("[]>:/\\]\\..*emacs\\'" . emacs-lisp-mode)
        ("\\`\\..*emacs\\'" . emacs-lisp-mode)
        ("[:/]_emacs\\'" . emacs-lisp-mode)
        ("\\.py\\'" . python-mode)
        ("\\.rb\\'" . ruby-mode)))

;; ============================================================================
;; CC-Mode
;; ============================================================================
(setq c-recognize-knr-p nil)
(c-set-offset 'statement-case-open '+)

;; ============================================================================
;; Sub-Process & Compile Helpers
;; ============================================================================

;; function which allows you to set base dir for grep/compile only
(defun in-directory (dir)
  "Runs execute-extended-command with default-directory set to the given directory."
  (interactive "DIn directory: ")
  (let ((default-directory dir))
    (call-interactively 'execute-extended-command)))
(global-set-key [(meta X)] 'in-directory)

(setq compilation-auto-jump-to-first-error 't)

;; ============================================================================
;; Misc
;; ============================================================================
;; make cursor stay in the same column when scrolling
(defadvice scroll-up (around ewd-scroll-up first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

(defadvice scroll-down (around ewd-scroll-down first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

;;* manual follows xref instead of opening a new buffer
;; Glynn Clements <glynn @ sensei.co.uk>
(defun Manual-follow-xref (&optional name-or-event)
  "Invoke `manual-entry' on the cross-reference under the mouse.
   When invoked noninteractively, the arg may be an xref string to parse instead."
  (interactive "e")
  (if (eventp name-or-event)
      (let* ((p (event-point name-or-event))
             (extent (and p (extent-at p
                                       (event-buffer name-or-event)
                                       'highlight)))
             (data (and extent (extent-property extent 'man))))
        (if (eq (car-safe data) 'Manual-follow-xref)
            (eval data)
            (error "no manual cross-reference there.")))
      (let ((buff (current-buffer)))
        (or (and (manual-entry name-or-event)
                 (or (eq (current-buffer) buff)
                     (kill-buffer buff)))
            ;; If that didn't work, maybe it's in a different section than the
            ;; man page writer expected.  For example, man pages tend assume
            ;; that all user programs are in section 1, but X tends to generate
            ;; makefiles that put things in section "n" instead...
            (and (string-match "[ \t]*([^)]+)\\'" name-or-event)
                 (progn
                   (message "No entries found for %s; checking other sections..."
                            name-or-event)
                   (and (manual-entry
                         (substring name-or-event 0 (match-beginning 0)) nil t)
                        (or (eq (current-buffer) buff)
                            (kill-buffer buff)))))))))

;;* Title of the X window corresponding to the selected frame
;: This changes the variable which controls the text that goes
;: in the top window title bar.  (However, it is not changed
;: unless it currently has the default value, to avoid
;: interfering with a -wn command line argument I may have
;: started emacs with.)
(if (equal frame-title-format "%S: %b")
    (setq frame-title-format
          (concat "XEmacs: %b")))

;; make compiler in a new frame.
;(setq special-display-buffer-names
;   (cons "*compilation*" special-display-buffer-names))
;(setq special-display-buffer-names
;   (cons "*cscope*" special-display-buffer-names))
;(setq special-display-buffer-names
;   (cons "*igrep*" special-display-buffer-names))
;(setq special-display-buffer-names
;   (cons "*cvs*" special-display-buffer-names))

(setq same-window-buffer-names
   (cons "*Buffer List*" special-display-buffer-names))

(add-hook 'comint-output-filter-functions
    'comint-postoutput-scroll-to-bottom)

(setq-default comint-scroll-show-maximum-output t)

(defvar c++-header-ext-regexp "\\.\\(hpp\\|h\\|\hh\\|H\\)$")
(defvar c++-source-ext-regexp "\\.\\(cpp\\|c\\|\cc\\|C\\)$")
(defvar c++-source-extension-list '("c" "cc" "C" "cpp" "c++"))
(defvar c++-header-extension-list '("h" "hh" "H" "hpp"))

;; Switches between source/header files
(defun toggle-source-header()
  "Switches to the source buffer if currently in the header buffer"
  "and vice versa."
  (interactive)
  (let ((buf (current-buffer))
        (name (file-name-nondirectory (buffer-file-name)))
        file
        offs)
    (setq offs (string-match c++-header-ext-regexp name))
    (if offs
        (let ((lst c++-source-extension-list)
              (ok nil)
              ext)
          (setq file (substring name 0 offs))
          (while (and lst (not ok))
            (setq ext (car lst))
            (if (file-exists-p (concat file "." ext))
                (setq ok t))
            (setq lst (cdr lst)))
          (if ok
              (find-file (concat file "." ext))))
        (let ()
          (setq offs (string-match c++-source-ext-regexp name))
          (if offs
              (let ((lst c++-header-extension-list)
                    (ok nil)
                    ext)
                (setq file (substring name 0 offs))
                (while (and lst (not ok))
                  (setq ext (car lst))
                  (if (file-exists-p (concat file "." ext))
                      (setq ok t))
                  (setq lst (cdr lst)))
                (if ok
                    (find-file (concat file "." ext)))))))))

;; ============================================================================
;; Keys
;; ============================================================================

(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "S-<tab>") 'tab-to-tab-stop)
;;(global-set-key [(iso-left-tab)] 'tab-to-tab-stop)
;;(define-key global-map [(shift tab)] 'self-insert-command)

(global-set-key [(control z)] 'undo)
(global-set-key [(meta s)] 'toggle-source-header)

(global-set-key [(alt backspace)]
                (lambda () (interactive)
                        (c-toggle-hungry-state 0)
                        (c-electric-backspace ())
                        (c-toggle-hungry-state 0)))
(global-set-key [(alt delete)]
                (lambda () (interactive)
                        (c-toggle-hungry-state 0)
                        (c-electric-delete ())
                        (c-toggle-hungry-state 0)))

;; Make `C-x C-m' and `C-x RET' be different (since I tend
;; to type the latter by accident sometimes.)
(define-key global-map [(control x) return] nil)

;(global-set-key (kbd "ESC <left>") 'shrink-window-horizontally)
;(global-set-key (kbd "ESC <right>") 'enlarge-window-horizontally)
;(global-set-key (kbd "ESC <down>") 'shrink-window)
;(global-set-key (kbd "ESC <up>") 'enlarge-window)

;; Setup for recent emacs (Ubuntu 10.04)
;(define-key global-map [(control left)]  'backward-word)
;(define-key global-map [(control right)] 'forward-word)
;(define-key global-map [(control down)]  'forward-paragraph)
;(define-key global-map [(control up)]    'backward-paragraph)
(define-key global-map [(meta left)]  'shrink-window-horizontally)
(define-key global-map [(meta right)] 'enlarge-window-horizontally)
(define-key global-map [(meta down)]  'shrink-window)
(define-key global-map [(meta up)]    'enlarge-window)

;; Setup for Servers
;(global-set-key (kbd "M-[ 1 ; 5 D") 'backward-word)
;(global-set-key (kbd "M-[ 1 ; 5 C") 'forward-word)
;(global-set-key (kbd "M-[ 1 ; 5 B") 'forward-paragraph)
;(global-set-key (kbd "M-[ 1 ; 5 A") 'backward-paragraph)
;(global-set-key (kbd "M-[ 1 ; 5 H") 'beginning-of-line)
;(global-set-key (kbd "M-[ 1 ; 5 F") 'end-of-line)
;(global-set-key (kbd "ESC M-[ d") 'shrink-window-horizontally)
;(global-set-key (kbd "ESC M-[ c") 'enlarge-window-horizontally)
;(global-set-key (kbd "ESC M-[ b") 'shrink-window)
;(global-set-key (kbd "ESC M-[ a") 'enlarge-window)

;; Enable Xterm mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

; ============================================================================
;; Variables
;; ============================================================================
(setq-default
 ;; Set my tabstops for coding
 ;tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80)
 default-tab-width 8
 ;: toggle overwrite mode
 overwrite-mode nil
 ;; Make delete go the other way
 ;delete-key-deletes-forward t
)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asm-comment-char 64)
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(bar-cursor 2)
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java")
     (other . "linux"))))
 '(c-style-variables-are-local-p nil)
 '(c-tab-always-indent t)
 '(case-fold-search t)
 '(column-number-mode t)
 '(comment-column 97)
 '(comment-fill-column 97)
 '(compilation-scroll-output t)
 '(compilation-window-height 10)
 '(cscope-no-mouse-prompts t)
 '(current-language-environment "English")
 '(custom-safe-themes
   (quote
    ("b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(frame-background-mode (quote dark))
 '(gud-gdb-command-name "arm-eabi-gdb" t)
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative))
 '(helm-gtags-prefix-key "")
 '(helm-gtags-suggested-key-mapping t)
 '(helm-gtags-use-input-at-cursor t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(jit-lock-stealth-load nil)
 '(jit-lock-stealth-nice 0.1)
 '(jit-lock-stealth-time 1)
 '(kill-whole-line nil)
 '(make-backup-files nil)
 '(make-tags-files-invisible t)
 '(menu-bar-mode nil)
 '(mode-compile-always-save-buffer-p t)
 '(mouse-buffer-menu-maxlen 30)
 '(mouse-buffer-menu-mode-mult 1)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t)
 '(mouse-yank-at-point t)
 '(package-selected-packages
   (quote
    (powerline helm-ag color-theme-solarized dracula-theme delight realgud diminish helm-descbinds helm-git helm-ls-git helm-projectile highlight-indent-guides magit helm-cscope helm-gtags helm zenburn-theme nlinum diffview other-frame-window python ##)))
 '(paren-mode (quote blink-paren) nil (paren))
 '(projectile-mode-line
   (quote
    (:eval
     (format " Prj[%s]"
             (projectile-project-name)))))
 '(safe-local-variable-values
   (quote
    ((verilog-library-extensions ".v" ".sv" ".vh" ".svh")
     (verilog-library-directories "." "../sam")
     (verilog-typedef-regexp . "_t$"))))
 '(scroll-bar-mode (quote right))
 '(scroll-conservatively 1)
 '(scroll-preserve-screen-position t)
 '(scroll-step 1)
 '(show-paren-mode t nil (paren))
 '(speedbar-directory-unshown-regexp
   "^\\(autom4te\\.cache\\|\\.deps\\|\\.obj\\|\\.svn\\|CVS\\|RCS\\|SCCS\\)\\'")
 '(speedbar-mode-specific-contents-flag nil)
 '(speedbar-supported-extension-expressions
   (quote
    (".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".s?html" "[Mm]akefile\\(\\.in\\|\\.lib\\.in\\)?" ".s" ".inc" ".ld" ".lst" ".am" ".lnk" ".txt" ".diff")))
 '(speedbar-tag-hierarchy-method
   (quote
    (speedbar-sort-tag-hierarchy speedbar-trim-words-tag-hierarchy speedbar-prefix-group-tag-hierarchy speedbar-simple-group-tag-hierarchy)))
 '(speedbar-tag-regroup-maximum-length 100)
 '(speedbar-tag-split-minimum-length 100)
 '(speedbar-use-images nil)
 '(standard-indent 8)
 '(tab-always-indent t)
 '(tags-auto-read-changed-tag-files t)
 '(tool-bar-mode nil nil (tool-bar))
 '(tooltip-gud-tips-p t)
 '(whitespace-line-column 100)
 '(whitespace-style
   (quote
    (face trailing tabs spaces lines newline empty indentation space-after-tab space-before-tab tab-mark))))


;; ============================================================================
;; Custom
;; ============================================================================

