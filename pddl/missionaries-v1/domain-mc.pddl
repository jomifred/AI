(define (domain mc)
(:requirements :strips :typing :fluents :equality :action-costs)

(:types side kind)

(:predicates
       (boat_at ?s - side)
)

(:functions
       (pop_at ?k - kind ?s - side)
       (total-cost)
       - number
)

(:action move_m
  :parameters   (?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at mis ?f) 1)
                     (or (> (pop_at mis ?f) (pop_at can ?f))
                         (= (pop_at mis ?f) 1))
                     ; bug: should consider the ?t side
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at mis ?f) 1)
                     (increase (pop_at mis ?t) 1)
                     (increase (total-cost) 1)
                )
)

(:action move_mm
  :parameters   (?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at mis ?f) 2)
                     (or (>= (- (pop_at mis ?f) 2) (pop_at can ?f))
                         (=  (pop_at mis ?f) 2))
                     ; bug: should consider the ?t side
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at mis ?f) 2)
                     (increase (pop_at mis ?t) 2)
                     (increase (total-cost) 1)
                )
)

(:action move_c
  :parameters   (?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at can ?f) 1)
                     (or (= (pop_at mis ?t) 0)
                         (>= (pop_at mis ?t) (+ 1 (pop_at can ?t))))
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at can ?f) 1)
                     (increase (pop_at can ?t) 1)
                     (increase (total-cost) 1)
                )
)

(:action move_cc
  :parameters   (?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at can ?f) 2)
                     (or (= (pop_at mis ?t) 0)
                         (>= (pop_at mis ?t) (+ 2 (pop_at can ?t))))
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at can ?f) 2)
                     (increase (pop_at can ?t) 2)
                     (increase (total-cost) 1)
                )
)


(:action move_mc
  :parameters   (?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at mis ?f) 1)
                     (>= (pop_at can ?f) 1)

                     (<= (pop_at can ?t) (pop_at mis ?t))
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at mis ?f) 1)
                     (increase (pop_at mis ?t) 1)
                     (decrease (pop_at can ?f) 1)
                     (increase (pop_at can ?t) 1)
                     (increase (total-cost) 1)
                )
)


)
