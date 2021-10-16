func stringMemoryAllocations() {
    
    // Create string
    s := "test string"
    
    // Concat string
    i := 0
    concatResult := ""
    while(i < 30000) {
        concatResult = concatResult + s
        i = i + 1
    }
    
    // From C / to C string conversion
    i = 0
    while(i < 30000) {
        cstring := toCString(s)
        fromCString(cstring)
        i = i + 1
    }
    
}