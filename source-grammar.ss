;; P423
;; Week 1 grammars
;;
;; Passes:
;;   verify-scheme
;;   generate-x86-64

(p423-grammars
 (l01-verify-scheme
  (start Prog)
  (Prog
   (begin Statement * Statement))
  (Statement
   (set! Var Integer)
   (set! Var Var)
   (op-set! Var (Binop Var Integer))
   (op-set! Var (Binop Var Var)))
  (Var Reg)))
