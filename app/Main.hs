module Main where

import Converter
import Control.Monad

main :: IO ()
main = forever $ do
    putStrLn "Enter a number:"  
    number <- readLn
    putStrLn $ nameOf (number :: Integer)
