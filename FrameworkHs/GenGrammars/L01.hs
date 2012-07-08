{-# LANGUAGE StandaloneDeriving #-}

module FrameworkHs.GenGrammars.L01 where

import StringTable.Atom
import Data.Int
import FrameworkHs.Prims
import FrameworkHs.Helpers

data Prog
  = Letrec [(Label,Tail)] Tail
data Tail
  = App Triv
  | Begin [Effect] Tail
data Effect
  = Set Var Triv
  | OpSet Var Binop Triv Triv
data Triv
  = Var Var
  | Int Int
  | Label Label
data Var
  = Reg Reg
  | FVar FVar

instance PP Var where
  pp (Reg r) = (pp r)
  pp (FVar f) = (pp f)
instance PP Triv where
  pp (Var v) = (pp v)
  pp (Int i) = (pp i)
  pp (Label l) = (pp l)
instance PP Effect where
  pp (Set v t) = (ppSexp ["set!",(pp v),(pp t)])
  pp (OpSet v b t t2) = (ppSexp ["op-set!",(pp v),(ppSexp [(pp b),(pp t),(pp t2)])])
instance PP Tail where
  pp (App t) = (ppSexp ["app",(pp t)])
  pp (Begin l t) = (ppSexp ("begin" : ((map pp l) ++ [(pp t)])))
instance PP Prog where
  pp (Letrec l t) = (ppSexp ["letrec",(map (\(l,t) -> (ppSexp [(pp l),(ppSexp ["lambda",(ppSexp []),(pp t)])])) l),(pp t)])

deriving instance Read Prog
deriving instance Show Prog
deriving instance Eq Prog
deriving instance Ord Prog
deriving instance Read Tail
deriving instance Show Tail
deriving instance Eq Tail
deriving instance Ord Tail
deriving instance Read Effect
deriving instance Show Effect
deriving instance Eq Effect
deriving instance Ord Effect
deriving instance Read Triv
deriving instance Show Triv
deriving instance Eq Triv
deriving instance Ord Triv
deriving instance Read Var
deriving instance Show Var
deriving instance Eq Var
deriving instance Ord Var
