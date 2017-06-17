module Vtk
  ( vtkParser
  , module Types
  , vtkTest
  ) where

import Vtk.Parser
import Vtk.Types as Types

import Data.Word
import Data.Attoparsec.ByteString
import qualified Data.ByteString as BS
import qualified Data.Vector.Storable as V

import Control.Lens

--------------------------------------------------------------------------------

vtkTest :: FilePath -> IO (V.Vector Word8)
vtkTest path = do
  file <- BS.readFile path
  case eitherResult $ parse vtkParser file of
     Left e -> fail e
     Right r ->
       case getWord r of
         Nothing -> fail "Not word!"
         Just v -> return v

getWord :: Vtk f -> Maybe (f Word8)
getWord vtk =
  vtk ^? vtk_data . vtkStructuredPoints . sp_points . vtkWord
