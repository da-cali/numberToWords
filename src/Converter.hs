module Converter where

import Data.List

-- Returns the name of the input integer.
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
         | n < 1000 = nameOf (n`div`100) ++ " hundred" ++ nameOfRemainder
         | otherwise = getNameFrom labeledPowers 
         where nameOfRemainder = if n`mod`100 == 0 then "" else ' ' : nameOf (n`mod`100)
               labeledPowers = zip bigNumbers [3,6..]
               getNameFrom ((l,p):rest) = if n >= 10^(p+3) 
                                              then getNameFrom rest
                                              else nameOf (n`div`10^p) 
                                                ++ ' ' : l
                                                ++ if n`mod`10^p == 0 then "" else ", "
                                                ++ nameOf (n`mod`10^p)
                            
-- Names of powers of 10 that are multiples of 3 (thousand, million, billion..)
bigNumbers :: [String]
bigNumbers = "thousand" : fmap (++ "illion") (from1to999 ++ from1000toInf) where
    -- First 999 prefixes (from "m" to "novenonagintanongent").
    from1to999 =
        let -- Units', tenths', and hundreds' prefixes.
            uPfxs = ["un","duo","tre","quattuor","quin","se","septe","octo","nove"]
            tPfxs = ["dec","vigint","trigint","quadragint","quinquagint"
                    ,"sexagint","septuagint","octogint","nonagint"]
            hPfxs = ["cent","ducent","trecent","quadringent","quingent"
                    ,"sescent","septingent","octingent","nongent"]
            -- Exceptions for "s", "x", "m", and "n".
            xExceps = ["octogint","cent","octingent"]
            mExceps = ["vigint","octogint","octingent"]
            sExceps = ["vigint","trigint","quadragint","quinquagint"
                      ,"trecent","quadringent","quingent"]
            nExceps = filter (`notElem` "nonagint":"nongent":mExceps) (tPfxs ++ hPfxs)
            -- Helper functions.
            addVowel w = w ++ if any (`isInfixOf` w) (drop 2 tPfxs) then "a" else "i"
            addInfix sx px = px ++ ix ++ sx
                where ix | px`elem`["septe","nove"] && sx`elem`nExceps = "n"
                         | px`elem`["septe","nove"] && sx`elem`mExceps = "m"
                         | px == "tre" && sx`elem`(sExceps ++ xExceps) = "s"
                         | px == "se" && sx`elem`sExceps = "s"
                         | px == "se" && sx`elem`xExceps = "x"
                         | otherwise = ""
            -- Combined prefixes.
            us = ["m","b","tr","quadr","quint","sext","sept","oct","non"]
            ts = concatMap (\ x -> x : fmap (addInfix x) uPfxs) tPfxs
            hs = concatMap (\ x -> x : fmap (addInfix x) (uPfxs ++ fmap addVowel ts)) hPfxs
        in us ++ ts ++ hs
    -- Rest of the prefixes (from "millin" to infinity).
    from1000toInf =
        let bigPfxs n = foldl' (\ acc x -> acc ++ fmap (x++) ("n" : from1to999)) [] bigs
                where bigs = fmap (++ (concat $ replicate n "ill") ++ "i") from1to999
        in concatMap bigPfxs [1..]