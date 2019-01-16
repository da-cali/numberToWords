# number-to-words

A simple tool for converting numbers to words. It is based on the Conway-Wechsler naming system, and it uses Haskell infinite lists to generate names of powers of 10 beyond 10^3002.

Examples of the main function:
```bash
toWords 0
"zero"
toWords 12345
"twelve thousand, three hundred forty-five"
toWords (10^3003)
"one millinillion"
```

### Installation:

0. Install curl or wget.
    ```
    sudo apt install curl
    ```
    or:
    ```
    sudo apt install wget
    ```
1. Install [stack](https://docs.haskellstack.org/en/stable/README/):
    ```
    curl -sSL https://get.haskellstack.org/ | sh
    ```
    or:
    ```
    wget -qO- https://get.haskellstack.org/ | sh
    ```
2. Clone repository:
    ```
    git clone https://github.com/da-cali/number-to-words
    ```
3. Open folder:
    ```
    cd number-to-words
    ```
4. Build project:
    ```
    stack build
    ```
5. Compile:
    ```
    stack ghc -- app/Main.hs -o number-to-words
    ```
6. Make it executable:
    ```
    chmod +x number-to-words
    ```
7. Run it:
    ```
    ./number-to-words
    ```