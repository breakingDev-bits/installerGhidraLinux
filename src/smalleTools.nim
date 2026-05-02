import std/[rdstdin, os, strutils]

template nullPath*: string = ""

proc findVersionFolder*(installDir: string): string =
    if not dirExists(installDir): return nullPath

    # walkDir возвращает полный путь. Нам нужно проверять только имя папки в конце пути.
    for kind, path in walkDir(installDir):
        let folderName = path.lastPathPart
        if kind == pcDir and folderName.startsWith("ghidra_"):
            return path
    return nullPath

proc errorInstaller*() =
    echo "Installation failed during download"

proc checkJava*(): bool =
    return findExe("java") != ""

proc deletePreviousFolder(deletePath: string = getHomeDir() / ".ghidra") = 
    try:
        if deletePath != "" and dirExists(deletePath):
            removeDir(deletePath)
            echo "Deleted: ", deletePath
    except CatchableError as e:
        echo "Problem with delete folder.\nError: ", e.msg

proc checkUpdates*(installDir: string): bool = 
    let versionFolder = findVersionFolder(installDir)
    
    if versionFolder == nullPath:
        echo "Version not found. Ready to install."
        return false
    else:
        echo "Version found: ", versionFolder
        let okDelete = readLineFromStdin("Delete older version? (Y/n): ").toLowerAscii().strip()

        if okDelete in ["y", "yes", "ye", "yeah"]:
            let deletePath = getHomeDir() / ".ghidra"
            deletePreviousFolder(deletePath)
            return false
        else:
            echo "Installion was killed"
            return true