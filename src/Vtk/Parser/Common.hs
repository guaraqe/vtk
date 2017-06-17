{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Vtk.Parser.Common
  ( toEOL
  , vector
  , v3
  ) where

import Linear.V3

import Data.Attoparsec.ByteString
import qualified Data.Attoparsec.ByteString.Char8 as Char

import qualified Data.ByteString.Char8 as BSChar

import qualified Data.Vector.Storable as V
import qualified Data.Vector.Storable.ByteString as V

import Foreign.Storable

--------------------------------------------------------------------------------

toEOL :: Parser String
toEOL = do
  s <- BSChar.unpack <$> Char.takeWhile (/= '\n')
  Char.endOfLine
  return s

vector :: forall a . Storable a => Int -> Parser (V.Vector a)
vector n =
  let
    s = n * sizeOf (undefined :: a)
  in
    V.byteStringToVector <$> Char.take s

v3 :: Parser a -> Parser (V3 a)
v3 p = do
  d1 <- p <* " "
  d2 <- p <* " "
  d3 <- p
  Char.endOfLine
  return (V3 d1 d2 d3)
