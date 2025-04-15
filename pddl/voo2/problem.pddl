(define (problem slide)
   (:domain voo)
   (:objects c1 c2   - cargo
             jfk sfo - airport
             p1 p2   - airplane)
   (:init (cargo-at c1 sfo) (cargo-at c2 jfk) 
          (plane-at p1 sfo) (plane-at p2 jfk))
   (:goal (and (cargo-at c1 jfk) (cargo-at c2 sfo)))
)

; solve with Optic