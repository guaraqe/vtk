{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE StrictData #-}

module Vtk.Types.StructuredPoints
  ( StructuredPoints (..)
  , sp_dimensions
  , sp_origin
  , sp_spacing
  , sp_points
  ) where

import Vtk.Types.Common
import Linear.V3

import Control.Lens

data StructuredPoints f = StructuredPoints
  { _sp_dimensions :: V3 Int
  , _sp_origin :: V3 Double
  , _sp_spacing :: V3 Double
  , _sp_points :: VtkVal f
  } deriving Show

$(makeLenses ''StructuredPoints)
