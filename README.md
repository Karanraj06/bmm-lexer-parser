# bmm-lexer-parser

## Summary

This project aims to build a compiler for a simple programming language called B--. It utilizes Flex and Bison to create a lexical analyzer and syntax analyzer capable of recognizing B-- source code. The compiler provides helpful error messages for identifying syntax errors in B-- sample code.

## File Structure

```
.
├── .gitattributes
├── .gitignore
├── LICENSE
├── Makefile
├── README.md
├── bmm_main.c
├── bmm_parser.y
├── bmm_scanner.l
├── correct_sample.bmm
├── incorrect_sample.bmm
└── test_lexer.txt
```

## Prerequisites

Download

- [Bison](https://www.gnu.org/software/bison/)
- [Flex](https://github.com/westes/flex)
- [Make](https://www.gnu.org/software/software.html)

## Usage

Build the lexer and parser

```
make
```

Run the lexer and parser on a sample B-- program

```
./a.out correct_sample.bmm
```

Clean the directory

```
make clean
```

## Authors

- Harsh Raj Srivastava ([@Harsh290803](https://github.com/Harsh290803))
- Karanraj Mehta ([@Karanraj06](https://github.com/Karanraj06))