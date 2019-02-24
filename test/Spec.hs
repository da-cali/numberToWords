import Converter

main :: IO ()
main = do
    print(toWords 0 == "zero")
    print(toWords (-99) == "minus ninety-nine")
    print(toWords 12345 == "twelve thousand, three hundred forty-five")
    print(toWords (10^165) == "one quattuorquinquagintillion")
    print(toWords (10^1002) == "one trestrigintatrecentillion")
    print(toWords (10^3000) == "one novenonagintanongentillion")
    print(toWords (10^3003) == "one millinillion")
    print(toWords (10^3705) == "one milliquattuortrigintaducentillion")
    print(toWords (10^19683) == "one sextillisexagintaquingentillion")
    print(toWords (10^59052) == "one novendecillitresoctogintasescentillion")
    
