(require 'cl)
(require 'package)

;; Define package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
       ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

(defvar required-packages
  '(
  color-theme-sanityinc-tomorrow
  expand-region
  helm
  helm-projectile
  ibuffer
  magit
  projectile
  popwin
  editorconfig
  drag-stuff
  scss-mode
  web-mode
  vue-mode
  php-mode
  ) "a list of packages to ensure are installed at launch.")

; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
