{-# LANGUAGE StandaloneDeriving #-}

module FrameworkHs.GenGrammars.L41FlattenProgram where

import StringTable.Atom
import Data.Int
import FrameworkHs.Prims
import FrameworkHs.Helpers

data Statement
  = Set Var Triv
  | OpSet Var Binop Triv Triv
data Triv
  = Var Var
  | Int Int
  | Label Label
data Var
  = Reg Reg
  | Disp Disp
data Disp
  = DispD Reg Int
data Prog
  = Code [Statement] Statement
  | Jump Triv

instance PP Prog where
  pp (Code l s) = (ppSexp ("code" : ((map pp l) ++ [(pp s)])))
  pp (Jump t) = (ppSexp ["jump",(pp t)])
instance PP Disp where
  pp (DispD r i) = (ppSexp ["disp",(pp r),(pp i)])
instance PP Var where
  pp (Reg r) = (pp r)
  pp (Disp d) = (pp d)
instance PP Triv where
  pp (Var v) = (pp v)
  pp (Int i) = (pp i)
  pp (Label l) = (pp l)
instance PP Statement where
  pp (Set v t) = (ppSexp ["set!",(pp v),(pp t)])
  pp (OpSet v b t t2) = (ppSexp ["op-set!",(pp v),(ppSexp [(pp b),(pp t),(pp t2)])])

deriving instance Read Statement
deriving instance Show Statement
deriving instance Eq Statement
deriving instance Read Triv
deriving instance Show Triv
deriving instance Eq Triv
deriving instance Read Var
deriving instance Show Var
deriving instance Eq Var
deriving instance Read Disp
deriving instance Show Disp
deriving instance Eq Disp
deriving instance Read Prog
deriving instance Show Prog
deriving instance Eq Prog
