{-# LANGUAGE OverloadedStrings #-}

module Vtk.Parser.StructuredPoints
  ( structuredPoints
  ) where

import Vtk.Parser.Common
import Vtk.Types.Common
import Vtk.Types.StructuredPoints

import Data.Attoparsec.ByteString
import qualified Data.Attoparsec.ByteString.Char8 as Char

import Text.ParserCombinators.Perm

import qualified Data.Vector.Storable as V

structuredPoints :: Parser (StructuredPoints V.Vector)
structuredPoints = do

  (dim,spa,ori) <- permute $
     (,,) <$$>
       ("DIMENSIONS " *> v3 Char.decimal) <||>
       ("SPACING " *> v3 Char.double) <||>
       ("ORIGIN " *> v3 Char.double)

  n <- do
    _ <- string "POINT_DATA "
    d <- Char.decimal
    Char.endOfLine
    return d

  arr <- parseVal n

  return $ StructuredPoints dim ori spa arr

--------------------------------------------------------------------------------

parseVal :: Int -> Parser (VtkVal V.Vector)
parseVal n = do
  _ <- "COLOR_SCALARS "
  name <- Char.takeWhile (/= ' ')
  _ <- " "
  _ <- readInt <$> toEOL
  case name of
    "scalars" -> VtkWord <$> vector n
    "double" -> VtkDouble <$> vector n
    _ -> fail "parseVal failed"

readInt :: String -> Int
readInt = read
