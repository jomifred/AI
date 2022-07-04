(define (problem mc)
   (:domain mc)
   (:objects
        left right - side
        mis can - kind
        one two - crew

   )
   (:init (boat_at left)
          (= (crew_vl one) 1)
          (= (crew_vl two) 2)

          (= (pop_at mis left)  3)
          (= (pop_at can left)  3)
          (= (pop_at mis right) 0)
          (= (pop_at can right) 0)

          (= (total-cost) 0)
   )
   (:goal (and (= (pop_at mis left)  0)
               (= (pop_at can left)  0)
               (= (pop_at mis right) 3)
               (= (pop_at can right) 3)
          )
   )
   (:metric minimize (total-cost))
)
