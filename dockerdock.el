;;; dockerdock.el --- Docker completion interface -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Kamyab Taghizadeh
;;
;; Author: Kamyab Taghizadeh <kamyab.zad@gmail.com>
;; Maintainer: Kamyab Taghizadeh <kamyab.zad@gmail.com>
;; Created: April 13, 2022
;; Modified: April 13, 2022
;; Version: 0.0.1
;; Keywords: docker tools
;; Homepage: https://github.com/kamyab/dockerdock
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;; Interact with docker package through completion frameworks
;;; Code:

(require 'docker)

(defun dockerdock-container-entries (&rest filters)
  "Get list of containers and filter by statuses FILTERS if needed."
  (if filters
  (docker-container-entries
   (mapconcat (lambda (f) (format "-f status=%s" f)) filters " "))
  (docker-container-entries "--all")))

(defun dockerdock-run-docker (command container)
  "Perform docker COMMAND on CONTAINER."
  (docker-run-docker command container))

(defun dockerdock-start ()
  "Start containers."
  (interactive)
  (let ((container (completing-read "Start container: " (dockerdock-container-entries "exited" "created"))))
    (dockerdock-run-docker "start" container)))

(defun dockerdock-stop ()
  "Stop containers."
  (interactive)
  (let ((container (completing-read "Stop container: " (dockerdock-container-entries "running"))))
    (dockerdock-run-docker "stop" container)))

(defun dockerdock-restart ()
  "Restart containers."
  (interactive)
  (let ((container (completing-read "Restart container: " (dockerdock-container-entries))))
    (dockerdock-run-docker "restart" container)))

(defun dockerdock-pause ()
  "Pause containers."
  (interactive)
  (let ((container (completing-read "Pause container: " (dockerdock-container-entries "running"))))
    (dockerdock-run-docker "pause" container)))

(defun dockerdock-unpause ()
  "Resume containers."
  (interactive)
  (let ((container (completing-read "Resume container: " (dockerdock-container-entries "paused"))))
    (dockerdock-run-docker "unpause" container)))

(defun dockerdock-kill ()
  "Kill containers."
  (interactive)
  (let ((container (completing-read "Kill container: " (dockerdock-container-entries "running"))))
    (dockerdock-run-docker "kill" container)))


(provide 'dockerdock)
;;; dockerdock.el ends here
