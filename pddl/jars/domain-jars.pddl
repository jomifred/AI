(define (domain jugs)
(:requirements :strips :typing :fluents :equality :action-costs)

(:types jug)

(:functions
       (capacity ?j - jug)   ; capacity of a jug
       (amount   ?j - jug)   ; litres of water in the jug
       (total-cost)
       - number
)

(:action fill
  :parameters   (?j - jug)
  :precondition (< (amount ?j) (capacity ?j))
  :effect       (and
                     (assign (amount ?j) (capacity ?j))
                     (increase (total-cost) 1)
                )
)

(:action empty
  :parameters   (?j - jug)
  :precondition (> (amount ?j) 0)
  :effect       (and
                     (assign (amount ?j) 0)
                     (increase (total-cost) (capacity ?j)) ; to avoid wasting water
                )
)

(:action pour
  :parameters   (?jf ?jt - jug)
  :precondition (and (not (= ?jf ?jt))
                     (> (amount ?jf) 0)
                     (< (amount ?jt) (capacity ?jt) )
                     (>= (amount ?jf) (- (capacity ?jt) (amount ?jt)))
                )
  :effect       (and
                     (decrease (amount ?jf) (- (capacity ?jt) (amount ?jt) ))
                     (increase (amount ?jt) (- (capacity ?jt) (amount ?jt) ))
                     (increase (total-cost) 1)
                )
)


(:action pour-all
  :parameters   (?jf ?jt - jug)
  :precondition (and (not (= ?jf ?jt))
                     (> (amount ?jf) 0)
                     (< (amount ?jt) (capacity ?jt) )
                     (< (amount ?jf) (- (capacity ?jt) (amount ?jt)))
                )
  :effect       (and
                     (assign   (amount ?jf) 0)
                     (increase (amount ?jt) (amount ?jf) )
                     (increase (total-cost) 1)
                )
)


)
