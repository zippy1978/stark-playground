/**
 * Main entry for CLI.
 */
extern exit(code: int)

import str
import fs

func handleFileError(fr: fs.FileResult) {
    if (fr.error != null) {
        println(fr.error)
        exit(1)
    }
}

func printUsage() {
    println("Usage: projectgen <projectname>")
}

func main(args: string[]): int {
    
    if (args.len < 2) {
        println("Missing project name")
        printUsage()
        return 1
    }
    
    projectName := args[1]
    makefilePath := str.concatString(projectName, "/Makefile")
    sourcePath := str.concatString(projectName, "/src")
    mainPath := str.concatString(sourcePath, "/main.st")
    
    if (fs.fileExists(makefilePath)) {
        println("Project already generated")
        return 1
    }
    
    fr := fs.createDirectory(projectName)
    handleFileError(fr)
    
    fr = fs.writeFileWithContent(makefilePath, makefileTemplate())
    handleFileError(fr)
    
    fr = fs.createDirectory(sourcePath)
    handleFileError(fr)
    
    fr = fs.writeFileWithContent(mainPath, mainStTemplate())
    handleFileError(fr)
    
    return 0
}