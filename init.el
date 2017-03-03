;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

; Cask cask.elのpathは環境に合わせてコメントアウト削除
;(require 'cask "~/.linuxbrew/Cellar/cask/0.8.1/cask.el")        ;Linuxbrew
(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el") ;Homebrew
(cask-initialize)
; 対応する括弧を光らせる
(show-paren-mode t)
; 閉じ括弧の自動挿入
(electric-pair-mode t)
; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)
; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
; 改行時の自動インデントを無効に
(add-hook 'emacs-lisp-mode-hook '(lambda () (electric-indent-local-mode -1)))
(add-hook 'lisp-mode-hook       '(lambda () (electric-indent-local-mode -1)))
; 各モードのインデント設定
(add-hook 'emacs-lisp-mode-hook '(lambda () (setq-default tab-width 4 indent-tabs-mode nil)))
; commandとoptionのメタキー変更
(setq mac-command-key-is-meta nil)
(setq mac-option-modifier 'meta)
; undo C-z
(bind-key* "C-z" 'undo)
; 問い合わせを簡略化 yes/no を y/n
(fset 'yes-or-no-p 'y-or-n-p)
; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
; 行番号
(require 'linum)
(global-set-key [f9] 'linum-mode)
(global-linum-mode t)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
    (run-with-idle-timer 0.2 nil #'linum-update-current))
; スクロールを1行づつにする
(setq scroll-step 1)
; C-a拡張
(defun my-goto-line-beginning-or-indent (&optional $position)
    (interactive)
    (or $position (setq $position (point)))
    (let (($starting-position (progn (back-to-indentation) (point))))
        (if (eq $starting-position $position)
            (move-beginning-of-line 1)
        )
    )
)
(bind-key* "C-a" 'my-goto-line-beginning-or-indent)
; Theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
)
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
; auto-complete-----------------------
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode -1)
(setq ac-delay 0.1)
(setq ac-auto-show-menu 0.2)
;; 辞書の有効化
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict/")
;yasnippet---------------------------------------
;; From https://github.com/capitaomorte/yasnippet.git
(require 'yasnippet)
(yas-global-mode t)
(setq yas-snippet-dirs
    '("~/.emacs.d/snippets/default"         ;the default snippets
      "~/.emacs.d/snippets/yasmate"  ;the yasmate snippets
      "~/.emacs.d/snippets/personal" ;personal snippets
     )
)
(bind-keys :map yas-minor-mode-map ("C-x i i" . yas-insert-snippet))     ;既存スニペットの挿入
(bind-keys :map yas-minor-mode-map ("C-x i v" . yas-visit-snippet-file)) ;既存スニペットの閲覧・編集
(bind-keys :map yas-minor-mode-map ("C-x i n" . yas-new-snippet))        ;既存スニペットの作成
; helm--------------------------------
(require 'helm-config)
(helm-mode t)
(bind-key "M-x" 'helm-M-x)
(bind-key "C-x C-f" 'helm-find-files)
(bind-key "C-x b" 'helm-buffers-list)
(bind-key "C-x C-r" 'helm-recentf)
;; For helm-find-files etc.
(bind-keys :map helm-read-file-map ("TAB" . helm-execute-persistent-action))
(bind-keys :map helm-find-files-map ("TAB" . helm-execute-persistent-action))
;-------------------------------------
; web-mode----------------------------
(require 'web-mode)
;; 拡張子
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
;; インデント数
(defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset   4)
    (setq web-mode-css-indent-offset      4)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-java-offset   4)
    (setq web-mode-asp-offset    4)
    (setq web-mode-php-offset    4)
    (setq web-mode-ruby-indentation 4)
    (setq web-mode-script-padding 4)

    (setq web-mode-tag-auto-close-style 2)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-block-face t)
    (setq web-mode-enable-heredoc-fontification t)
    (setq web-mode-enable-current-element-highlight t)
    ;(setq web-mode-enable-current-column-highlight t)
)
(add-hook 'web-mode-hook 'my-web-mode-hook)
(define-key web-mode-map (kbd "RET") 'newline-and-indent)
(define-key web-mode-map (kbd "C-c C-_") 'web-mode-element-close)
;; settings about auto-completion
(setq web-mode-ac-sources-alist
    '(("html" . (ac-source-words-in-buffer ac-source-abbrev))
    )
)
;; 色の設定
(custom-set-faces
    '(web-mode-doctype-face
        ((t (:foreground "#82AE46"))))                          ; doctype
    '(web-mode-html-tag-face
        ((t (:foreground "#94ADE9" :weight bold))))             ; 要素名
    '(web-mode-html-attr-name-face
        ((t (:foreground "#98A144"))))                          ; 属性名など
    '(web-mode-html-attr-value-face
        ((t (:foreground "#D9333F"))))                          ; 属性値
)
;---------------------------------------
; js2-mode------------------------------
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(define-key js2-mode-map (kbd "C-h C-f") 'js2-mode-hide-functions)
(define-key js2-mode-map (kbd "C-s C-f") 'js2-mode-show-functions)
(define-key js2-mode-map (kbd "RET")     'newline-and-indent)
;---------------------------------------
; ruby-mode
(require 'ruby-mode)
(setq ruby-indent-tabs-mode t)
(add-hook 'ruby-mode-hook
    '(lambda()
        (define-key ruby-mode-map (kbd "RET") 'newline-and-indent)
        (define-key ruby-mode-map (kbd "C-RET") 'newline)
    )
)
;------------------------------------------------
; rinari
;; From git://github.com/eschulte/rinari.git
(require 'rinari)
;------------------------------------------------
; scss-mode
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.css\\'"  . scss-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil)
(define-key global-map (kbd "RET") 'newline-and-indent)
;------------------------------------------------
; dockerfile-mode
;; From https://github.com/spotify/dockerfile-mode.git
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;------------------------------------------------
; whitespace-mode
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ;  スペース
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
    '((space-mark ?\u3000 [?\u25a1])))
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        ;(tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存時に自動でクリーンアップ
;(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(defvar my/bg-color "#000000")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)
;------------------------------------------------
; yml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;------------------------------------------------
; typescript-mode
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;------------------------------------------------
; tide-mode
(add-to-list 'load-path "~/.emacs.d/packages/tide")
(require 'tide)
(add-hook 'typescript-mode-hook
  (lambda ()
    (interactive)
    (tide-setup)
    (flycheck-mode t)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode t)
    (company-mode-on)
  )
)
(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /var/log/tss.log"))
;------------------------------------------------
; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(bind-keys :map company-active-map ("TAB" . 'company-complete-common-or-cycle))
(setq company-minimum-prefix-length 1) ;1文字補完
(setq company-selection-wrap-around t) ;補完候補のループ選択
;;色の設定
(set-face-attribute 'company-tooltip nil
                    :foreground "black"
                    :background "lightgray")
(set-face-attribute 'company-preview-common nil
                    :foreground "dark gray"
                    :background "black"
                    :underline t)
(set-face-attribute 'company-tooltip-selection nil
                    :background "steelblue"
                    :foreground "white")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black"
                    :underline t)
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white"
                    :background "steelblue"
                    :underline t)
(set-face-attribute 'company-tooltip-annotation nil
                    :foreground "red")
;------------------------------------------------
