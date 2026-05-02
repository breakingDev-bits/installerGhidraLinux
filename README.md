# Ghidra installer on NIM.
![Built with Nim](https://img.shields.io/badge/Built%20with-Nim-yellow)

This project help install ghidra on Linux with `$HOME`.

## Technical part
1. Makefile for maximum optimization. Only enter `make` in your shell and start the program in binary.

2. puppy, maybe you know `request` in python, it's a similar tool. Wonderful tool for small installer

3. Zippy wonderful speed in extract power. 

4. checkJava, checkVersion and alias. This tool only install&update, not install JDK or more. 

## Why i do it? 

Only because of interest, I wanted a tool with no runtime dependencies (like Python or JVM). And `Nim` it's `easy C`. I believe Nim will become a better language, but and now it language is wonderful for me.

---
# How work

```bash
user@user:~/Documents/... $ ./binary/ghidra-installer
--- Install Ghidra for Linux ---
Version found: /home/user/.ghidra/ghidra_12.0.4_PUBLIC
Delete older version? (Y/n): Y
Deleted: /home/user/.ghidra
Download version: ghidra_12.0.4_PUBLIC_20260303.zip
Starting download... Please wait (this may take a while)
Writing to disk...
Extracting...
Successfully extracted to /home/user/.ghidra
Add alias manually. Example: alias ghidra='/home/user/.ghidra/ghidra_12.0.4_PUBLIC/ghidraRun'
```
---
# Requirements
Makefile, Nim>2.0, puppy and zippy

---
# Quick start

create with source code(Check Requirements)
```bash
make buildForMe
./binary/ghidra-installer
```

or

```bash
## One-line install (Linux, Binary)
curl -s [https://api.github.com/repos/breakingDev-bits/installerGhidraLinux/releases/latest](https://api.github.com/repos/breakingDev-bits/installerGhidraLinux/releases/latest) | grep "browser_download_url" | cut -d '"' -f 4 | xargs curl -L -o ghidra-installer && chmod +x ghidra-installer && ./ghidra-installer
```

and that's all:3
