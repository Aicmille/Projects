(require 2htdp/batch-io)
(require 2htdp/image)
(require 2htdp/universe)



;A ListOfZombies is one of:
; -empty
; -(cons Posn ListOfZombies)

;A Zworld is:
; -(make-zworld Pworld ListOfZombies)

(define-struct zworld [pw loz])
                            

;a Pworld is (make-pworld Posn Posn)

(define-struct pworld [player goal])


(define background (empty-scene 400 400))
(define player (beside (triangle 5 "solid" "blue")
                       (triangle 10 "solid" "gold")
                       (triangle 5 "solid" "blue")))
(define zombie (circle 5 "solid" "red"))
(define test1 (make-posn 10 10))
(define test2 (make-posn 20 20))
(define test3 (make-posn 0 0))
(define pworldtest(make-pworld test1 test3))
(define zworldtest (make-zworld pworldtest (cons (make-posn 10 10)
                                                 (cons (make-posn 100 100) empty))))

;draw-pworld: Pworld -> Image
;draws a Pworld

(check-expect (draw-pworld (make-pworld test1 test3))
              (place-image player 10 10 background))

(define (draw-pworld p)
  (place-image player
               (posn-x(pworld-player p))
               (posn-y(pworld-player p))
               background))

;draw-zombies: ListOfZombies -> Image
;draws a zombies from a ListOfZombies

(define (draw-zombies loz)
  (cond [(empty? loz) background]
        [(cons? loz) (place-image zombie
                                 (posn-x (first loz))
                                 (posn-y (first loz))
                                 (draw-zombies (rest loz)))]))

;draw-zworld: Zworld -> Image
;draws a Zworld

(check-expect (draw-zworld zworldtest) (place-image player
                                                    10 10
                                                    (place-image zombie
                                                                 10 10
                                                                 (place-image zombie
                                                                              100 100
                                                                              background))))
                                                                  

(define (draw-zworld zw)
  (place-image player (posn-x (pworld-player
                               (zworld-pw zw)))
               (posn-y (pworld-player
                               (zworld-pw zw)))
               (draw-zombies (zworld-loz zw))))


;update-pworld: Pworld Number Number MouseEvent->Pworld
;changes the goal position that the player is moving to


(check-expect (update-pgoal pworldtest 200 200 "button-down")
              (make-pworld test1 (make-posn 200 200)))

(check-expect (update-pgoal pworldtest 100 100 "drag")
              (make-pworld test1 (make-posn 100 100)))

(check-expect (update-pgoal pworldtest 200 200 "button-up")
              (make-pworld test1 test3))

(define (update-pgoal p x y me)
  (cond
    [(string=? "button-down" me) (make-pworld (pworld-player p)
                                              (make-posn x y))]
    [(string=? "drag" me) (make-pworld (pworld-player p)
                                              (make-posn x y))]
    [else (make-pworld (pworld-player p) (pworld-goal p))]))

;update-pgoal-2: Zworld Number Number MouseEvent -> Zworld
;updates the goal of the player’s movement to that of the input x and y coordinates.

(check-expect (update-pgoal-2 zworldtest 10 10 "ButtonDown")
              (make-zworld (make-pworld (make-posn 10 10) (make-posn 10 10)) (zworld-loz zworldtest)))
               
(define (update-pgoal-2 zw num1 num2 me)
  (make-zworld (make-pworld (pworld-player (zworld-pw zw))
                            (make-posn num1 num2))
               (zworld-loz zw)))


;posn-diff: Posn Posn -> Posn
;subtracts the second posn x and y values from the first posn x and y values and make a new posn

(check-expect (posn-diff test2 test1a) (make-posn 10 10))
(check-expect (posn-diff test2 test3a) (make-posn 20 20))

(define (posn-diff posn1 posn2)
  (make-posn (- (posn-x posn1) (posn-x posn2))
             (- (posn-y posn1) (posn-y posn2))))

;dist : Posn Posn -> Number
;computes the distance between two Posns

(define (dist p1 p2)
  (sqrt (+ (sqr (- (posn-x p1) (posn-x p2)))
           (sqr (- (posn-y p1) (posn-y p2))))))

(check-expect (dist (make-posn -3 -4) test3a) 5)
(check-expect (dist (make-posn 0 0) test3a) 0)

;direction : Posn Posn -> Posn
;computes the direction from p to goal,
;represented as a Posn whose distance from the origin is 1

(define (direction p goal)
  (posn-scale (/ 1 (dist p goal)) (posn-diff goal p)))
 
(check-expect (direction (make-posn 230 240) (make-posn 200 200))
              (make-posn -3/5 -4/5))
(check-expect (direction (make-posn 170 240) (make-posn 200 200))
              (make-posn 3/5 -4/5))
(check-expect (direction (make-posn 230 160) (make-posn 200 200))
              (make-posn -3/5 4/5))
(check-expect (direction (make-posn 170 160) (make-posn 200 200))
              (make-posn 3/5 4/5))

;posn-scale: Number Posn -> Posn
;scales the given cosn by the given number

(check-expect (posn-scale 10 test1a) (make-posn 100 100))
(check-expect (posn-scale 10 test3a) (make-posn 0 0))

(define (posn-scale num posn1)
  (make-posn (* (posn-x posn1) num)
             (* (posn-y posn1) num)))

;posn-sum: Posn Posn -> Posn
;sums the x and y coordinates of 2 Posns into a new Posn

(define test1a (make-posn 10 10))
(define test2a (make-posn 20 20))
(define test3a (make-posn 0 0))

(check-expect (posn-sum test1a test2a) (make-posn 30 30))
(check-expect (posn-sum test1a test3a) (make-posn 10 10))

(define (posn-sum posn1 posn2)
  (make-posn (+ (posn-x posn1) (posn-x posn2))
             (+ (posn-y posn1) (posn-y posn2))))

;approach-helper : Posn Posn Number -> Posn
;moves the player to the goal at speed s

(define (approach-helper p goal s)
  (posn-sum p (posn-scale s (direction p goal))))

(check-expect (approach-helper (make-posn 230 240) (make-posn 200 200) 10) (make-posn 224 232))
(check-expect (approach-helper (make-posn 170 240) (make-posn 200 200) 10) (make-posn 176 232))

;approach: Posn Posn Number->Posn
;moves the player to the goal and stops moving player at the goal

(define (approach p goal s)
  (cond
    [(> (dist p goal) s) (approach-helper p goal s)]
    [(<= (dist p goal) s) (make-posn (posn-x goal) (posn-y goal))]))

(check-expect (approach (make-posn 230 240) (make-posn 200 200) 10) (make-posn 224 232))
(check-expect (approach (make-posn 0 240) (make-posn 0 235) 10) (make-posn 0 235))
(check-expect (approach (make-posn 0 240) (make-posn 0 240) 10) (make-posn 0 240))

;move-zombies: ListOfZombies Posn -> ListOfZombies
;moves all of the zombies towards the input Posn.

(define loztest (cons (make-posn 200 200) empty))

(check-expect (move-zombies loztest (make-posn 0 200))
              (cons (make-posn 198 200) empty))

(define (move-zombies loz p)
  (cond [(empty? loz) empty]
        [(cons? loz) (cons (approach (first loz)
                                     p 2)
                           (move-zombies (rest loz) p))]))


;move-everyone: Zworld -> Zworld
;moves the player icon towards the goal position in the Pworld in the given Zworld
;it also moves all of the zombies towards the player icon.

(check-expect (move-everyone (make-zworld
               (make-pworld (make-posn 0 200) (make-posn 100 200))
               loztest))
              (make-zworld
               (make-pworld (make-posn 3 200) (make-posn 100 200))
               (cons (make-posn 198 200) empty)))

(define (move-everyone zw)
  (make-zworld
   (make-pworld
    (approach (pworld-player (zworld-pw zw)) (pworld-goal (zworld-pw zw)) 3)
    (pworld-goal (zworld-pw zw)))
    (move-zombies (zworld-loz zw) (pworld-player (zworld-pw zw)))))


(define ten-zombies
  (cons (make-posn (random 400) (random 400))
      (cons (make-posn (random 400) (random 400))
            (cons (make-posn (random 400) (random 400))
                  (cons (make-posn (random 400) (random 400))
                        (cons (make-posn (random 400) (random 400))
                              (cons (make-posn (random 400) (random 400))
                                    (cons (make-posn (random 400) (random 400))
                                          (cons (make-posn (random 400) (random 400))
                                               (cons (make-posn (random 400) (random 400))
                                          (cons (make-posn (random 400) (random 400)) empty)))))))))))


(define close-enough 3)

;the-end: Zworld -> Boolean
;check to see if the player has been eaten

(check-expect (the-end
               (make-zworld
                (make-pworld (make-posn 100 100) (make-posn 100 100))
                (cons (make-posn 101 101) empty))) true)
(check-expect (the-end
               (make-zworld
                (make-pworld (make-posn 100 100) (make-posn 100 100))
                (cons (make-posn 150 150) empty))) false)


(define (the-end zw)
  (cond [(empty? (zworld-loz zw)) false]
        [(>= close-enough (dist (first (zworld-loz zw))
                                (pworld-player (zworld-pw zw)))) true]
        [else (the-end (make-zworld
                        (make-pworld (pworld-player (zworld-pw zw))
                                     (pworld-goal (zworld-pw zw)))
                        (rest (zworld-loz zw))))]))


;A World is a Zworld

(define run
  (big-bang (make-zworld (make-pworld (make-posn 200 200)
                                      (make-posn 200 200))
                         ten-zombies)
    [to-draw draw-zworld] ;Zworld -> Image
    [on-mouse update-pgoal-2] ;Zworld Number Number MouseEvent -> Zworld
    [on-tick move-everyone] ;Zworld -> Zworld
    [stop-when the-end])) ;Zworld -> Zworld
    
