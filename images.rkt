#lang racket

(provide images)

(require webapp/js 
	 racket/runtime-path
	 syntax/parse/define
	 (for-syntax racket
		     racket/syntax
		     racket/runtime-path))

(define-syntax (define-image stx)
  (syntax-parse stx
		#:disable-colon-notation
		[(_ group id)
		 #:with image/id (format-id stx "images/~a" #'id)
		 #:with path:image/id (format-id stx "path:images/~a" #'id)
		 #:with img:id (format-id stx "img:~a" #'id)
		 #`(begin

		     (define-runtime-path id (~a "images/" 'id))
		     (define image/id (page image/id id))
		     (define path:image/id (prefix/pathify (~a "images/" 'id)))
		     (provide id image/id path:image/id)
		     (define/provide-extensible-element img:id
							img
							(src: path:image/id (lambda (a b) a)))
		     (set! group (cons image/id group)))]))

(define-syntax (define-images-from-folder stx)
  (syntax-parse stx
		[(_ path)
		 (define files (directory-list (syntax->datum #'path)))

		 #`(begin
		     #,@(map
			  (lambda (f)
			    #`(define-image images #,(string->symbol (~a f)))  
			    )
			  files))]))

(define images '())

(define-images-from-folder "images")
