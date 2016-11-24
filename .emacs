;(load (expand-file-name (concat (getenv "HOME") "/.emacs.d/init.el")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "/home/nonoho/.emacs.d/lisp/init.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(magit-commit-arguments nil)
 '(package-selected-packages
   (quote
    (yasnippet web-mode volatile-highlights undo-tree twittering-mode sync-recentf recentf-ext rainbow-mode rainbow-delimiters r-autoyas quickrun qml-mode php-mode org-present open-junk-file mozc-popup mozc-im matlab-mode markdown-mode magit lua-mode js2-mode helm-flycheck helm-ag haskell-mode graphviz-dot-mode gnuplot-mode gnuplot git-gutter flycheck-tip flycheck-perl6 flycheck-irony ess-R-object-popup ess-R-data-view emoji-fontset emmet-mode e2wm-term e2wm-sww e2wm-pkgex4pl e2wm-bookmark csv-mode company-irony auto-complete-clang-async auto-complete-clang auto-complete-c-headers arduino-mode anzu anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
