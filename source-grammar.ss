;; P423
;; Week 1 grammars
;;
;; Passes:
;;   verify-scheme
;;   generate-x86-64

(p423-grammars
 (l-01
  (start Prog)
  (Prog
   (begin Statement * Statement))
  (Statement
   (set! Var Int)
   (set! Var Var)
   (op-set! Var (Binop Var Int))
   (op-set! Var (Binop Var Var)))
  (Var Reg)))
