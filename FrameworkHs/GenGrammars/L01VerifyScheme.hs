{-# LANGUAGE StandaloneDeriving #-}

module FrameworkHs.GenGrammars.L01VerifyScheme where

import StringTable.Atom
import Data.Int
import FrameworkHs.Prims
import FrameworkHs.Helpers

data Prog
  = Begin [Statement] Statement
data Statement
  = Set Var Int
  | Set' Var Var
  | OpSet Var Binop Var Int
  | OpSet' Var Binop Var Var
data Var
  = Reg Reg

instance PP Var where
  pp (Reg r) = (pp r)
instance PP Statement where
  pp (Set v i) = (ppSexp ["set!",(pp v),(pp i)])
  pp (Set' v v2) = (ppSexp ["set!",(pp v),(pp v2)])
  pp (OpSet v b v2 i) = (ppSexp ["op-set!",(pp v),(ppSexp [(pp b),(pp v2),(pp i)])])
  pp (OpSet' v b v2 v3) = (ppSexp ["op-set!",(pp v),(ppSexp [(pp b),(pp v2),(pp v3)])])
instance PP Prog where
  pp (Begin l s) = (ppSexp ("begin" : ((map pp l) ++ [(pp s)])))

deriving instance Read Prog
deriving instance Show Prog
deriving instance Eq Prog
deriving instance Read Statement
deriving instance Show Statement
deriving instance Eq Statement
deriving instance Read Var
deriving instance Show Var
deriving instance Eq Var
