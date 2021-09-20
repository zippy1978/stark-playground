import str

func testTrim() {
    assertStringEquals(str.trim("   test   "), "test")
}

func testSubString() {
    assertStringEquals(str.subString("Hello", 0, 2), "He")
    assertStringEquals(str.subString("Hello", 0, 1), "H")
    assertStringEquals(str.subString("Hello", 2, 3), "l")
}