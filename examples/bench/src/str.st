import str

func strSplit() {
    
    // Test string
    separator := "$$"
    s := "hello"
    testString := ""
    i := 0
    while (i < 300) {
        testString = testString + separator + s
        i = i + 1
    }
    
    i = 0
    while(i < 3000) {
        str.split(testString, separator)
        i = i + 1
    }
    
}

func strContains() {
    
    // Test string
    s := "Hello :) you"
    subString := ":)"
    
    testString := ""
    i := 0
    while (i < 300) {
        testString = testString + s
        i = i + 1
    }

    i = 0
    while (i < 300000) {
        str.contains(s, subString)
        i = i + 1
    }
    
}

func strTrim() {
    
    // Test string
    testString := "test string"
    i := 0
    while (i < 300) {
        testString = " " + testString + " "
        i = i + 1
    }
    
    i = 0
    while(i < 15000) {
        str.trim(testString)
        i = i + 1
    }
}