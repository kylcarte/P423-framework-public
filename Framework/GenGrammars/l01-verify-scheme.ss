(import (Framework match) (Framework prims))

(define verify-grammar:l01-verify-scheme
  (lambda (x)
    (define Prog
      (lambda (x)
        (match x
          [(begin ,(Statement -> x1) ... ,(Statement -> x2))
           (any x2 x1)]
          [,e (invalid-expr 'Prog e)])))
    (define Statement
      (lambda (x)
        (match x
          [(set! ,(Var -> x1) ,(Int -> x2)) (any x2 x1)]
          [(set! ,(Var -> x1) ,(Var -> x2)) (any x2 x1)]
          [(op-set!
             ,(Var -> x1)
             (,(Binop -> x2) ,(Var -> x3) ,(Int -> x4)))
           (any x4 x3 x2 x1)]
          [(op-set!
             ,(Var -> x1)
             (,(Binop -> x2) ,(Var -> x3) ,(Var -> x4)))
           (any x4 x3 x2 x1)]
          [,e (invalid-expr 'Statement e)])))
    (define Var
      (lambda (x)
        (match x
          [,e (guard (not [Reg e])) #f]
          [,e (invalid-expr 'Var e)])))
    (let ([res (Prog x)])
      (if res (errorf 'verify-grammar:l01-verify-scheme res) x))))
