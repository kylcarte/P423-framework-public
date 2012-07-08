(import (Framework match) (Framework prims))

(define verify-grammar:l37-expose-frame-var
  (lambda (x)
    (define Prog
      (lambda (x)
        (match x
          [(letrec ([,(Label -> x1) (lambda () ,(Tail -> x2))] ...)
             ,(Tail -> x3))
           (any x3 x2 x1)]
          [,e (invalid-expr 'Prog e)])))
    (define Tail
      (lambda (x)
        (match x
          [(app ,(Triv -> x1)) (any x1)]
          [(begin ,(Effect -> x1) ... ,(Tail -> x2)) (any x2 x1)]
          [,e (invalid-expr 'Tail e)])))
    (define Effect
      (lambda (x)
        (match x
          [(set! ,(Var -> x1) ,(Triv -> x2)) (any x2 x1)]
          [(op-set!
             ,(Var -> x1)
             (,(Binop -> x2) ,(Triv -> x3) ,(Triv -> x4)))
           (any x4 x3 x2 x1)]
          [,e (invalid-expr 'Effect e)])))
    (define Triv
      (lambda (x)
        (match x
          [,e (guard (not [Var e])) #f]
          [,e (guard (not [Int e])) #f]
          [,e (guard (not [Label e])) #f]
          [,e (invalid-expr 'Triv e)])))
    (define Var
      (lambda (x)
        (match x
          [,e (guard (not [Reg e])) #f]
          [,e (guard (not [Disp e])) #f]
          [,e (invalid-expr 'Var e)])))
    (define Disp
      (lambda (x)
        (match x
          [(disp ,(Reg -> x1) ,(Int -> x2)) (any x2 x1)]
          [,e (invalid-expr 'Disp e)])))
    (let ([res (Prog x)])
      (if res
          (errorf 'verify-grammar:l37-expose-frame-var res)
          x))))
