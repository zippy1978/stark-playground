import perf
import str

extern sleep(d: int)

func measureLogger(message: string, level: string) {
    print(message + "\r")
    printflush()
}

func analyzeLogger(message: string, level: string) {
    
    separator := "-------------------------------------------------------------------------------------------------------"
    
    if (level == "title") {
        println(separator)
    }
    
    levelIcon := ""
    if (level != null) {
        if (level == "title") {
            levelIcon = "📊 "
        }
        if (level == "success") {
            levelIcon = "✅ "
        }
        if (level == "error") {
            levelIcon = "❌ "
        }
    }
    println(levelIcon + message)
    if (level == "title") {
        println(separator)
    }
}

func main() => int {

    count := 25
    
    r := perf.measure("string: memory allocations", count, measureLogger, stringMemoryAllocations)
    perf.analyze(r, analyzeLogger, 0.05, 0.15)

    r = perf.measure("str: split", count, measureLogger, strSplit)
    perf.analyze(r, analyzeLogger, 0.05, 0.15)

    r = perf.measure("str: trim", count, measureLogger, strTrim)
    perf.analyze(r, analyzeLogger, 0.05, 0.15)
    
    return 0
}