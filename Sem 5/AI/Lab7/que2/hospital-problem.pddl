(define (problem hospital-problem)
  (:domain hospital-domain)

  (:objects
    a1 a2 - ambulance
    p1 p2 p3 - patient
    loc1 loc2 loc3 - location
    h1 h2 - hospital
  )

  (:init
    ;; Ambulances initial positions
    (at a1 h1)
    (at a2 h2)

    ;; Patients initial positions
    (patient-at p1 loc1)
    (patient-at p2 loc2)
    (patient-at p3 loc3)

    ;; Bidirectional connectivity between all required routes
    (connected h1 loc1)
    (connected loc1 h1)
    (connected h1 loc3)
    (connected loc3 h1)
    (connected h2 loc2)
    (connected loc2 h2)

    ;; All routes are unblocked
    (not (blocked h1 loc1))
    (not (blocked loc1 h1))
    (not (blocked h1 loc3))
    (not (blocked loc3 h1))
    (not (blocked h2 loc2))
    (not (blocked loc2 h2))

    ;; Both ambulances are empty
    (empty a1)
    (empty a2)
  )

  (:goal (and
    (patient-at p1 h1)
    (patient-at p2 h2)
    (patient-at p3 h1)
  ))
)
