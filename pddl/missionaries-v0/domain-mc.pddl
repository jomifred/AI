(define (domain mc)
(:requirements :strips :typing :fluents :equality :action-costs)

(:types side person)

(:predicates
       (boat_at ?s - side)
       (at ?p - person ?s - side)
)

(:functions
       (total-cost)
       - number
)

(:action move1
  :parameters   (?f ?t - side ?p1 - person)
  :precondition (and (boat_at ?f)
                     (at ?p1 ?f)
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (not (at ?p1 ?f)) (at ?p1 ?t)
                     (increase (total-cost) 1)
                )
)

(:action move2
  :parameters   (?f ?t - side ?p1 ?p2 - person)
  :precondition (and (not (= ?p1 ?p2))
                     (boat_at ?f)
                     (at ?p1 ?f) (at ?p2 ?f)
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (not (at ?p1 ?f)) (at ?p1 ?t)
                     (not (at ?p2 ?f)) (at ?p2 ?t)
                     (increase (total-cost) 1)
                )
)

)
