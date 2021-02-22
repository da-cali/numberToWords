import Converter

main :: IO ()
main = do
    mapM_ print [ nameOf 0 == "zero"
                , nameOf (-99) == "minus ninety-nine"
                , nameOf 12345 == "twelve thousand, three hundred forty-five"
                , nameOf 200000 == "two hundred thousand"
                , nameOf (10^165) == "one quattuorquinquagintillion"
                , nameOf (10^1002) == "one trestrigintatrecentillion"
                , nameOf (10^3000) == "one novenonagintanongentillion"
                , nameOf (10^3003) == "one millinillion"
                , nameOf (10^3705) == "one milliquattuortrigintaducentillion"
                , nameOf (10^19683) == "one sextillisexagintaquingentillion"
                , nameOf (10^59052) == "one novendecillitresoctogintasescentillion"
                ]