(define (domain blocksworld3se)
(:requirements :strips :typing :existential-preconditions :negative-preconditions)

; simplifies effects by using not exits instead of clear-table, on-table, arm-empty, clear

(:types block stack)
(:predicates ;(clear-table ?p - stack) => (not (exists (?b - block) (block-at ?b ?p)))
             ;(on-table ?x - block) => (not (exists (?b - block) (on ?x ?b)))
             ;(arm-empty) => (not (exists (?b - block) (holding ?b)))
             (holding ?x - block)
             ;(clear ?x - block) => (not (exists (?b - block) (holding ?b)))
             (on ?x - block ?y - block)
             (block-at ?x - block ?p - stack))

(:action pickup
  :parameters (?ob - block ?p - stack)
  :precondition (and 
      (not (exists (?b - block) (on ?b ?ob)))
      (not (exists (?b - block) (on ?ob ?b)))
      (not (exists (?b - block) (holding ?b)))
      (block-at ?ob ?p) )
  :effect (and (holding ?ob)
               (not (block-at ?ob ?p)) 
          )
)

(:action putdown
  :parameters  (?ob - block ?p - stack)
  :precondition (and (holding ?ob) 
                (not (exists (?b - block) (block-at ?b ?p))))
  :effect (and  (block-at ?ob ?p)
                (not (holding ?ob)) ))

(:action unstack
  :parameters  (?ob - block ?underob - block ?p - stack)
  :precondition (and (on ?ob ?underob) 
                (not (exists (?b - block) (on ?b ?ob)))
                (not (exists (?b - block) (holding ?b)))                
                (block-at ?ob ?p))
  :effect (and (holding ?ob)
               (not (block-at ?ob ?p)) (not (on ?ob ?underob)) ))


(:action stack
  :parameters  (?ob - block ?underob - block ?p - stack)
  :precondition (and (holding ?ob)
                (not (exists (?b - block) (on ?b ?underob))) 
                (block-at ?underob ?p))
  :effect (and  (on ?ob ?underob) 
                (block-at ?ob ?p)
                (not (holding ?ob))))

)
