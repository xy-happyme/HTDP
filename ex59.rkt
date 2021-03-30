;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex59) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define RADIUS 5)
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; TrafficLight -> 
; yields the next state on, given current state cs
(define (LIGHT-ON cs LIGHT-COLOR)
  (if (string=? cs LIGHT-COLOR)
      (circle RADIUS "solid" LIGHT-COLOR)
      (circle RADIUS "outline" LIGHT-COLOR)
      )
  )

; TrafficLight -> image
; given current state cs,render the cs light as a solid circle if the light is 'on'
(define (tl-next cs)
  (cond [(string=? cs "red") "green"]
        [(string=? cs "green") "yellow"]
        [(string=? cs "yellow") "red"]
   )
  )

; TrafficLight -> Image
(define (TRAFFIC-LIGHTS cs) 
  (place-images
   (list (LIGHT-ON cs "red")
         (LIGHT-ON cs "yellow")
         (LIGHT-ON cs "green")
         )
   (list (make-posn (* RADIUS 2) 10 )
         (make-posn (* RADIUS 5) 10 )
         (make-posn (* RADIUS 8) 10 )
         )
   (rectangle 50 20 "solid" "mediumgoldenrod")
   )
  )

   
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render cs)
  (overlay (TRAFFIC-LIGHTS cs) BACKGROUND)
  )

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))