;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
;; (tooltip-mode    -1)
;; (menu-bar-mode   -1)

(global-linum-mode 1)

(setq inhibit-startup-screen 1)

(set-default-font "FuraCode Nerd Font 15")

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Disable backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(setq evil-split-window-right 1)
(setq evil-split-window-below 1)
(setq evil-auto-balance-windows nil)

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; Fancy titlebar for MacOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

;; Helm - fuzzy completions
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-locate-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        helm-candidate-number-list 150
        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-echo-input-in-header-line t
        helm-autoresize-max-height 0
        helm-autoresize-min-height 20)
  :config
  (helm-mode 1))

;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; Which Key - next key options
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;;(defun vterm () "vertical terminal split" (interactive) (evil-window-vnew) (ansi-term "/bin/zsh"))

(defun eval-last-sexp-here
    () "eval-last-sexp with output in buffer"
    (interactive)
    (eval-last-sexp 1))

(use-package general
  :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"
   "SPC"  '(helm-M-x :which-key "M-x")
   "q"    '(evil-quit :which-key "quit file")
   "w"    '(evil-write :which-key "write file")
;;   "x"    '(evil-window-vnew :which-key "vertical term split")
;;   "x"    '(vterm :which-key "vertical term split")
  )
  (general-define-key
;;   "K"    '(describe-function :which-key "function help")
   "C-u"  '(evil-scroll-up :which-key "page up")
   "M-l"  '(windmove-right :which-key "move right")
   "M-h"  '(windmove-left :which-key "move left")
   "M-k"  '(windmove-up :which-key "move up")
   "M-j"  '(windmove-down :which-key "move bottom")
   "M-="  '(balance-windows :which-key "balance windows")
   "M-z"  '(maximize-window :which-key "maximize window")
   "<C-return>" '(eval-last-sexp :which-key "eval-last-sexp")
   "<C-S-return>" '(eval-last-sexp-here :which-key "eval-last-sexp-here")
  )
  (general-define-key
   :states '(normal visual emacs)
   "j"    '(evil-next-visual-line :which-key "line down")
   "k"    '(evil-previous-visual-line :which-key "line down")
  )
  (general-define-key
   :keymaps 'dired-mode-map
   "-"    '(dired-up-directory :which-key "up directory")
  )
)

;; center screen on next/previous search
(defadvice evil-search-next (after advice-for-evil-ex-search-next activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

(defadvice evil-search-previous (after advice-for-evil-ex-search-previous activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

;;;; Custom keybinding
;;(use-package general
;;  :ensure t
;;  :config (general-define-key
;;    :states '(normal visual insert emacs)
;;    :prefix "SPC"
;;    :non-normal-prefix "C-SPC"
;;    "K"   '(elisp-slime-nav-describe-elisp-thing-at-point :which-key "describe")
;;    ;; "/"   '(counsel-rg :which-key "ripgrep") ; You'll need counsel package for this
;;    "C-^" '(switch-to-prev-buffer :which-key "previous buffer")
;;    "SPC" '(helm-M-x :which-key "M-x")
;;    "pf"  '(helm-find-file :which-key "find files")
;;    ;; Buffers
;;    "bb"  '(helm-buffers-list :which-key "buffers list")
;;    ;; Window
;;    "wl"  '(windmove-right :which-key "move right")
;;    "wh"  '(windmove-left :which-key "move left")
;;    "wk"  '(windmove-up :which-key "move up")
;;    "wj"  '(windmove-down :which-key "move bottom")
;;    "\\"  '(split-window-right :which-key "split right")
;;    "-"  '(split-window-below :which-key "split bottom")
;;    "wx"  '(delete-window :which-key "delete window")
;;    ;; Others
;;    "at"  '(ansi-term :which-key "open terminal")
;;))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile general which-key doom-themes evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
