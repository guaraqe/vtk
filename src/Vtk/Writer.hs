{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module Vtk.Writer
  ( writeVtk
  ) where

import Vtk.Types

import qualified Data.ByteString.Builder as BB
import qualified Data.ByteString.Lazy as BL

import qualified Data.Vector.Storable as V
import qualified Data.Vector.Storable.ByteString as V

import Data.Monoid

writeVtk :: Vtk V.Vector -> BL.ByteString
writeVtk = BB.toLazyByteString . vtkBuilder

vtkBuilder :: Vtk V.Vector -> BB.Builder
vtkBuilder (Vtk (v1,v2) title vtktype vtkdata) =
  foldMap
    BB.stringUtf8
    [ "# vtk DataFile Version ", show v1, ".", show v2, "\n"
    , "# ", title, "\n"
    , case vtktype of
        VtkAscii -> "ASCII\n"
        VtkBinary -> "BINARY\n"
    ] <> vtkDataBuilder vtkdata

vtkDataBuilder :: VtkData V.Vector -> BB.Builder
vtkDataBuilder (VtkStructuredPoints sp) = spBuilder sp

spBuilder :: StructuredPoints V.Vector -> BB.Builder
spBuilder (StructuredPoints (V3 d1 d2 d3) (V3 o1 o2 o3) (V3 s1 s2 s3) vtkval) =
  foldMap
    BB.stringUtf8
    [ "DATASET STRUCTURED_POINTS\n"
    , "DIMENSIONS ", show d1, " ", show d2, " ", show d3, "\n"
    , "ORIGIN ", show o1, " ", show o2, " ", show o3, "\n"
    , "SPACING ", show s1, " ", show s2, " ", show s3, "\n"
    , "POINT_DATA ", show (d1 * d2 * d3), "\n"
    , "COLOR_SCALARS scalars 1\n"
    ] <> valBuilder vtkval

valBuilder :: VtkVal V.Vector -> BB.Builder
valBuilder = \case
  VtkWord v -> BB.byteString (V.vectorToByteString v)
  VtkDouble v -> BB.byteString (V.vectorToByteString v)
