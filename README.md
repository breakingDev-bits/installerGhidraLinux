# Ghidra installer on NIM.
![Built with Nim](https://shields.io)

This project help install ghidra on Linux with `$HOME`.

## Technical part
1. Makefile for maximum optimization. Only enter `make` in your shell and start the program in binary.

2. puppy, maybe you know `request` in python, it's a similar tool. Wonderful tool for small installer

3. Zippy wonderful speed in extract power. 

4. checkJava, checkVersion and alias. This tool only install, not updater or more. 

## Why i do it? 

Only because of interest, I wanted a tool with no runtime dependencies (like Python or JVM). And `Nim` it's `easy C`. I believe Nim will become a better language, but and now it language is wonderful for me.

---
# Quick start

```bash
make
./binary/ghidra-installer
```

and that's all:3