{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_vtk_simple (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/juan/.cabal/bin"
libdir     = "/home/juan/.cabal/lib/x86_64-linux-ghc-8.0.1/vtk-simple-0.1.0-AYu70enFLkrEjquGXcdtwC"
datadir    = "/home/juan/.cabal/share/x86_64-linux-ghc-8.0.1/vtk-simple-0.1.0"
libexecdir = "/home/juan/.cabal/libexec"
sysconfdir = "/home/juan/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "vtk_simple_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "vtk_simple_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "vtk_simple_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "vtk_simple_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "vtk_simple_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
