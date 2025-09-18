(define (problem slide)
   (:domain blocksworld3sd)
   (:objects a b c    - block
             p1 p2 p3 - stack
   )
   (:init (on c a)
          (block-at a p2)
          (block-at b p1)
          (block-at c p1)          
   )
   (:goal (and 
          (block-at c p3)(on a b) (on b c))
   )
)

; solves with LAMA
