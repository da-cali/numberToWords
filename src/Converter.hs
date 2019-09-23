module Converter

( nameOf
) where

import Data.List

-- Converter
nameOf :: Integer -> String
nameOf 0 = "zero"
nameOf 1 = "one"
nameOf 2 = "two"
nameOf 3 = "three"
nameOf 4 = "four"
nameOf 5 = "five"
nameOf 6 = "six"
nameOf 7 = "seven"
nameOf 8 = "eight"
nameOf 9 = "nine"
nameOf 10 = "ten"
nameOf 11 = "eleven"
nameOf 12 = "twelve"
nameOf 13 = "thirteen"
nameOf 14 = "fourteen"
nameOf 15 = "fifteen"
nameOf 16 = "sixteen"
nameOf 17 = "seventeen"
nameOf 18 = "eighteen"
nameOf 19 = "nineteen"
nameOf 20 = "twenty"
nameOf 30 = "thirty"
nameOf 40 = "forty"
nameOf 50 = "fifty"
nameOf 60 = "sixty"
nameOf 70 = "seventy"
nameOf 80 = "eighty"
nameOf 90 = "ninety"
nameOf n | n < 0 = "minus " ++ nameOf (-n)
         | n < 100 = nameOf (n - n`mod`10) ++ '-' : nameOf (n`mod`10)
         | n < 1000 = nameOf (n`div`100) 
                      ++ " hundred" 
                      ++ if n`mod`100 == 0 then "" else " " 
                      ++ nameOf (n`mod`100)
         | otherwise = getNameFrom (zip [3,6..] bigNumbers) where
             getNameFrom ((power,name):restOfNames)
               | n >= 10^(power+3) = getNameFrom restOfNames
               | otherwise = nameOf (n`div`10^power)
                             ++ ' ' : name 
                             ++ if n`mod`10^power == 0 then "" else ", "
                             ++ nameOf (n`mod`10^power)

-- Names of powers of 10 that are multiples of 3 (thousand, million, billion..)
bigNumbers :: [String]
bigNumbers = "thousand" : map (++ "illion") (from1to999 ++ from1000toInf) where
  from1to999 = let
    us = ["m","b","tr","quadr","quint","sext","sept","oct","non"]
    ts = foldl' (\ acc x -> acc ++ x : map (addInfix x) uPfxs) [] tPfxs
    hs = foldl' (\ acc x -> acc ++ x : map (addInfix x) uPfxsAndtPfxs) [] hPfxs
    addInfix sx px = px ++ ix ++ sx where
      ix | sx `elem` sExceps && px == "se" = "s"
         | sx `elem` xExceps && px == "se" = "x"
         | sx `elem` mExceps && px `elem` ["septe","nove"] = "m"
         | sx `elem` nExceps && px `elem` ["septe","nove"] = "n"
         | sx `elem` (sExceps ++ xExceps) && px == "tre" = "s"
         | otherwise = ""
    uPfxsAndtPfxs = uPfxs ++ map addVowel ts where
      addVowel w = w ++ if any (`isInfixOf` w) (drop 2 tPfxs) then "a" else "i"
    in us ++ ts ++ hs
  from1000toInf = let
    bigPfxs n = foldl' (\ acc x -> acc ++ map (x++) ("n" : from1to999)) [] bigs
      where bigs = map (++ (concat $ replicate n "ill") ++ "i") from1to999
    in concatMap bigPfxs [1..]

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
