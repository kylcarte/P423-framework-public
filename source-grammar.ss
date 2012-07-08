;; P423
;; Week 2 grammars
;;
;; Passes:
;;   verify-scheme    l-01 -> l-01
;;   expose-frame-var l-01 -> l-37
;;   flatten-program  l-37 -> l-41
;;   generate-x86-64  l-41 -> ()

(p423-grammars
 (l-01
  (start Prog)
  (Prog
   (letrec ((Label (lambda () Tail)) *) Tail))
  (Tail
   (app Triv)
   (begin Effect * Tail))
  (Effect
   (set! Var Triv)
   (op-set! Var (Binop Triv Triv)))
  (Triv
   Var
   Int
   Label)
  (Var
   Reg
   FVar))

 (l-37
  (%remove
   FVar)
  (%rename
   (FVar -> Disp))
  (%add
   (Disp
    (disp Reg Int))))

 (l-41
  (%remove
   Prog
   Tail)
  (%rename
   (Effect -> Statement)
   (Tail -> Statement))
  (%add
   (Prog
    (code Statement * Statement)
    (jump Triv)))))
