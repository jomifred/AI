(define (domain mc)
(:requirements :strips :typing :fluents :equality :action-costs :disjunctive-preconditions)

(:types side kind crew)

(:predicates
       (boat_at ?s - side)
)

(:functions
       (crew_vl ?c - crew) ; maps one -> 1; two -> 2; none -> 0
       (pop_at ?k - kind ?s - side)
       (total-cost)
       - number
)

(:action move
  :parameters   (?cm ?cc - crew ?f ?t - side)
                ; cm is the number of mis in the crew
                ; cc is the number of can is the crew
                ; cm and cc are symbols (none, one, two) and function crew_vl translates them to a number

  :precondition (and (boat_at ?f)
                     (not (= ?f ?t))

                     (>= (pop_at mis ?f) (crew_vl ?cm))
                     (>= (pop_at can ?f) (crew_vl ?cc))
                     (>= (+ (crew_vl ?cm) (crew_vl ?cc)) 1)
                     (<= (+ (crew_vl ?cm) (crew_vl ?cc)) 2)

                     ; check the 'from' side
                     (or (=  (pop_at mis ?f) (crew_vl ?cm))     ; all mis will move OR
                         (>= (- (pop_at mis ?f) (crew_vl ?cm))  ; the remaining mis should be majority
                             (- (pop_at can ?f) (crew_vl ?cc)))
                     )

                     ; check the 'to' side
                     (or (=  (+ (pop_at mis ?t) (crew_vl ?cm)) 0)  ; no mis on destination OR
                         (>= (+ (pop_at mis ?t) (crew_vl ?cm))     ; they will be majority there
                             (+ (pop_at can ?t) (crew_vl ?cc)))
                     )

                )
  :effect       (and
                     (not (boat_at ?f)) (boat_at ?t)
                     (decrease (pop_at mis ?f) (crew_vl ?cm))
                     (increase (pop_at mis ?t) (crew_vl ?cm))
                     (decrease (pop_at can ?f) (crew_vl ?cc))
                     (increase (pop_at can ?t) (crew_vl ?cc))
                     (increase (total-cost) 1)
                )
)

)
