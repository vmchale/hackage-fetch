module Main (main) where

import           Control.Concurrent.ParallelIO.Global
import           System.Process                       (callProcess)

strip :: String -> String
strip = init . tail

content :: IO [String]
content = filter (not . bad) . fmap strip . words <$> readFile "all.txt"

bad :: String -> Bool
bad "HLogger"            = True
bad "BirdPP"             = True
bad "bindings-gts"       = True
bad "WebBits-multiplate" = True
bad _                    = False

unpack :: [String] -> IO ()
unpack = parallel_ . fmap g
    where g = callProcess "cabal" . (["unpack", "-d", "hackage"] <>) . pure

main :: IO ()
main = do
    unpack =<< content
    stopGlobalPool
