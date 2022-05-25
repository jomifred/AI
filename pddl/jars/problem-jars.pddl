(define (problem jugs1)
   (:domain jugs)
   (:objects j4 j3 - jug)
   (:init (= (amount j4) 0)
          (= (amount j3) 0)
          (= (capacity j4) 4)
          (= (capacity j3) 3)
          (= (total-cost) 0)
   )
   (:goal (and (= (amount j4) 2)
               (= (amount j3) 0)
          ))
   (:metric minimize (total-cost))
)

; output from MetricFF:
; step    0: FILL J3
;         1: POUR-ALL J3 J4
;         2: FILL J3
;         3: POUR J3 J4
;         4: EMPTY J4
;         5: POUR-ALL J3 J4
