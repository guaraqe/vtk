module Vtk
  ( withVtkFile
  , parseVtk
  , writeVtk
  , module Types
  ) where

import Vtk.Parser
import Vtk.Writer
import Vtk.Types as Types

import Data.Attoparsec.ByteString
import qualified Data.ByteString as BS
import qualified Data.Vector.Storable as V

import System.IO

--------------------------------------------------------------------------------

withVtkFile :: FilePath -> (Vtk V.Vector -> b) -> IO b
withVtkFile path f =
  withFile path ReadMode $ \handle -> do
    file <- BS.hGetContents handle
    case parseVtk file of
      Nothing -> fail "Error parsing file"
      Just a -> return (f a)

parseVtk :: BS.ByteString -> Maybe (Vtk V.Vector)
parseVtk = maybeResult . parse vtkParser
