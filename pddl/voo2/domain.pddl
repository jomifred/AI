(define (domain voo)
(:requirements :strips :typing :durative-actions :fluents)
(:types airplane airport cargo)

(:predicates (cargo-at ?x - cargo ?a    - airport) 
             (cargo-in ?c - cargo  ?p - airplane)
             (plane-at ?x - airplane ?a - airport)
)

(:durative-action load
  :parameters (?c - cargo ?p - airplane ?a - airport)
  :duration (= ?duration 1)
  :condition (and 
    (at start (cargo-at ?c ?a))
    (over all (plane-at ?p ?a))
  )
  :effect (and 
    (at start (not (cargo-at ?c ?a)))
    (at end (cargo-in ?c ?p))
  )
)

(:durative-action unload
  :parameters (?c - cargo ?p - airplane ?a - airport)
  :duration (= ?duration 1)
  :condition (and 
    (at start (cargo-in ?c ?p))
    (over all (plane-at ?p ?a))
  )
  :effect (and 
    (at start (not (cargo-in ?c ?p)))
    (at end (cargo-at ?c ?a))
  )
)

(:durative-action fly
  :parameters (?p - airplane ?f ?t - airport) 
  :duration (= ?duration 5)
  :condition (and 
    (at start (plane-at ?p ?f))
  )
  :effect (and 
    (at start (not (plane-at ?p ?f)))
    (at end (plane-at ?p ?t))
  )
)

)
