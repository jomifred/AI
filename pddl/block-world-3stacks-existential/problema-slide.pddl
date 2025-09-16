(define (problem slide)
   (:domain blocksworld3se)
   (:objects a b c    - block
             p1 p2 p3 - stack
   )
   (:init (on c a)
          (block-at a p2)
          (block-at b p1)
          (block-at c p1)          
   )
   (:goal (and 
         (on a b) (on b c)
         (block-at c p3)
      )
   )
)
