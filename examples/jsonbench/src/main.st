extern exit(code: int)
extern fgets(buffer: any, maxLength: int, file: any) => any

import fs
import http
import json
import time

func handleFileError(fr: fs.FileResult) {
    if (fr.error != null) {
        println(fr.error)
        exit(1)
    }
}

func handleHttpError(hr: http.HttpResult) {
    if (hr.error != null) {
        println(hr.error)
        exit(1)
    }
}

func handleJSONError(jr: json.JSONResult) {
    if (jr.error != null) {
        println(jr.error)
        exit(1)
    }
}

func downloadTestFile() {
    
    // Open file
    f := fs.openFile("test.json", "w")
    handleFileError(f)
    
    // Download
    url := "https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/twitter_timeline.json"
    hr := http.downloadFile(url, f.value)
    handleHttpError(hr)
    
    // Close file
    f = fs.closeFile(f.value)
    handleFileError(f)
    
}

func readTestFile() => string {
    
    result := ""
    
    // Open file
    f := fs.openFile("test.json", "r")
    handleFileError(f)
    
    cstr: any = toCString("01234567890123456789012345678901234567890123456789")
    while (fs.fileIsEOF(f.value) == false) {
        if (fgets(cstr, 50, f.value.descriptor) == null) {
            println("failed to load test file")
            exit(1)
        } else {
            result = result + fromCString(cstr)
        }
    }
    
    // Close file
    f = fs.closeFile(f.value)
    handleFileError(f)
    
    return result
}

func parseTestFile() {
    
    jsonString := readTestFile()
    jr := json.parse(jsonString)
    handleJSONError(jr)
}


func main() => int {
    
    downloadTestFile()
    
    i := 0
    total := 5
    durations : double[]
    while (i < total) {
        start := time.formatTime(time.now(), "%S") as double
        print("Running " + (i + 1) as string + "/" + total as string+ "\r")
        printflush()
        parseTestFile()
        end := time.formatTime(time.now(), "%S") as double
        println((end - start) as string)
        i = i + 1
    }
    
    
    
/*g := json.parse("{\"ff\" : \"ab\\\"cd\"}")
    println(g.value.objectValue[0].value.stringValue)*/
    
    
    return 0
}