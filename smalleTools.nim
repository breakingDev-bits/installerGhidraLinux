import std/[osproc, os, strutils]

template nullPath*: string = ""

proc findVersionFolder*(installDir: string): string =
  for kind, path in walkDir(installDir):
    if kind == pcDir and path.startsWith("ghidra_"):
      return path
  return nullPath

proc errorInstaller*(): void =
    ## Only for two moments. Because Nim not have goto
    echo "Installation failed during download"

proc checkJava*(): bool =
    let javaVersion = execProcess("java -version")
    return javaVersion.len() > 0 

proc checkUpdates*(installDir: string): bool = 
    if findVersionFolder(installDir) == nullPath:
        echo "Version not found. We can install."
        return true
    else:
        echo "Version found. Delete folder ~/.ghidra"
        return false
