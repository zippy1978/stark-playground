import json

func testParseNull() {
    result := json.parse("null")
    assertTrue(result.value != null)
    assertTrue(result.value.type == "null")
}

func testParseBool() {
    trueResult := json.parse("true")
    assertTrue(trueResult.value != null)
    assertTrue(trueResult.value.type == "bool")
    assertTrue(trueResult.value.boolValue)
    
    falseResult := json.parse("false")
    assertTrue(falseResult.value != null)
    assertTrue(falseResult.value.type == "bool")
    assertTrue(falseResult.value.boolValue == false)
}

func testParseInt() {
    nonZeroResult := json.parse("12")
    assertTrue(nonZeroResult.value != null)
    assertTrue(nonZeroResult.value.type == "int")
    assertTrue(nonZeroResult.value.intValue == 12)
    
    zeroResult := json.parse("0")
    assertTrue(zeroResult.value != null)
    assertTrue(zeroResult.value.type == "int")
    assertTrue(zeroResult.value.intValue == 0)
}

func testParseString() {
    result := json.parse("\"hello\"")
    assertTrue(result.value != null)
    assertTrue(result.value.type == "string")
    assertStringEquals(result.value.stringValue, "hello")
}

func testParseObject() {
    result := json.parse("{ \"key1\" : \"value1\", \"key2\" : 1}")
    assertTrue(result.value != null)
    assertTrue(result.value.type == "object")
    assertTrue(result.value.objectValue != null)
    assertIntEquals(result.value.objectValue.len, 2)
    assertStringEquals(result.value.objectValue[0].name, "key1")
    assertStringEquals(result.value.objectValue[0].value.type, "string")
    assertStringEquals(result.value.objectValue[0].value.stringValue, "value1")
}