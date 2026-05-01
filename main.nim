import puppy, std/[strutils, json, os]
import smalleTools
import zippy/ziparchives
import strformat

proc installArchive(): string = 
    let res = get(
        "https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest",
        headers = @[("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:138.0) Gecko/20100101 Firefox/138.0")])
    # Check API github
    if res.code == 200:
        let data = parseJson(res.body)

        var url = ""
        for asset in data["assets"]:
            let downloadUrl = asset["browser_download_url"].getStr()
            if downloadUrl.endsWith(".zip"):
                url = downloadUrl
                break
        # If url don't found - manually install
        if url == "":
            echo "Don't found release. Please install Ghidra from github"
            return ""
        # Show VERSIOn
        let nameArchive = url.split("/")[^1]
        echo "Download version: ", nameArchive
        # Set parametrs for req
        var req = Request()
        req.url = parseUrl(url)
        req.verb = "get"
        req.timeout = float32(1800)
        
        echo "Starting download... Please wait (this may take a while)"
        # InstallBlock for comfortable install 
        block InstallBlock:
            let dl = fetch(req)
            if dl.body.len == 0:
                echo "Download failed"
                return ""
            echo "Writing to disk..."
            writeFile(nameArchive, dl.body)

        return nameArchive

    else:
        echo "API Error: ", res.code
        return ""

proc dearchive(nameArchive: string, installDir: string = getHomeDir() / ".ghidra"): string = 
    if nameArchive == "" or not fileExists(nameArchive):
        echo "Nothing to extract"
        return ""

    echo "Extracting..."
    try:

        let installDir = getHomeDir() / ".ghidra"
        createDir(installDir)
        extractAll(nameArchive, installDir)
        echo "Successfully extracted to " & installDir
        removeFile(nameArchive)

        return installDir
    except CatchableError as e:
        echo "Extraction error: ", e.msg

        return ""

proc NimMainC(): void = 
    echo "--- Install Ghidra for Linux ---"
    let installDir = getHomeDir() / ".ghidra"

    if not checkJava():
        echo "Error: don't found JDK, please install JDK."
        quit(1)

    if checkUpdates(installDir):
        echo "Version found. Delete folder ~/.ghidra"
        quit(1)
    
    block mainLogic:
        let nameArchive = installArchive()
        if nameArchive == "": 
            break mainLogic

        let installDir = dearchive(nameArchive)
        if installDir == "": 
            break mainLogic

        let vFolder = findVersionFolder(installDir)
        if findVersionFolder(installDir) == "":
            echo fmt"Error: don't found installDir"
            break mainLogic

        let versionPath = fmt"'{getHomeDir()}/.ghidra/{vFolder}/ghidraRun'"
        echo fmt"Add alias manually. Example: alias ghidra={versionPath}"
        
        return 

    errorInstaller()

when isMainModule:
    NimMainC()
