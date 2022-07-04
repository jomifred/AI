(define (problem mc)
   (:domain mc)
   (:objects
        left right - side
        m1 m2 m3 - person
        c1 c2 c3 - person
   )
   (:init (boat_at left)
          (at m1 left) (at m2 left)  (at m3 left)
          (at c1 left) (at c2 left)  (at c3 left)
          (= (total-cost) 0)
   )
   (:goal (and (at m1 right) (at m2 right) (at m3 right)
               (at c1 right) (at c2 right) (at c3 right)
          )
   )
   (:metric minimize (total-cost))
)
