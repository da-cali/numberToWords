module Converter

( toWords
, bigNumbers
) where
        
import Data.List

-- Converter
toWords :: Integer -> String
toWords 0 = "zero"
toWords 1 = "one"
toWords 2 = "two"
toWords 3 = "three"
toWords 4 = "four"
toWords 5 = "five"
toWords 6 = "six"
toWords 7 = "seven"
toWords 8 = "eight"
toWords 9 = "nine"
toWords 10 = "ten"
toWords 11 = "eleven"
toWords 12 = "twelve"
toWords 13 = "thirteen"
toWords 14 = "fourteen"
toWords 15 = "fifteen"
toWords 16 = "sixteen"
toWords 17 = "seventeen"
toWords 18 = "eighteen"
toWords 19 = "nineteen"
toWords 20 = "twenty"
toWords 30 = "thirty"
toWords 40 = "forty"
toWords 50 = "fifty"
toWords 60 = "sixty"
toWords 70 = "seventy"
toWords 80 = "eighty"
toWords 90 = "ninety"
toWords n = composer bigNumbers 3 where
  composer (x:xs) p
    | n < 0 = "minus " ++ toWords (-n)
    | n < 100 = toWords (n - n `mod` 10) ++ "-" ++ toWords (n `mod` 10)
    | n < 1000 = toWords (n `div` 100) ++ " hundred" ++
                 if n `mod` 100 == 0 then "" else " " ++ 
                 toWords (n `mod` 100)
    | n < 10^(p+3) = toWords (n `div` 10^p) ++ " " ++ x ++
                     if n `mod` 10^p == 0 then "" else ", " ++ 
                     toWords (n `mod` 10^p)
    | otherwise = composer xs (p+3)

-- Names of large numbers
bigNumbers :: [String]
bigNumbers = "thousand" : map (++ "illion") (from1to999 ++ from1000toInf) where
  from1to999 = us ++ ts ++ hs
  us = ["m","b","tr","quadr","quint","sext","sept","oct","non"]
  ts = foldl (\acc x -> acc ++ x : map (combine x) uPfxs) [] tPfxs
  hs = foldl (\acc x -> acc ++ x : map (combine x) uPlusTpfxs) [] hPfxs
  uPlusTpfxs = let addVow w = w ++ if any (`isInfixOf` w) (drop 2 tPfxs) then "a" else "i"
               in uPfxs ++ map addVow ts
  combine sx px = let ix | elem sx sExceps && px == "se" = "s"
                         | elem sx xExceps && px == "se" = "x"
                         | elem sx mExceps && elem px ["septe","nove"] = "m"
                         | elem sx nExceps && elem px ["septe","nove"] = "n"
                         | elem sx (sExceps ++ xExceps) && px == "tre" = "s"
                         | otherwise = ""
                  in px ++ ix ++ sx
  from1000toInf = concat $ map (generateLists "ill") [1..]
  generateLists ix n = foldl (\acc x -> acc ++ x : map (x ++) from1to999) []
                             (map (++ (concat $ replicate n ix)) from1to999)

-- Units' prefixes
uPfxs :: [String]
uPfxs = ["un"
        ,"duo"
        ,"tre"
        ,"quattuor"
        ,"quin"
        ,"se"
        ,"septe"
        ,"octo"
        ,"nove"]

-- Tenths' prefixes
tPfxs :: [String]
tPfxs = ["dec"
        ,"vigint"
        ,"trigint"
        ,"quadragint"
        ,"quinquagint"
        ,"sexagint"
        ,"septuagint"
        ,"octogint"
        ,"nonagint"]

-- Hundreds'prefixes
hPfxs :: [String]
hPfxs = ["cent"
        ,"ducent"
        ,"trecent"
        ,"quadringent"
        ,"quingent"
        ,"sescent"
        ,"septingent"
        ,"octingent"
        ,"nongent"]
 
-- Exceptions for "s"
sExceps :: [String]
sExceps = ["vigint"
          ,"trigint"
          ,"quadragint"
          ,"quinquagint"
          ,"trecent"
          ,"quadringent"
          ,"quingent"]

-- Exceptions for "x"
xExceps :: [String]
xExceps = ["octogint"
          ,"cent"
          ,"octingent"]

-- Exceptions for "m"
mExceps :: [String]
mExceps = ["vigint"
          ,"octogint"
          ,"octingent"]
          
-- Exceptions for "n"
nExceps :: [String]
nExceps = filter (`notElem` "nonagint" : "nongent" : mExceps) (tPfxs ++ hPfxs)