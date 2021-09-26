import str

func testTrim() {
    assertStringEquals(str.trim("   test   "), "test")
}

func testSubString() {
    assertStringEquals(str.subString("Hello", 0, 2), "He")
    assertStringEquals(str.subString("Hello", 0, 1), "H")
    assertStringEquals(str.subString("Hello", 2, 3), "l")
}

func testStartsWith() {
    assertTrue(str.startsWith("Hello World !", "Hello"))
}

func testEndsWith() {
    assertTrue(str.endsWith("Hello World !", "World !"))
}

func testSplit() {
    test := "hello,world"
    result := str.split(test, ",")
    assertIntEquals(result.len, 2)
    assertStringEquals(result[0], "hello")
    assertStringEquals(result[1], "world")
}

func testJoin() {
    parts := ["hello", "world"]
    result := str.join(parts, ",")
    assertStringEquals(result, "hello,world")
}

func testReplace() {
    original := "aahelloaaworldaa"
    assertStringEquals(str.replace(original, "aa", "bb"), "bbhellobbworldbb")
}