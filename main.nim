import puppy, std/[strutils, json, os]
import zippy/ziparchives

proc installArchive(): string = 
    let res = get("https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest")
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

proc dearchive(nameArchive: string) = 
    if nameArchive == "" or not fileExists(nameArchive):
        echo "Nothing to extract"
        return

    echo "Extracting..."
    try:
        let installDir = getHomeDir() / ".ghidra"
        extractAll(nameArchive, installDir)
        echo "Successfully extracted to " & installDir
        removeFile(nameArchive)
    except CatchableError as e:
        echo "Extraction error: ", e.msg

proc NimMainC(): void = 
    # Main FUNC, exportc to C.
    echo "--- Install Ghidra for Linux ---"
    let nameArchive = installArchive()
    
    if nameArchive != "":
        dearchive(nameArchive)
    else:
        echo "Installation failed during download"

    echo "Add alias manually. Example: alias ghidra='$HOME/.ghidra/ghidraRun'"

when isMainModule:
    NimMainC()
