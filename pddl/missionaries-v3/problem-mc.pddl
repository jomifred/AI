(define (problem mc)
   (:domain mc)
   (:objects
        left right - side
        mis can - kind
        none one two - crew
   )
   (:init (boat_at left)
          (= (crew_vl none) 0)
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

; output
; metric-ff: found legal plan as follows
; step   0: MOVE NONE TWO LEFT RIGHT ==> move 0 mis, 2 can from left margin to right
;        1: MOVE NONE ONE RIGHT LEFT
;        2: MOVE NONE TWO LEFT RIGHT
;        3: MOVE NONE ONE RIGHT LEFT
;        4: MOVE TWO NONE LEFT RIGHT
;        5: MOVE ONE ONE RIGHT LEFT
;        6: MOVE TWO NONE LEFT RIGHT
;        7: MOVE NONE ONE RIGHT LEFT
;        8: MOVE NONE TWO LEFT RIGHT
;        9: MOVE ONE NONE RIGHT LEFT
;       10: MOVE ONE ONE LEFT RIGHT
;;plan cost: 11.000000
