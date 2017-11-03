; load path
;(setq load-path (cons "~/.emacs.d/" load-path))

; key bind & no backup
(keyboard-translate ?\C-h ?\C-?)
(setq make-backup-files nil)

; Ctrl + 上下キーで分割したバッファの境界線を上下できる
(global-set-key [(ctrl up)] '(lambda (arg) (interactive "p") (shrink-window arg)))
(global-set-key [(ctrl down)] '(lambda (arg) (interactive "p") (shrink-window (- arg))))

; パッケージリポジトリ(これ以降に個別のパッケージをrequireすること）
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))


;;;; for ctags.el
(require 'ctags-update)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
(add-hook 'emacs-lisp-mode-hook  'turn-on-ctags-auto-update-mode)


;; auto-complete
;; (require 'company)
;; (global-company-mode) ; 全バッファで有効にする
;; (setq company-idle-delay 0) ; デフォルトは0.5
;; (setq company-minimum-prefix-length 2) ; デフォルトは4
;; (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)


;; Standard Jedi.el setting
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)                 ; optional
;===============
; jedi (package.elの設定より下に書く)
;===============
(require 'epc)
(require 'auto-complete-config)
(require 'python)

;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
