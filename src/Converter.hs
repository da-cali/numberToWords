module Converter where

import Data.List

-- Returns the name of the input integer. The function uses the list bigNumbers
-- containing names of powers of 10 that are multiples of 3 (such as thousand,
-- million, billion, etc.)
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
nameOf n
    | n < 0 = "minus " ++ nameOf (-n)
    | n < 100 = nameOf (n - n`mod`10) ++ '-' : nameOf (n`mod`10)
    | n < 1000 = nameOf (n`div`100) ++ " hundred" ++ nameOfRemainder
    | otherwise = getNameFrom (zip bigNumbers [3,6..])
    where nameOfRemainder = if n`mod`100 == 0 then "" else ' ' : nameOf (n`mod`100)
          getNameFrom [] = ""
          getNameFrom ((l,p):rest) = 
              let nameParts = [ nameOf (n`div`10^p), ' ' : l, ending ] where
                      ending = if n`mod`10^p == 0 then "" else ", " ++ nameOf (n`mod`10^p)
              in if n >= 10^(p+3) then getNameFrom rest else concat nameParts
          bigNumbers = "thousand" : fmap (++ "illion") (from1to999 ++ from1000toInf) where
              from1to999 = 
                  let units = ["m", "b", "tr", "quadr", "quint", "sext", "sept", "oct", "non"]
                      tenths = concatMap (\ x -> x : fmap (addInfix x) uPrefixes) tPrefixes
                      hundreths = concatMap (\ x -> x : fmap (addInfix x) composedTenths) hPrefixes
                          where composedTenths = (uPrefixes ++ fmap addVowel tenths)
                  in units ++ tenths ++ hundreths where
                         uPrefixes = [ "un", "duo", "tre", "quattuor", "quin"
                                     , "se", "septe", "octo", "nove"]
                         tPrefixes = [ "dec", "vigint", "trigint", "quadragint", "quinquagint"
                                     , "sexagint", "septuagint", "octogint", "nonagint"]
                         hPrefixes = [ "cent", "ducent", "trecent", "quadringent", "quingent"
                                     , "sescent", "septingent", "octingent", "nongent"]
                         addVowel w = w ++ if any (`isInfixOf` w) (drop 2 tPrefixes) then "a" else "i"
                         addInfix sx px = 
                             let ix | px`elem`["septe", "nove"] && sx`elem`nExceptions = "n"
                                    | px`elem`["septe", "nove"] && sx`elem`mExceptions = "m"
                                    | px == "tre" && sx`elem`(sExceptions ++ xExceptions) = "s"
                                    | px == "se" && sx`elem`sExceptions = "s"
                                    | px == "se" && sx`elem`xExceptions = "x"
                                    | otherwise = ""
                                    where mExceptions = [ "vigint", "octogint", "octingent" ]
                                          nExceptions = 
                                              filter (`notElem` "nonagint" : "nongent" : mExceptions)
                                                     (tPrefixes ++ hPrefixes)
                                          sExceptions = [ "vigint", "trigint", "quadragint", "quinquagint"
                                                        , "trecent", "quadringent", "quingent" ]
                                          xExceptions = [ "octogint", "cent", "octingent" ]
                             in px ++ ix ++ sx
              from1000toInf = 
                  let bigPrefixes n = foldl' (\ acc x -> acc ++ fmap (x++) ("n" : from1to999)) [] bigs
                          where bigs = fmap (++ concat (replicate n "ill") ++ "i") from1to999
                  in concatMap bigPrefixes [1..]
