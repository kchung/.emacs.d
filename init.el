(package-initialize)

;; Define package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Go away menu bar
(menu-bar-mode 0)

;; Enable Column Number
(setq column-number-mode t)

;; Desktop Mode
(setq desktop-restore-eager 20)
(desktop-save-mode 1)

;;
;; Helm
;; =============

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;;
;; Popwin
;; ============

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)
(popwin-mode 1)

;;
;; Ibuffer Mode
;; ============

;; Defaulty use Ibuffer Mode
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;
;; Expand Region
;; =============

(require 'expand-region)
(global-set-key (kbd "C-\\") 'er/expand-region)
(global-set-key (kbd "M-\\") 'er/contract-region)

;;
;; Magit 
;; ===========

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; Change Magit diff colors (good for black backround terminals)
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "gray8"))))


;;
;; Auto-save
;; =========

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/")))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)


;;
;; Editing modes
;; =========

(add-to-list 'auto-mode-alist '("\\.tpl\\'"   . html-mode))

(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'"   . php-mode))

(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'"  . scss-mode))

;;
;; custom-set-faces
;; =================
;; changes are automatically added by 'customize-face'
;; these colors are meant to to go better with my dark terminal background

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:background "color-27" :foreground "brightwhite"))))
 '(magit-diff-add ((t (:inherit diff-added :background "black" :foreground "green"))))
 '(magit-diff-del ((t (:inherit diff-removed :background "black" :foreground "red"))))
 '(magit-item-highlight ((t (:background "color-234"))))
 '(match ((t (:background "black" :foreground "color-124")))))

;; Highligh which pane is active
(set-face-attribute  'mode-line
                 nil 
                 :foreground "black"
                 :background "snow" 
                 :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                 nil 
                 :foreground "black"
                 :background "gray25"
                 :box '(:line-width 1 :style released-button))
