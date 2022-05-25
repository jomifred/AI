(define (domain jugs)
(:requirements :strips :typing :fluents :equality :conditional-effects)

(:types jug)

(:functions
       (capacity ?j - jug)   ; capacity of a jug
       (amount   ?j - jug)   ; litres of water in the jug
)

(:action fill
  :parameters   (?j - jug)
  :precondition (< (amount ?j) (capacity ?j))
  :effect       (and
                     (assign (amount ?j) (capacity ?j))
                )
)

(:action empty
  :parameters   (?j - jug)
  :precondition (> (amount ?j) 0)
  :effect       (and
                     (assign (amount ?j) 0)
                )
)

(:action pour2
  :parameters   (?jf ?jt - jug)
  :precondition (and (not (= ?jf ?jt))
                     (> (amount ?jf) 0)
                     (< (amount ?jt) (capacity ?jt) )
                     (>= (amount ?jf) (- (capacity ?jt) (amount ?jt)))
                )
  :effect       (and
                     (decrease (amount ?jf) (- (capacity ?jt) (amount ?jt) ))
                     (increase (amount ?jt) (- (capacity ?jt) (amount ?jt) ))
                )
)


(:action pour3
  :parameters   (?jf ?jt - jug)
  :precondition (and (not (= ?jf ?jt))
                     (> (amount ?jf) 0)
                     (< (amount ?jt) (capacity ?jt) )
                     (< (amount ?jf) (- (capacity ?jt) (amount ?jt)))
                )
  :effect       (and
                     (assign   (amount ?jf) 0)
                     (increase (amount ?jt) (amount ?jf) )
                )
)


)
