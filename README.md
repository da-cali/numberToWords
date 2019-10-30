# number-to-words

A simple tool for converting numbers to words. It is based on the Conway-Wechsler naming system, and it uses Haskell infinite lists to generate names of powers of 10 beyond 10^3002; so in theory it can generate the name of any integer in the real line.

Examples of the main function:
```bash
nameOf 0
"zero"
nameOf (-99)
"minus ninety-nine"
nameOf 12345
"twelve thousand, three hundred forty-five"
nameOf (10^3003)
"one millinillion"
nameOf (10^59052)
"one novendecillitresoctogintasescentillion"
```
### Usage:

Since it only requires the standard prelude, you can just copy the [source code](https://github.com/da-cali/numberToWords/blob/master/src/Converter.hs) and load it in GHCi, or

#### Run the app:

0. Install [stack](https://docs.haskellstack.org/en/stable/README/).

1. Clone repository:
    ```
    git clone https://github.com/da-cali/numberToWords
    ```
2. Open folder:
    ```
    cd numberToWords
    ```
3. Build project:
    ```
    stack build
    ```
4. Run:
    ```
    stack runhaskell app/Main.hs
    ```