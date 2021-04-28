extern fgets(buffer: any, maxLength: int, file: any): any
extern strtok(str: any, delim: any): any

extern time(t: any): any
extern difftime(end: any, begin: any): int
extern clock(): int

import fs

struct StringResult {
    value: string,
    error: string
}

func readFromFile(file: fs.File): StringResult {
    cstr: any = toCString("01234567890123456789012345678901234567890123456789")
    error: string = null
    if (fgets(cstr, 50, file.descriptor) == null) {
        error = "cannot read file"
    }
    return StringResult(fromCString(cstr), error)
}

func main(): int {
    
    startTime := clock()
    
    res := 0
    
    // Write to file
    f := fs.openFile("test", "w")
    if (f.error != null) {
        println(f.error)
        res = 1
    } else {
        println("file opened !")
        f = fs.writeToFile(f.value, "hello,this,is,stark")
        if (f.error != null) {
            println(f.error)
            res = 2
        } else {
            println("wrote to file")
            f = fs.closeFile(f.value)
            if (f.error != null) {
                println(f.error)
                res = 3
            }
        }
    }
    
    // Read from file
    fileContent: string = null
    f = fs.openFile("test", "r")
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
            f = fs.closeFile(f.value)
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
    
    println("time: " + (endTime - startTime) as string + "ms")
    
    return res
}