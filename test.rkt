#lang at-exp racket

(require webapp/js website-js "./images.rkt")

;Refactoring to construct UI from JSON, in prep for communication with a backend

(define (talk-buttons json-data)
  (enclose
    (div
      #;
      (button-primary on-click: (call 'addButton)
		      "Test")
      (div id: (id "target")))
    (script ([dummy (call 'constructor)])
	    (function (constructor)
		      (call 'addButton))
	    (function (addButton)
		      @js{
			var data = @json-data

			for(var i = 0; i < data.length; i++){
		          var injectButton = @(html->js-injector (talk-button "" "" ""));
			  var button = injectButton(document.querySelector(@(~j "#NAMESPACE_target")));
			  @(call-method 'button 'setText @js{data[i].text});
			  @(call-method 'button 'setSpeech @js{data[i].say});
			  @(call-method 'button 'setImg @js{data[i].img});
			}
		      }))))

(define (talk-button to-say text img-url)
  (enclose
    (button-warning id: (id "button")
      style: (properties height: 100
			 cursor: "pointer"
			 margin: 20)
      'onclick: (~a "var msg = new SpeechSynthesisUtterance(); msg.voice = speechSynthesis.getVoices()[2]; msg.text = '" to-say "'; window.speechSynthesis.speak(msg);")
      (div 

	(img id: (id "img")
	     src: (~a "images/" img-url) 
	     style:"width:50px;")
	(div id: (id "text") text)))
    (script ()
	    (function (setText s)
		      @js{
		      document.querySelector(@(~j "#NAMESPACE_text")).innerHTML = s
		      })
	    (function (setSpeech s)
		      @js{
		      $(@(~j "#NAMESPACE_button")).attr("onclick",
		         "var msg = new SpeechSynthesisUtterance(); msg.voice = speechSynthesis.getVoices()[2]; msg.text = '" + s + "'; window.speechSynthesis.speak(msg);"
		      )})
	    (function (setImg i)
		      @js{

		      $(@(~j "#NAMESPACE_img")).attr("src", i)
		      })
	    )))

(define (aac)
  (page index.html
	(content
	  (container
	    (talk-buttons
	      @js{
	      [{text: "bird", say: "bird", img: "images/bird.png"},
	       {text: "dog", say: "dog",  img: "images/dog.png"},
	       {text: "cat", say: "cat",  img: "images/cat2.png"}]
	      })
	    ))))

(render #:to "out" 
	(list 
	  (bootstrap-files)
	  (aac)
	  images))
