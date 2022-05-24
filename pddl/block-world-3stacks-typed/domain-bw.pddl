(define (domain blocksworld3s)
(:requirements :strips :typing)
(:types block stack)
(:predicates (clear-table ?p - stack)
             (on-table ?x - block)
             (arm-empty)
             (holding ?x - block)
             (clear ?x - block)
             (on ?x -block ?y - block)
             (block-at ?x - block ?p - stack))

(:action pickup
  :parameters (?ob - block ?p - stack)
  :precondition (and (clear ?ob) (on-table ?ob) (arm-empty) (block-at ?ob ?p) )
  :effect (and (holding ?ob) (clear-table ?p)
               (not (clear ?ob)) (not (on-table ?ob)) (not (block-at ?ob ?p)) (not (arm-empty))))

(:action putdown
  :parameters  (?ob - block ?p - stack)
  :precondition (and (holding ?ob) (clear-table ?p))
  :effect (and (clear ?ob) (arm-empty) (on-table ?ob) (block-at ?ob ?p)
               (not (holding ?ob)) (not (clear-table ?p)) ))

(:action unstack
  :parameters  (?ob - block ?underob -block ?p - stack)
  :precondition (and (on ?ob ?underob) (clear ?ob) (arm-empty) (block-at ?ob ?p))
  :effect (and (holding ?ob) (clear ?underob)
               (not (block-at ?ob ?p)) (not (on ?ob ?underob)) (not (clear ?ob)) (not (arm-empty))))

(:action stack
  :parameters  (?ob - block ?underob - block ?p - stack)
  :precondition (and (clear ?underob) (holding ?ob))
  :effect (and (arm-empty) (clear ?ob) (on ?ob ?underob) (block-at ?ob ?p)
               (not (clear ?underob)) (not (holding ?ob))))

)
