2;; ~/.emacs --- Emacs Lisp configuration file

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
  '(auto-complete
    better-defaults
    elpy ;; add the elpy package 
    material-theme
    volatile-highlights
    undo-tree
    yasnippet))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(require 'auto-complete)
(ac-config-default)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(require 'undo-tree)
(undo-tree-mode t)

(require 'yasnippet)

(elpy-enable)

;; Load File at Startup
;; --------------------------------------
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp")

;; load the package named perl-completion.el.
(load "perl-completion") ;; best not to include the ending “.el” or “.elc

(add-hook 'cperl-mode-hook
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)))

(add-hook  'cperl-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
               (auto-complete-mode t)
               (make-variable-buffer-local 'ac-sources)
               (setq ac-sources
                     '(ac-source-perl-completion)))))

(load "anything")

;; Manual Theme Customization
;; --------------------------------------
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq custom-safe-themes t)
;; (load-theme 'tron t)
;; (load-theme 'material t) ;; load material theme
;; (load-theme 'solarized-dark t)
;; (load-theme 'afternoon t)
(load-theme 'misterioso t)


;; BASIC CUSTOMIZATION
;; --------------------------------------

;; Hide the startup message
(setq inhibit-startup-message t)

;; Make all backup files go into a directory  
(setq backup-directory-alist `(("." . "~/emacs/emacs_saves")))

;; Remove the inital Lisp message
(setq initial-scratch-message "")

;; Start scratch buffer in text mode
(setq initial-major-mode 'text-mode)

;; Enable line numbers globally
(global-linum-mode t)

;; Keyboard bindings
;; --------------------------------------
(global-set-key (kbd "C-x C-m") 'tmm-menubar)

(global-set-key (kbd "C-x C-k") '(lambda ()
                                 (interactive)
                                 (popup-menu 'yank-menu)))

;; Auto-Insert Headers
(auto-insert-mode)

(eval-after-load 'autoinsert
  '(define-auto-insert '(perl-mode . "Perl skeleton")
     '("Description: "
       "#!/usr/bin/env perl" \n
       \n
       "use strict;" \n
       "use warnings;" \n \n
       _ \n \n
       "__END__" "\n\n"
       "=head1 NAME" "\n\n"
       str "\n\n"
       "=head1 SYNOPSIS" "\n\n\n"
       "=head1 DESCRIPTION" "\n\n\n"
       "=head1 COPYRIGHT" "\n\n"
       "Copyright (c) " (substring (current-time-string) -4) " "
       (getenv "ORGANIZATION") | (progn user-full-name) "\n\n"
       "This library is free software; you can redistribute it and/or" "\n"
       "modify it under the same terms as Perl itself." "\n\n"
       "=cut" "\n")))

(eval-after-load 'autoinsert
  '(define-auto-insert '(python-mode . "Python skeleton")
     '("Description: "
       "#!/usr/bin/env python3" \n
       _ \n \n
       "'''" "\n"
       "__END__" "\n\n"
       "=head1 NAME" "\n\n"
       str "\n\n"
       "=head1 SYNOPSIS" "\n\n\n"
       "=head1 DESCRIPTION" "\n\n\n"
       "=head1 COPYRIGHT" "\n\n"
       "Copyright (c) " (substring (current-time-string) -4) " "
       (getenv "ORGANIZATION") | (progn user-full-name) "\n\n"
       "This library is free software; you can redistribute it and/or" "\n"
       "modify it under the same terms as Python itself." "\n"
       "'''"
)))

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("5f2aa5d69a4625330c5eb24043039b0128d7795a1f70b09a9087508b378cb08e" "c2471caadabc64850540a344079c07e4c219cd6c9a48811584438e0a0d6dc3e2" "0ecf04c4d99b9b1b00c7ba71581567cbaf92c2cced63171b32833fe9249087e9" "c335adbb7d7cb79bc34de77a16e12d28e6b927115b992bccc109fb752a365c72" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages (quote (material-theme better-defaults)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background-mode nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
