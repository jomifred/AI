(define (problem slide)
   (:domain voo)
   (:objects c1 c2   - cargo
             jfk sfo - airport
             p1 p2   - airplane)
   (:init (at c1 sfo) (at c2 jfk) (at p1 sfo) (at p2 jfk))
   (:goal (and (at c1 jfk) (at c2 sfo)))
)

; try LAMA to solve