;;;; Themes
;;;
;;; Usage:
;;; New way: M-x load-theme <tab>  or (load-theme 'tomorrow-night t)
;;; Old way: M-x set-colors-XXX    or (set-colors-tomorrow-night)
;;;
;;; --------- ------------------------------------ -----------------------------
;;; Theme     Dark                                 Light
;;; --------- ------------------------------------ -----------------------------
;;; Tomorrow  `set-colors-tomorrow-night'          `set-colors-tomorrow-day'
;;;           `set-colors-tomorrow-night-bright'
;;;           `set-colors-tomorrow-night-eighties'
;;;           `set-colors-tomorrow-night-blue'
;;; --------- ------------------------------------ -----------------------------
;;; Monokai   `set-colors-monokai-default'
;;; --------- ------------------------------------ -----------------------------
;;; Solarized `set-colors-solarized-dark'          `set-colors-solarized-light'
;;; --------- ------------------------------------ -----------------------------

(when *init-theme*
  (load-theme *init-theme* t))


;;; Org mode extra statuses
;; TODO: add solarized

(cond ((featurep 'color-theme-monokai)
       (with-monokai-colors
        'default
        (setq org-todo-keyword-faces
              `(("WORK" . (:foreground ,yellow :weight bold :box nil))
                ("WAIT" . (:foreground ,orange :weight bold :box nil))))))
      ((featurep 'color-theme-tomorrow)
       (with-tomorrow-colors
        (tomorrow-mode-name)
        (setq org-todo-keyword-faces
              `(("WORK" . (:foreground ,yellow :weight bold :box t))
                ("WAIT" . (:foreground ,orange :weight bold :box t)))))))

;;; Linum extension
(load "~/.emacs.d/themes/hilinum-mode.el")
(require 'hlinum)
(hlinum-activate)

;;; Colorize the name of the current project in the modeline.
(when (featurep 'init-helm-projectile)
  (eval-after-load "projectile"
    `(setq projectile-mode-line
           `(:eval (list " ["
                         (propertize
                          (projectile-project-name)
                          'face `(:foreground
                                  ,(cond ((featurep 'color-theme-monokai)
                                          (with-monokai-colors 'default violet))
                                         ((featurep 'color-theme-tomorrow)
                                          (with-tomorrow-colors (tomorrow-mode-name) purple))
                                         (t "#ff0000"))))
                         "]")))))


;;; Utilities

(defun what-face (pos)
  "Display the face at point"
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


(provide 'init-themes)
