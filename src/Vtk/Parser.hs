{-# LANGUAGE OverloadedStrings #-}

module Vtk.Parser
  ( vtkParser
  ) where

import Vtk.Types

import Vtk.Parser.Common
import Vtk.Parser.StructuredPoints

import Data.Attoparsec.ByteString
import qualified Data.Attoparsec.ByteString.Char8 as Char

import qualified Data.Vector.Storable as V

--------------------------------------------------------------------------------

vtkVersion :: Parser (Int,Int)
vtkVersion = do
  _ <- string "# vtk DataFile Version "
  n1 <- Char.decimal
  _ <- string "."
  n2 <- Char.decimal
  Char.endOfLine
  return (n1,n2)

vtkTitle :: Parser String
vtkTitle = do
  _ <- string "# "
  s <- toEOL
  return s

vtkType :: Parser VtkType
vtkType = do
  s <- toEOL
  case s of
    "ASCII" -> return VtkAscii
    "BINARY" -> return VtkBinary
    _ -> fail "VtkType parser failed"

vtkData :: Parser (VtkData V.Vector)
vtkData = do
  _ <- string "DATASET "
  s <- toEOL
  case s of
    "STRUCTURED_POINTS" -> VtkStructuredPoints <$> structuredPoints
    _ -> fail "non supported type"

vtkParser :: Parser (Vtk V.Vector)
vtkParser =
  Vtk <$>
    vtkVersion <*>
    vtkTitle <*>
    vtkType <*>
    vtkData
