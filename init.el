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
;; custom-set-faces
;; =================
;; changes are automatically added by 'customize-face'
;; these colors are meant to to go better with my dark terminal background

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-item-highlight ((t (:background "color-234"))))
 '(match ((t (:background "yellow")))))

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
