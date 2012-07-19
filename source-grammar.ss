;; P423
;; Week 2 grammars
;;
;; Passes:
;;   verify-scheme    l-01 -> l-01
;;   expose-frame-var l-01 -> l-37
;;   flatten-program  l-37 -> l-41
;;   generate-x86-64  l-41 -> ()

(p423-grammars
 (l01-verify-scheme
  (start Prog)
  (Prog
   (letrec ((Label (lambda () Tail)) *) Tail))
  (Tail
   (Triv)
   (begin Effect * Tail))
  (Effect
   (set! Var Triv)
   (set! Var (Binop Triv Triv)))
  (Triv
   Var
   Integer
   Label)
  (Var
   Reg
   FVar))

 (l37-expose-frame-var
  (%remove
   FVar)
  (%rename
   (FVar -> Disp)))

 (l41-flatten-program
  (%remove
   Prog
   Tail)
  (%rename
   (Effect -> Statement)
   (Tail -> Statement))
  (%add
   (Prog
    (code Statement * Statement))
   (Statement
    (jump Triv)
    (label Label)))))
