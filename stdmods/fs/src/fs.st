/**
 * File manipulation utility functions.
 */
module fs

extern fopen(filename: any, accessMode: any): any
extern fputs(content: any, file: any): int
extern fclose(file: any): int
extern feof(file: any): int
extern fgets(buffer: any, maxLength: int, file: any): any
extern mkdir(path: any, mode: int): int
extern access(path: any, mode: int): int
extern remove(filename: any): int

/**
 * File struct.
 */
struct File {
    descriptor: any,
    name: string
}

/**
 * File result.
 */
struct FileResult {
    value: File,
    error: string
}

/**
 * Open file with the given access mode.
 */
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

/**
 * Write a string to a File.
 */
func writeToFile(file: File, content: string): FileResult {
    error: string = null
    if (file.descriptor == null) {
        error = "file is not opened"
    } else {
        fputs(toCString(content), file.descriptor)
    }
    return FileResult(file, error)
}

/**
 * Close an opened File.
 */
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

func deleteFile(filename: string): bool {
    return remove(toCString(filename))
}

/**
 * Create directory.
 */
func createDirectory(path: string): FileResult {
    error: string = null
    if (mkdir(toCString(path), 99999999999999999999) != 0) {
        error = "Directory creation failed"
    }
    return FileResult(null, error)
}

/**
 * Test if file exists.
 */
func fileExists(filename: string): bool {
    return access(toCString(filename), 0) == 0
}

/**
 * Test if file is at the end (EOF).
 */
func fileIsEOF(file: File): bool {
    return feof(file.descriptor) != 0
}

/**
 * Write string to a file name.
 */
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