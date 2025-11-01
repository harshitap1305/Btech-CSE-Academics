(define (domain gripper-domain)
  (:requirements :strips :typing)

  (:types
    room ball gripper
  )

  (:predicates
    (ROOM ?x - room)
    (BALL ?x - ball)
    (GRIPPER ?x - gripper)
    (at-robby ?x - room)
    (at-ball ?x - ball ?y - room)
    (free ?x - gripper)
    (carry ?x - gripper ?y - ball)
  )

  ;; Action 1: Move(x, y)
  (:action Move
    :parameters (?x - room ?y - room)
    :precondition (and
      (ROOM ?x)
      (ROOM ?y)
      (at-robby ?x)
    )
    :effect (and
      (not (at-robby ?x))
      (at-robby ?y)
    )
  )

  ;; Action 2: Pick-Up(x, y, z)
  (:action Pick-Up
    :parameters (?x - ball ?y - room ?z - gripper)
    :precondition (and
      (BALL ?x)
      (ROOM ?y)
      (GRIPPER ?z)
      (at-ball ?x ?y)
      (at-robby ?y)
      (free ?z)
    )
    :effect (and
      (carry ?z ?x)
      (not (at-ball ?x ?y))
      (not (free ?z))
    )
  )

  ;; Action 3: Drop(x, y, z)
  (:action Drop
    :parameters (?x - ball ?y - room ?z - gripper)
    :precondition (and
      (BALL ?x)
      (ROOM ?y)
      (GRIPPER ?z)
      (carry ?z ?x)
      (at-robby ?y)
    )
    :effect (and
      (at-ball ?x ?y)
      (free ?z)
      (not (carry ?z ?x))
    )
  )
)
