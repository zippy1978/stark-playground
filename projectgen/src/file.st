/**
 * File manipulation utility functions.
 */
extern fopen(filename: any, accessMode: any): any
extern fputs(content: any, file: any): int
extern fclose(file: any): int
extern fgets(buffer: any, maxLength: int, file: any): any
extern mkdir(path: any, mode: int): int
extern access(path: any, mode: int): int

struct File {
    descriptor: any,
    name: string
}

struct FileResult {
    value: File,
    error: string
}


func openFile(name: string, accessMode: string): FileResult {
    fd := fopen(toCString(name), toCString(accessMode))
    error: string = null
    value: File = null
    if (fd == null) {
        error = "cannot open file"
    }
    else {
        value = File(fd, name)
    }
    return FileResult(value, error)
}

func writeToFile(file: File, content: string): FileResult {
    error: string = null
    if (file.descriptor == null) {
        error = "file is not opened"
    } else {
        fputs(toCString(content), file.descriptor)
    }
    return FileResult(file, error)
}

func closeFile(file: File): FileResult {
    error: string = null
    if (file.descriptor == null) {
        error = "file is not opened"
    } else {
        closeRes := fclose(file.descriptor)
        if (closeRes != 0) {
            error = "cannot close file"
        } else {
            file.descriptor = null
        }
    }
    return FileResult(file, error)
}

func createDirectory(path: string): FileResult  {
    error: string = null
    if (mkdir(toCString(path), 99999999999999999999) != 0) {
        error = "Directory creation failed"
    }
    return FileResult(null, error)
}

func fileExists(filename: string): bool {
    return access(toCString(filename), 0) == 0
}

func writeFileWithContent(filename: string, content: string): FileResult {
    
    fr := openFile(filename, "w")
    if (fr.error != null) {
        return FileResult(null, fr.error)
    }
    
    fr = writeToFile(fr.value, content)
    if (fr.error != null) {
        return FileResult(null, fr.error)
    }

    fr = closeFile(fr.value)
    if (fr.error != null) {
        return FileResult(null, fr.error)
    }

    return FileResult(null, null)
}