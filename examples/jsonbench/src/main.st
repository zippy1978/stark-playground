extern exit(code: int)
extern sleep(duration: int)
extern fgets(buffer: any, maxLength: int, file: any) => any
extern GC_enable_incremental()
extern GC_expand_hp(bytes: int)

import fs
import http
import json

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

func downloadTestFile(url: string) {
    
    // Open file
    f := fs.openFile("test.json", "w")
    handleFileError(f)
    
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
            //println("failed to load test file")
            //exit(1)
        } else {
            result = result + fromCString(cstr)
        }
    }
    
    // Close file
    f = fs.closeFile(f.value)
    handleFileError(f)
    
    return result
}

func averageTime(durations : int[]) => int {
    total := 0
    i := 0
    while (i < durations.len) {
        total = total + durations[i]
        i = i + 1
    }
    return total / durations.len
}

func runTest(url: string, count: int) => int[] {
    
    println("Testing " + url)
    
    downloadTestFile(url)
    
    i := 0
    durations : int[]
    jsonString := readTestFile()

    while (i < count) {
        start := time()
        print("Running " + (i + 1) as string + "/" + count as string)
        if (i > 0) {
            print(" (" + averageTime(durations) as string + "ms)")
        }
        print("\r")
        printflush()
        
        jr := json.parse(jsonString)
        handleJSONError(jr)
        
        end := time()
        duration := end - start
        //println(duration as string)
        durations = durations + [duration]
        i = i + 1
        sleep(1)
    }
    print("Ran with average time of " +  averageTime(durations) as string + "ms")
    print("\r\n")
    
    return durations
}


func main() => int {

    //GC_enable_incremental()
    //GC_expand_hp(10240)
    
    println("Welcome to the JSON parse bench !")
    
    count := 25 // use 250 to see slowing down
    
    // Not running
    //runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/random.json", count)
    //runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/update-center.json", count)
    //runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/mesh.json", count)
    //runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/mesh.pretty.json", count)
    //runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/nested.json", count)

    // Instable
    //runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/instruments.json", count)
    
    
    // Working but slowing down and probably leaking
    runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/twitter_timeline.json", count)
    runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/github_events.json", count)
    runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/repeat.json", count)
    runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/truenull.json", count)
    runTest("https://raw.githubusercontent.com/amamchur/iJSONBenchmark/master/payload/apache_builds.json", count)
    
    //sleep(20)
    
    
    return 0
}