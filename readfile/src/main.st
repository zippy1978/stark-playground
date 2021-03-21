extern fopen(filename: any, accessMode: any): any
extern fprintf(file: any, format: any): int
extern fclose(file: any): int
extern fgets(buffer: any, maxLength: int, file: any): any

extern strtok(str: any, delim: any): any

extern time(t: any): any
extern difftime(end: any, begin: any): int
extern clock(): int

struct File {
    descriptor: any,
    name: string
}

struct FileResult {
    value: File,
    error: string
}

struct StringResult {
    value: string,
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
        fprintf(file.descriptor, toCString(content))
    }
    return FileResult(file, error)
}

func readFromFile(file: File): StringResult {
    cstr: any = toCString("01234567890123456789012345678901234567890123456789")
    error: string = null
    if (fgets(cstr, 50, file.descriptor) == null) {
        error = "cannot read file"
    }
    return StringResult(fromCString(cstr), error)
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

func main(): int {

    startTime := clock()
    
    res := 0

    // Write to file
    f := openFile("test", "w")
    if (f.error != null) {
        println(f.error)
        res = 1
    } else {
        println("file opened !")
        f = writeToFile(f.value, "hello,this,is,stark")
        if (f.error != null) {
            println(f.error)
            res = 2
        } else {
            println("wrote to file")
            f = closeFile(f.value)
            if (f.error != null) {
                println(f.error)
                res = 3
            }
        }
    }

    // Read from file
    fileContent: string = null
    f = openFile("test", "r")
    if (f.error != null) {
        println(f.error)
        res = 4
    } else {
        println("file opened !")
        s := readFromFile(f.value)
        if (s.error != null) {
            println(s.error)
            res = 5
        } else {
            print("read from file: ")
            fileContent = s.value
            println(fileContent)
            f = closeFile(f.value)
            if (f.error != null) {
                println(f.error)
                res = 6
            }
        }
    }

    // Parse file content
    if (res == 0) {
        ptr := strtok(toCString(fileContent), toCString(","))
        while(ptr != null) {
            println(fromCString(ptr))
            ptr = strtok(null, toCString(","))
        }
    }

    endTime := clock()

    print("time: ")
    print((endTime - startTime) as string)
    println("ms")

    return res
}