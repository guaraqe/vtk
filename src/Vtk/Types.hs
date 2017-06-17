{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE LambdaCase #-}

module Vtk.Types
  ( --
    Vtk (..)
  , vtk_version
  , vtk_title
  , vtk_type
  , vtk_data
    --
  , VtkType (..)
    --
  , VtkData (..)
  , vtkStructuredPoints
  , module Types
  ) where

import Vtk.Types.Common as Types
import Vtk.Types.StructuredPoints as Types

import Control.Lens

--------------------------------------------------------------------------------

data VtkType = VtkAscii | VtkBinary
  deriving (Show, Eq)

--------------------------------------------------------------------------------

data VtkData f =
  VtkStructuredPoints (StructuredPoints f)
  deriving Show

vtkStructuredPoints ::
  Prism' (VtkData f) (StructuredPoints f)
vtkStructuredPoints = prism' VtkStructuredPoints $ \case
  VtkStructuredPoints sp -> Just sp
  --_ -> Nothing

--------------------------------------------------------------------------------

data Vtk f = Vtk
  { _vtk_version :: (Int,Int)
  , _vtk_title :: String
  , _vtk_type :: VtkType
  , _vtk_data :: VtkData f
  } deriving Show

$(makeLenses ''Vtk)
