(define (domain voo)
(:requirements :strips :typing)
(:types airplane airport cargo)

(:predicates (at ?x - object ?a - airport)
             (in ?c - cargo  ?p - airplane))

(:action load
  :parameters (?c - cargo ?p - airplane ?a - airport)
  :precondition (and (at ?c ?a) (at ?p ?a))
  :effect (and (in ?c ?p) 
               (not (at ?c ?a))))

(:action unload
  :parameters (?c - cargo ?p - airplane ?a - airport)
  :precondition (and (in ?c ?p) (at ?p ?a))
  :effect (and (at ?c ?a) 
               (not (in ?c ?p))))

(:action fly
  :parameters (?a - airplane ?f ?t - airport) 
  :precondition (and (at ?a ?f))
  :effect (and (at ?a ?t) 
               (not (at ?a ?f))))

)
