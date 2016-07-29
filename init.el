; ロードパス
(setq load-path (cons "~/.emacs.d/packages/" load-path))
; 対応する括弧を光らせる
(show-paren-mode t)
; 閉じカッコの自動挿入
(electric-pair-mode t)
; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)
; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8-with-signature)
; 言語を日本語にする
(set-language-environment 'Japanese)
; 改行時の自動インデントをLispでのみ無効に
(electric-indent-mode -1)
; commandとoptionのメタキー変更
(setq mac-command-key-is-meta nil)
(setq mac-option-modifier 'meta)
; undo C-z
(define-key global-map "\C-z" 'undo)
; 問い合わせを簡略化 yes/no を y/n
(fset 'yes-or-no-p 'y-or-n-p)
; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
; 行番号
(require 'linum)
(global-set-key [f9] 'linum-mode)
(global-linum-mode t)
; スクロールを一行ずつにする
(setq scroll-step 1)
; auto-complete-----------------------
;; From https://github.com/auto-complete/auto-complete.git
(add-to-list 'load-path "~/.emacs.d/packages/auto-complete/")
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
;; 辞書の有効化
(add-to-list 'ac-dictionary-directories "~/.emacs.d/packages/auto-complete/dict")
;-------------------------------------
; helm--------------------------------
;; From https://github.com/emacs-helm/helm.git
(add-to-list 'load-path "~/.emacs.d/packages/helm/")
(require 'helm-config)
(helm-mode t)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
;; For helm-find-files etc.
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "M-; M-a") 'helm-select-action)
;-------------------------------------
; web-mode----------------------------
;; From https://github.com/fxbois/web-mode.git
(add-to-list 'load-path "~/.emacs.d/packages/web-mode/")
(require 'web-mode)
;; 拡張子
(add-to-list 'auto-mode-alist '("\\.html?$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.css$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$"     . web-mode))
;; インデント数
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset   3)
  (setq web-mode-css-indent-offset    3)
  (setq web-mode-code-indent-offset 3)
  (setq web-mode-java-offset   3)
  (setq web-mode-asp-offset    3)
  (setq web-mode-php-offset    3)

  (setq web-mode-tag-auto-close-style 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-heredoc-fontification t)
  (setq web-mode-enable-current-element-highlight t)
  ;(setq web-mode-enable-current-column-highlight t)
;; settings about aout-completion
  (setq web-mode-ac-sources-alist
       	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))
	  ("php" . (ac-source-php-completion)))
  )
  (electric-indent-local-mode t)
)
(add-hook 'web-mode-hook 'my-web-mode-hook)
(define-key web-mode-map (kbd "RET") 'newline-and-indent)
(define-key web-mode-map (kbd "C-c C-_") 'web-mode-element-close)
;---------------------------------------
; js2-mode------------------------------
;; From https://github.com/mooz/js2-mode.git
(add-to-list 'load-path "~/.emacs.d/packages/js2-mode/")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(define-key js2-mode-map (kbd "C-h C-f") 'js2-mode-hide-functions)
(define-key js2-mode-map (kbd "C-s C-f") 'js2-mode-show-functions)
(define-key js2-mode-map (kbd "RET")     'newline-and-indent)
(setq js2-basic-offset 2)
;---------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; window-mode settings
(when window-system
    (create-fontset-from-ascii-font "Source Han Code JP-15:weight=normal:slant=normal" nil "hancode")
    (set-fontset-font "fontset-hancode" 'unicode (font-spec :family "Source Han Code JP Light" :size 15) nil 'append)
    (add-to-list 'default-frame-alist '(font . "fontset-hancode"))
    (set-frame-parameter nil 'fullscreen 'maximized) ;起動時最大化
)
;yasnippet---------------------------------------
;; From https://github.com/capitaomorte/yasnippet.git
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet/")
(require 'yasnippet)
(yas-global-mode t)
(setq yas-snippet-dirs
      '("~/.emacs.d/packages/yasnippet/snippets/"         ;the default snippets
	"~/.emacs.d/packages/yasnippet/yasmate/snippets"  ;the yasmate snippets
	"~/.emacs.d/packages/yasnippet/personal-snippets" ;personal snippets
       )
)
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)       ;既存スニペットの挿入
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)   ;既存スニペットの閲覧・編集
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)          ;新規スニペットを作成
;------------------------------------------------
; init-open-recentf
;; From https://github.com/zonuexe/init-open-recentf.el.git
(add-to-list 'load-path "~/.emacs.d/packages/init-open-recentf.el/")
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items 25)
(require 'init-open-recentf)
(setq init-open-recentf-interface 'helm)
(init-open-recentf)
;------------------------------------------------
; indent-guide
;; From https://github.com/zk-phi/indent-guide.git
;(add-to-list 'load-path "~/.emacs.d/packages/indent-guide/")
;(require 'indent-guide)
;(indent-guide-global-mode)
;(setq indent-guide-recursive t)
;------------------------------------------------
; highlight-indentation
;; From https://github.com/antonj/Highlight-Indentation-for-Emacs.git
(add-to-list 'load-path "~/.emacs.d/packages/highlight-indentation/")
(require 'highlight-indentation)
(highlight-indentation-mode t)
(setq highlight-indentation-offset 3)
(setq web-mode-indentation-offset 3)
;(add-hook 'js2-mode-hook 'highlight-indentation-mode)
(set-face-background 'highlight-indentation-face "gray")
;------------------------------------------------
;shell-mode
(setq sh-basic-offset 2
      sh-indentation 2
      sh-indent-after-else 2
      sh-indent-after-continuation 2)
;------------------------------------------------
;ruby-mode
;;From https://github.com/jwiegley/ruby-mode.git
(add-to-list 'load-path "~/.emacs.d/packages/ruby-mode")
(require 'ruby-mode)
(add-hook 'ruby-mode-hook
          '(lambda()
             (define-key ruby-mode-map (kbd "RET") 'newline-and-indent)
             (define-key ruby-mode-map (kbd "C-RET") 'newline)
	     (electric-indent-local-mode t)))
;------------------------------------------------
;php-mode
;;From https://github.com/ejmr/php-mode.git
(add-to-list 'load-path "~/.emacs.d/packages/php-mode")
(add-to-list 'load-path "~/.emacs.d/packages/php-completion")
(require 'php-mode)
(require 'php-completion)
;------------------------------------------------
