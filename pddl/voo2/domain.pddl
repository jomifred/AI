(define (domain voo)
(:requirements :strips :typing :durative-actions :fluents)
(:types airplane airport cargo)

(:predicates (at ?x - object ?a - airport)
             (in ?c - cargo  ?p - airplane)
             (loaded ?p - airplane)
)

(:durative-action load
  :parameters (?c - cargo ?p - airplane ?a - airport)
  :duration (= ?duration 1)
  :condition (and 
    (at start (at ?c ?a))
    (over all (at ?p ?a))
  )
  :effect (and 
    (at end (in ?c ?p))
    (at end (loaded ?p))
    (at start (not (at ?c ?a)))
  )
)

(:durative-action unload
  :parameters (?c - cargo ?p - airplane ?a - airport)
  :duration (= ?duration 1)
  :condition (and 
    (at start (in ?c ?p))
    (over all (at ?p ?a))
  )
  :effect (and 
    (at end (at ?c ?a))
    (at end (not (loaded ?p)))
    (at start (not (in ?c ?p)))
  )
)

(:durative-action fly
  :parameters (?p - airplane ?f ?t - airport) 
  :duration (= ?duration 5)
  :condition (and 
    (at start (at ?p ?f))
    (over all (loaded ?p))
  )
  :effect (and 
    (at end (not (at ?p ?f)))
    (at end (at ?p ?t))
  )
)

)
