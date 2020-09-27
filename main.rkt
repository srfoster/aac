#lang racket

(require website/bootstrap "./images.rkt")

(define (talk-button to-say text img-url)
  (button-warning
    style: (properties height: 100
	    	       cursor: "pointer"
		       margin: 20)
    'onclick: (~a "var msg = new SpeechSynthesisUtterance(); msg.voice = speechSynthesis.getVoices()[2]; msg.text = '" to-say "'; window.speechSynthesis.speak(msg);")
    (div 
     
      (img src: (~a "images/" img-url) 
	   style:"width:50px;")
      (div text) )
      
    ))

(define (aac)
  (page index.html
	(content
	  (container
	    (talk-button "Meow" "Cat" "cat2.png")
	    (talk-button "Woof" "Dog" "dog.png")
	    (talk-button "Ahoy matey" "Bird" "bird.png")
	    (talk-button "Wooooo oooo ooooo" "Gub Gub" "gubgub.png")
	    (talk-button "Meow" "Cat" "cat2.png")
	    (talk-button "Woof" "Dog" "dog.png")
	    (talk-button "Ahoy matey" "Bird" "bird.png")
	    (talk-button "Wooooo oooo ooooo" "Gub Gub" "gubgub.png")
	    (talk-button "Meow" "Cat" "cat2.png")
	    (talk-button "Woof" "Dog" "dog.png")
	    (talk-button "Ahoy matey" "Bird" "bird.png")
	    (talk-button "Wooooo oooo ooooo" "Gub Gub" "gubgub.png")
	    ))))

(render #:to "out" 
	(list 
	  (bootstrap-files)
	  (aac)
	  images))
