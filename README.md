# number-to-words

A simple number-to-words converter based on the Conway-Wechsler naming system. It uses Haskell infinite lists to generate names of powers of 10 beyond 10^3002.

Examples of the main function:
```bash
ghci> toWords 0
"zero"
ghci> toWords 12345
"twelve thousand, three hundred forty-five"
ghci> toWords (10^3003)
"one millillion"
```
