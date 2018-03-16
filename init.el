;; load path
(setq load-path 
      (append '(
		"~/.emacs.d/git-modes"
		) load-path))

;; M-x gitattributes-mode, gitconfig-mode, gitignore-mode の追加
(load "git-modes.el")
(require 'git-modes)

;; M-x diff-mode の表示色を変更
;; http://www.clear-code.com/blog/2012/4/3.html
(load "git-commit-color.el")
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . diff-mode))

;; no start up
(setq inhibit-startup-screen t)

;; key bind & no backup
(keyboard-translate ?\C-h ?\C-?)
(setq make-backup-files nil)

;; Ctrl + 上下キーで分割したバッファの境界線を上下できる
(global-set-key [(ctrl up)] '(lambda (arg) (interactive "p") (shrink-window arg)))
(global-set-key [(ctrl down)] '(lambda (arg) (interactive "p") (shrink-window (- arg))))

;; パッケージリポジトリ(これ以降に個別のパッケージをrequireすること）
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


; ====================================
; 最近使ったファイルを（メニューに）表示する
;====================================
; M-x recentf-open-files で履歴一覧バッファが表示される。
; http://homepage.mac.com/zenitani/elisp-j.html#recentf
(require 'recentf)
(setq recentf-auto-cleanup 'never) ;;tramp対策。
(recentf-mode 1)


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


;===============
; jedi (package.elの設定より下に書く)
;===============
(require 'epc)
(require 'auto-complete-config)
(require 'python)

;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
(setenv "PYTHONPATH" "/usr/local/lib/anaconda3/pkgs")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
