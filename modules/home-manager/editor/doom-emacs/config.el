;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; FIXME configurable from nix /home-manager
(setq user-full-name "Luke Bentley-Fox")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function.
(setq doom-theme 'doom-monokai-classic)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! md-roam ; load immediately, before org-roam
  :config
  (setq md-roam-file-extension-single "md")
  (setq md-roam-use-org-file-links nil)
  (setq md-roam-use-markdown-file-links t)
)

(use-package! org-roam
  :init
  ;; add markdown extension to org-roam-file-extensions list
  (setq org-roam-file-extensions '("md" "org"))
  (setq org-roam-title-sources '((mdtitle title mdheadline headline) (mdalias alias)))
  (setq org-roam-directory "~/Org/roam/")
  (setq org-roam-capture-templates
        '(("d" "default" plain #'org-roam-capture--get-point
               "%?"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+TITLE: ${title}\n---\n"
               :unnarrowed t)

          ("i" "Issue" plain #'org-roam-capture--get-point
               "%?"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+TITLE: ${title}
#+ROAM_TAGS: issue
#+TICKET_ID: %^{Ticket}
#+ENV: %^{Environment}
#+PRIORITY: %^{Priority}\n---\n"
               :unnarrowed t)

          ("t" "Task" plain #'org-roam-capture--get-point
               "%?"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+TITLE: ${title}
#+ROAM_TAGS: task
#+TICKET_ID: %^{Ticket}
#+PRIORITY: %^{Priority}\n---\n"
               :unnarrowed t)))
)

;; Projectile
(setq projectile-project-search-path '("~/Projects/"))

;; On save, eliminate all trailing whitespace in a buffer.
(add-hook! before-save 'delete-trailing-whitespace)
