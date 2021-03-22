/**
 * Main entry for CLI.
 */
extern exit(code: int)

func handleFileError(fr: FileResult) {
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
    makefilePath := concatString(projectName, "/Makefile")
    sourcePath := concatString(projectName, "/src")
    mainPath := concatString(sourcePath, "/main.st")
    
    if (fileExists(makefilePath)) {
        println("Project already generated")
        return 1
    }

    fr := createDirectory(projectName)
    handleFileError(fr)
    
    fr = writeFileWithContent(makefilePath, makefileTemplate())
    handleFileError(fr)
    
    fr = createDirectory(sourcePath)
    handleFileError(fr)
    
    fr = writeFileWithContent(mainPath, mainStTemplate())
    handleFileError(fr)
    
    return 0
}