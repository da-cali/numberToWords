import Converter

main :: IO ()
main = do
    print (nameOf 0 == "zero")
    print (nameOf (-99) == "minus ninety-nine")
    print (nameOf 12345 == "twelve thousand, three hundred forty-five")
    print (nameOf (10^165) == "one quattuorquinquagintillion")
    print (nameOf (10^1002) == "one trestrigintatrecentillion")
    print (nameOf (10^3000) == "one novenonagintanongentillion")
    print (nameOf (10^3003) == "one millinillion")
    print (nameOf (10^3705) == "one milliquattuortrigintaducentillion")
    print (nameOf (10^19683) == "one sextillisexagintaquingentillion")
    print (nameOf (10^59052) == "one novendecillitresoctogintasescentillion")
    
