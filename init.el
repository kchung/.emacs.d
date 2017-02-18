;; loading package

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/spacing.el")

;; Load theme!
(load-theme 'sanityinc-tomorrow-bright t)

(global-auto-revert-mode t)

;; Go away menu bar
(menu-bar-mode 0)

;; Enable Column Number
(setq column-number-mode t)

;; Allow `y` and `n` instead of typing it out
(fset 'yes-or-no-p 'y-or-n-p)

;; Desktop Mode
(setq desktop-restore-eager 20)
(desktop-save-mode 0)

;; Projectile
(require 'projectile)
(projectile-global-mode)

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

;; Remove grep result headers
(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))

(defadvice grep (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))

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
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")

;;
;; Auto-save
;; =========

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(package-selected-packages
   (quote
    (vue-mode js2-mode color-theme-sanityinc-tomorrow web-mode scss-mode popwin magit helm-projectile expand-region))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)


;;
;; Editing modes
;; =========

(add-to-list 'auto-mode-alist '("\\.tpl\\'"   . html-mode))

(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'"  . scss-mode))

;; JSX
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(add-hook 'javascript-mode (lambda () (electric-indent-local-mode -1)))

;; Vue
(require 'vue-mode)
(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))
(setq indent-tabs-mode nil
      js-indent-level 2
      mmm-submode-decoration-level 0)

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
 '(default ((t (:background nil))))
 '(diff-added ((t (:inherit diff-changed))))
 '(diff-removed ((t (:inherit diff-changed))))
 '(helm-selection ((t (:background "color-27" :foreground "brightwhite"))))
 '(magit-diff-add ((t (:inherit diff-added :foreground "green3"))))
 '(magit-diff-del ((t (:inherit diff-removed :foreground "red"))))
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
