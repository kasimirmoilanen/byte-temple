(ql:quickload :hunchentoot)
(ql:quickload :spinneret)

; On a unix system, the root seems to be the user's home directory.
(defparameter *path* "./path/to/file-directory/")

(defparameter *server* (make-instance 'hunchentoot:easy-acceptor
                                      :port 33333
                                      :address "0.0.0.0"
                                      :document-root (truename *path*)))



(defun start ()
  (hunchentoot:start *server*))

(defun server-stop ()
  (hunchentoot:stop *server*))

(hunchentoot:define-easy-handler (main :uri "/")
    ()
  (spinneret:with-html-string
    (:html
     (:head)
     (:body (:h1 "Files")
            (:h4 "Made with secret alien technology...")
            (loop :for i :in (uiop:directory-files *path*) :collect
                  (:p (:a :href (file-namestring i) (file-namestring i))))
            (:br)
            ))))
