(define (problem listaexercicio6)
   (:domain blocksworld3sd)
   (:objects a b c d e f g - block 
             p1 p2 p3      - stack)
   (:init (on b a) (on c b)
          (on e d)
          (on g f) 
          (block-at a p1) (block-at b p1) (block-at c p1)
          (block-at d p2) (block-at e p2)
          (block-at f p3) (block-at g p3)
   )
   (:goal (and (block-at a p2) (on b a) (on c b) (on g c) (on f g)
               (block-at e p3) (on d e) 
          ))
)

; solve with LAMA