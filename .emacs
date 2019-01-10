;; ~/.emacs --- Emacs Lisp configuration file

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
(package-refresh-contents)

(defvar myPackages
  '(better-defaults
    elpy ;; add the elpy package 
    material-theme
    volatile-highlights
    undo-tree
    yasnippet))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(require 'undo-tree)
(undo-tree-mode t)

(require 'yasnippet)

(elpy-enable)

;; Tron Theme Customization

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'tron t)

;; BASIC CUSTOMIZATION
;; --------------------------------------

;; Hide the startup message
(setq inhibit-startup-message t)

;; Make all backup files go into a directory  
(setq backup-directory-alist `(("." . "~/emacs_saves")))

;; Remove the inital Lisp message
(setq initial-scratch-message "")

;; Start scratch buffer in text mode
(setq initial-major-mode 'text-mode)

;; Enable line numbers globally
(global-linum-mode t)

;; Theme disabled
;; (load-theme 'material t) ;; load material theme

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(package-selected-packages (quote (material-theme better-defaults))))

 (custom-set-faces
  
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
