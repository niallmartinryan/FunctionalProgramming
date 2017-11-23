module Paths_lab03 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\niall\\Documents\\A college\\ThirdYear\\Haskell\\Labs\\CS3016-1617\\Lab03\\.stack-work\\install\\759c24ec\\bin"
libdir     = "C:\\Users\\niall\\Documents\\A college\\ThirdYear\\Haskell\\Labs\\CS3016-1617\\Lab03\\.stack-work\\install\\759c24ec\\lib\\i386-windows-ghc-7.10.3\\lab03-0.1.0.0-F3NObFmQb99D3m0fDO6jjR"
datadir    = "C:\\Users\\niall\\Documents\\A college\\ThirdYear\\Haskell\\Labs\\CS3016-1617\\Lab03\\.stack-work\\install\\759c24ec\\share\\i386-windows-ghc-7.10.3\\lab03-0.1.0.0"
libexecdir = "C:\\Users\\niall\\Documents\\A college\\ThirdYear\\Haskell\\Labs\\CS3016-1617\\Lab03\\.stack-work\\install\\759c24ec\\libexec"
sysconfdir = "C:\\Users\\niall\\Documents\\A college\\ThirdYear\\Haskell\\Labs\\CS3016-1617\\Lab03\\.stack-work\\install\\759c24ec\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "lab03_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "lab03_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "lab03_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "lab03_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "lab03_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
