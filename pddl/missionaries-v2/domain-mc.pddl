(define (domain mc)
(:requirements :strips :typing :fluents :equality :action-costs)

(:types side kind crew)

(:predicates
       (boat_at ?s - side)
)

(:functions
       (crew_vl ?c) ; maps one -> 1; two -> 2
       (pop_at ?k - kind ?s - side)
       (total-cost)
       - number
)

(:action move_m
  :parameters   (?c - crew ?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at mis ?f) (crew_vl ?c))
                     (or (=  (pop_at mis ?f) (crew_vl ?c))
                         (>= (- (pop_at mis ?f) (crew_vl ?c)) (pop_at can ?f)))
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at mis ?f) (crew_vl ?c))
                     (increase (pop_at mis ?t) (crew_vl ?c))
                     (increase (total-cost) 1)
                )
)

(:action move_c
  :parameters   (?c - crew ?f ?t - side)
  :precondition (and (boat_at ?f)
                     (>= (pop_at can ?f) (crew_vl ?c))
                     (or (=  (pop_at mis ?t) 0)
                         (>= (pop_at mis ?t) (+ (crew_vl ?c) (pop_at can ?t))))
                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at can ?f) (crew_vl ?c))
                     (increase (pop_at can ?t) (crew_vl ?c))
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
