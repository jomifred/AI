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

; ff: found legal plan as follows
; step    0: MOVE_C TWO LEFT RIGHT
;         1: MOVE_C ONE RIGHT LEFT
;         2: MOVE_C TWO LEFT RIGHT
;         3: MOVE_C ONE RIGHT LEFT
;         4: MOVE_M TWO LEFT RIGHT
;         5: MOVE_MC RIGHT LEFT
;         6: MOVE_M TWO LEFT RIGHT
;         7: MOVE_C ONE RIGHT LEFT
;         8: MOVE_C TWO LEFT RIGHT
;         9: MOVE_C ONE RIGHT LEFT
;        10: MOVE_C TWO LEFT RIGHT
; plan cost: 11.000000
