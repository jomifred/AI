(define (problem listaexercicio6)
   (:domain blocksworld)
   (:objects a b c d e f g)
   (:init (on-table a) (on b a) (on c b) (clear c)
          (on-table d) (on e d) (clear e)
          (on-table f) (on g f) (clear g)
          (arm-empty))
   (:goal (and (on b a) (on c b) (on g c) (on f g) (clear f)
               (on d e) (clear d)
          ))
)
