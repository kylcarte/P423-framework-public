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
   (set! Var Int64)
   (set! Var Var)
   (op-set! Var (Binop Var Int64))
   (op-set! Var (Binop Var Var)))
  (Var Reg)))
