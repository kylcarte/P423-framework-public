(import (Framework match) (Framework prims))

(define verify-grammar:l41-flatten-program
  (lambda (x)
    (define Statement
      (lambda (x)
        (match x
          [(set! ,(Var -> x1) ,(Triv -> x2)) (any x2 x1)]
          [(op-set!
             ,(Var -> x1)
             (,(Binop -> x2) ,(Triv -> x3) ,(Triv -> x4)))
           (any x4 x3 x2 x1)]
          [,e (invalid-expr 'Statement e)])))
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
    (define Prog
      (lambda (x)
        (match x
          [(code ,(Statement -> x1) ... ,(Statement -> x2))
           (any x2 x1)]
          [(jump ,(Triv -> x1)) (any x1)]
          [,e (invalid-expr 'Prog e)])))
    (let ([res (Prog x)])
      (if res
          (errorf 'verify-grammar:l41-flatten-program res)
          x))))
