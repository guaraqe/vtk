{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE LambdaCase #-}

module Vtk.Types.Common
  ( VtkVal (..)
  , vtkDouble
  , vtkWord
  ) where

import Data.Word
import Control.Lens

--------------------------------------------------------------------------------

data VtkVal f =
  VtkDouble (f Double) |
  VtkWord (f Word8)

$(makePrisms ''VtkVal)

instance Show (VtkVal f) where
  show (VtkDouble _) = "VtkDouble"
  show (VtkWord _) = "VtkWord"

vtkDouble :: Prism' (VtkVal f) (f Double)
vtkDouble = prism' VtkDouble $ \case
  VtkDouble x -> Just x
  _ -> Nothing

vtkWord :: Prism' (VtkVal f) (f Word8)
vtkWord = prism' VtkWord $ \case
  VtkWord x -> Just x
  _ -> Nothing
