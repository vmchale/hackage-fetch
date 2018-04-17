module Main (main) where

import           Control.Concurrent.ParallelIO.Global
import           System.Process                       (callProcess)

strip :: String -> String
strip = init . tail

content :: IO [String]
content = fmap strip . words <$> readFile "all.txt"

unpack :: [String] -> IO ()
unpack = parallel_ . fmap g
    where g = callProcess "cabal" . (["unpack", "-d", "hackage"] <>) . pure

main :: IO ()
main = do
    unpack =<< content
    stopGlobalPool
