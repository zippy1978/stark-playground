func stringMemoryAllocations() {
    
    // Concat string
    i := 0
    while(i < 500000) {
        s := "test string"
        i = i + 1
    }
    
}

func stringConcat() {

    s1 := "test string"
    s2 := "test string 2"

    // Concat string
    i := 0
    while(i < 100000) {
        s := s1 + s2
        i = i + 1
    }
}

func stringCInterop() {

    s := "test string"
    count := 100000
    
    // From C / to C string conversion
    i := 0
    while(i < count) {
        cstring := toCString(s)
        r := fromCString(cstring)
        i = i + 1
    }
    
    // C sub string to string conversion
    i = 0
    while(i < count) {
        cstring := toCString(s)
        r := fromCSubString(cstring, 1, 3)
        i = i + 1
    }
}