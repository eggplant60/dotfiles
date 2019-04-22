
;; パッケージリポジトリ(これ以降に個別のパッケージをrequireすること）
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

;; --- Haskel 関連 ----
;; 2018/6/17 haskell-mode
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal$" . haskell-cabal-mode))

;; 2018/6/17 ghc-mod
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

;; 2018/6/21 C-c, C-l で ghci の起動
(setq haskell-program-name "/usr/bin/ghci")
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; 2018/6/21 編集した hs ファイルのオートリロード
(defadvice inferior-haskell-load-file (after change-focus-after-load)
  "Change focus to GHCi window after C-c C-l command"
  (other-window 1))
(ad-activate 'inferior-haskell-load-file)
;; -----------------


;; --- git 関連 ---
;; M-x gitattributes-mode, gitconfig-mode, gitignore-mode の追加
(add-to-list 'load-path "~/.emacs.d/el_link/git-modes")
(require 'git-modes)
(load "git-modes.el")

;; M-x diff-mode の表示色を変更, http://www.clear-code.com/blog/2012/4/3.html
(load "git-commit-color.el")
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . diff-mode))
;; -----------------

;; --- 一般的な設定 ---
;; no start up
(setq inhibit-startup-screen t)

;; key bind & no backup
(keyboard-translate ?\C-h ?\C-?)
(setq make-backup-files nil)

;; Shift + カーソルキーで移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)
(global-set-key [left] 'windmove-left)
(global-set-key [right] 'windmove-right)
(global-set-key [up] 'windmove-up)
(global-set-key [down] 'windmove-down)

;; eshell のキーバインド
(global-set-key [f9] 'eshell)

;; Elscreen
(require 'elscreen)
(load "~/.emacs.d/el_link/elscreen.el")

;; remote のファイルを編集
(require 'tramp)
(setq tramp-default-method "ssh")

; 最近使ったファイルを（メニューに）表示する
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
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)
;; -----------------

;; --- Python 関連 ---
;; jedi (package.elの設定より下に書く)
(require 'epc)
(require 'auto-complete-config)
(require 'python)

;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
(setenv "PYTHONPATH" "/usr/local/lib/anaconda3/pkgs")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; autopep8 (2019/04/22)
(load "~/.emacs.d/el_link/py-autopep8.el")

(require 'py-autopep8)
(define-key python-mode-map (kbd "C-c F") 'py-autopep8)          ; バッファ全体のコード整形
(define-key python-mode-map (kbd "C-c f") 'py-autopep8-region)   ; 選択リジョン内のコード整形

;; 保存時にバッファ全体を自動整形する
(add-hook 'before-save-hook 'py-autopep8-before-save)
;; -----------------


;; 2019/04/03 スニペット
;; http://vdeep.net/emacs-yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/el_link/dotfiles/mysnippets"
	"~/.emacs.d/el_link/dotfiles/yasnippets"
	))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
(yas-global-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
