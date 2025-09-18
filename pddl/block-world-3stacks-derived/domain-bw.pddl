(define (domain blocksworld3sd)
(:requirements :strips :typing :existential-preconditions :negative-preconditions :derived-predicates)

; simplifies pre-conditions with derived predicates

(:types block stack)
(:predicates (clear-table ?p - stack)
             (on-table ?x - block)
             (arm-empty)
             (clear ?x - block)
             (holding ?x - block)
             (on ?x - block ?y - block)
             (block-at ?x - block ?p - stack))

(:derived (clear-table ?p - stack)
    (not (exists (?b - block) (block-at ?b ?p))))
(:derived (on-table ?x - block)
    (not (exists (?b - block) (on ?x ?b))))
(:derived (arm-empty)
    (not (exists (?b - block) (holding ?b))))
(:derived (clear ?x - block)
    (not (exists (?b - block) (on ?b ?x))))

(:action pickup
  :parameters   (?ob - block ?p - stack)
  :precondition (and 
                (clear ?ob)
                (on-table ?ob)
                (arm-empty)
                (block-at ?ob ?p) )
  :effect (and  (holding ?ob)
                (not (block-at ?ob ?p)))
)

(:action putdown
  :parameters   (?ob - block ?p - stack)
  :precondition (and 
                (holding ?ob) 
                (clear-table ?p) )
  :effect (and  (block-at ?ob ?p)
                (not (holding ?ob)) ))

(:action unstack
  :parameters   (?ob - block ?underob - block ?p - stack)
  :precondition (and 
                (on ?ob ?underob) 
                (clear ?ob)
                (arm-empty) 
                (block-at ?ob ?p))
  :effect (and  (holding ?ob)
                (not (block-at ?ob ?p)) 
                (not (on ?ob ?underob)) ))


(:action stack
  :parameters   (?ob - block ?underob - block ?p - stack)
  :precondition (and 
                (holding ?ob)
                (clear ?underob) 
                (block-at ?underob ?p))
  :effect (and  (on ?ob ?underob) 
                (block-at ?ob ?p)
                (not (holding ?ob))))

)
