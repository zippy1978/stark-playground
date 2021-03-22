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

func main(args: string[]): int {

    if (fileExists("test/Makefile")) {
        println("Project already generated")
    } else {
        fr := createDirectory("test")
        handleFileError(fr)

        fr = writeFileWithContent("test/Makefile", makefileTemplate())
        handleFileError(fr)
        
        fr = createDirectory("test/src")
        handleFileError(fr)
        
        fr = writeFileWithContent("test/src/main.st", mainStTemplate())
        handleFileError(fr)
    }
    return 0
}