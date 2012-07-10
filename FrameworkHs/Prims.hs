
module FrameworkHs.Prims
  ( UVar ( UV )
  , FVar ( FV )
  , Label ( L )
  , Reg ( RAX
        , RCX 
        , RDX 
        , RBX 
        , RBP 
        , RSI 
        , RDI 
        , R8 
        , R9 
        , R10 
        , R11 
        , R12 
        , R13 
        , R14 
        , R15
        )
  , Relop ( LT
          , LTE
          , EQ
          , GT
          , GTE
          )
  , Binop ( MUL
          , ADD
          , SUB
          , LOGAND
          , LOGOR
          , SRA
          )
  , Disp ( Disp )
  , Ind ( Ind )
  )
  where

import Prelude hiding (LT, EQ, GT)
import Data.Int

--------------------------------------------------------------------------------
-- Terminal Type Definitions ---------------------------------------------------

data UVar = UV String Int64 deriving (Read, Show, Eq)
data FVar = FV Int64        deriving (Read, Show, Eq)
data Label = L String Int64 deriving (Read, Show, Eq)

data Reg = RAX | RCX | RDX | RBX | RBP | RSI | RDI | R8 | R9
         | R10 | R11 | R12 | R13 | R14 | R15
         deriving (Read,Show,Eq,Ord)

data Relop = LT | LTE | EQ | GT | GTE               deriving (Read,Show,Eq,Ord)
data Binop = MUL | ADD | SUB | LOGAND | LOGOR | SRA deriving (Read,Show,Eq,Ord)

data Disp = Disp Reg Int64
data Ind = Ind Reg Reg
