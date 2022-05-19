(define (domain blocksworld3p)
(:requirements :strips :equality)
(:predicates (clear ?x ?p)
             (clear-table ?p)
             (on-table ?x ?p)
             (arm-empty)
             (holding ?x)
             (on ?x ?y ?p))

(:action pickup
  :parameters (?ob ?p)
  :precondition (and (clear ?ob ?p) (on-table ?ob ?p) (arm-empty))
  :effect (and (holding ?ob) (clear-table ?p) (not (clear ?ob ?p)) (not (on-table ?ob ?p))
               (not (arm-empty))))

(:action putdown
  :parameters  (?ob ?p)
  :precondition (and (holding ?ob) (clear-table ?p))
  :effect (and (clear ?ob ?p) (arm-empty) (on-table ?ob ?p)
               (not (holding ?ob)) (not (clear-table ?p)) ))

(:action unstack
  :parameters  (?ob ?underob ?p)
  :precondition (and (on ?ob ?underob ?p) (clear ?ob ?p) (arm-empty))
  :effect (and (holding ?ob) (clear ?underob ?p)
               (not (on ?ob ?underob ?p)) (not (clear ?ob ?p)) (not (arm-empty))))

(:action stack
  :parameters  (?ob ?underob ?p)
  :precondition (and (clear ?underob ?p) (holding ?ob))
  :effect (and (arm-empty) (clear ?ob ?p) (on ?ob ?underob ?p)
               (not (clear ?underob ?p)) (not (holding ?ob))))

)
