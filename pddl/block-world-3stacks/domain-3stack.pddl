(define (domain blocksworld3s)
(:requirements :strips)
(:predicates (clear-table ?p)
             (on-table ?x)
             (arm-empty)
             (holding ?x)
             (clear ?x)
             (on ?x ?y)
             (block-at ?x ?p))

(:action pickup
  :parameters (?ob ?p)
  :precondition (and (clear ?ob) (on-table ?ob) (arm-empty) (block-at ?ob ?p) )
  :effect (and (holding ?ob) (clear-table ?p)
               (not (clear ?ob)) (not (on-table ?ob)) (not (block-at ?ob ?p)) (not (arm-empty))))

(:action putdown
  :parameters  (?ob ?p)
  :precondition (and (holding ?ob) (clear-table ?p))
  :effect (and (clear ?ob) (arm-empty) (on-table ?ob) (block-at ?ob ?p)
               (not (holding ?ob)) (not (clear-table ?p)) ))

(:action unstack
  :parameters  (?ob ?underob ?p)
  :precondition (and (on ?ob ?underob) (clear ?ob) (arm-empty) (block-at ?ob ?p))
  :effect (and (holding ?ob) (clear ?underob)
               (not (block-at ?ob ?p)) (not (on ?ob ?underob)) (not (clear ?ob)) (not (arm-empty))))

(:action stack
  :parameters  (?ob ?underob ?p)
  :precondition (and (clear ?underob) (holding ?ob) (block-at ?underob ?p))
  :effect (and (arm-empty) (clear ?ob) (on ?ob ?underob) (block-at ?ob ?p)
               (not (clear ?underob)) (not (holding ?ob))))

)
