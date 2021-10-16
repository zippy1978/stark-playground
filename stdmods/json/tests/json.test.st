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

func testParseDouble() {
    
    nonZeroResult := json.parse("12.00000")
    assertTrue(nonZeroResult.value != null)
    assertStringEquals(nonZeroResult.value.type, "double")
    assertTrue(nonZeroResult.value.doubleValue == 12.0)
    
    zeroResult := json.parse("0.000")
    assertTrue(zeroResult.value != null)
    assertStringEquals(zeroResult.value.type, "double")
    assertDoubleEquals(zeroResult.value.doubleValue, 0.0)
}

func testParseString() {
    result := json.parse("\"hello\"")
    assertTrue(result.value != null)
    assertTrue(result.value.type == "string")
    assertStringEquals(result.value.stringValue, "hello")
}

func testParseObject() {
    result := json.parse("{ \"key1\" : \"value1\", \"key2\" : 1, \"key3\" : {\"subkey1\": \"subvalue1\"}}")
    assertTrue(result.value != null)
    assertTrue(result.value.type == "object")
    assertTrue(result.value.objectValue != null)
    assertIntEquals(result.value.objectValue.len, 3)

    assertStringEquals(result.value.objectValue[0].name, "key1")
    assertStringEquals(result.value.objectValue[0].value.type, "string")
    assertStringEquals(result.value.objectValue[0].value.stringValue, "value1")

    assertStringEquals(result.value.objectValue[1].name, "key2")
    assertStringEquals(result.value.objectValue[1].value.type, "int")
    assertIntEquals(result.value.objectValue[1].value.intValue, 1)

    assertStringEquals(result.value.objectValue[2].name, "key3")
    assertStringEquals(result.value.objectValue[2].value.type, "object")
    assertStringEquals(result.value.objectValue[2].value.objectValue[0].name, "subkey1")
    assertStringEquals(result.value.objectValue[2].value.objectValue[0].value.type, "string")
    assertStringEquals(result.value.objectValue[2].value.objectValue[0].value.stringValue, "subvalue1")

    resultEmptyObject := json.parse("{}")
    assertTrue(resultEmptyObject.value != null)
    assertTrue(resultEmptyObject.value.type == "object")
    assertTrue(resultEmptyObject.value.objectValue != null)
    assertIntEquals(resultEmptyObject.value.objectValue.len, 0)
}

func testParseArray() {
    result := json.parse("[\"hello\", {\"key1\" : [{\"name\": \"item1\"}, {\"name\": \"item2\"}]}]")
    assertTrue(result.value != null)
    assertTrue(result.value.type == "array")
    assertTrue(result.value.arrayValue != null)
    assertIntEquals(result.value.arrayValue.len, 2)
    assertStringEquals(result.value.arrayValue[0].type, "string")
    assertStringEquals(result.value.arrayValue[0].stringValue, "hello")
    assertStringEquals(result.value.arrayValue[1].type, "object")
    assertStringEquals(result.value.arrayValue[1].objectValue[0].name, "key1")
    assertStringEquals(result.value.arrayValue[1].objectValue[0].value.type, "array")
    assertStringEquals(result.value.arrayValue[1].objectValue[0].value.arrayValue[1].type, "object")
    assertStringEquals(result.value.arrayValue[1].objectValue[0].value.arrayValue[1].objectValue[0].name, "name")
    assertStringEquals(result.value.arrayValue[1].objectValue[0].value.arrayValue[1].objectValue[0].value.type, "string")
    assertStringEquals(result.value.arrayValue[1].objectValue[0].value.arrayValue[1].objectValue[0].value.stringValue, "item2")
}


func testParseComplete() {

    jsonString := 
    "
        {
        \"quiz\": {
            \"sport\": {
                \"q1\": {
                    \"question\": \"Which one is correct team name in NBA?\",
                    \"options\": [
                        \"New York Bulls\",
                        \"Los Angeles Kings\",
                        \"Golden State Warriros\",
                        \"Huston Rocket\"
                    ],
                    \"answer\": \"Huston Rocket\"
                }
            },
            \"maths\": {
                \"q1\": {
                    \"question\": \"5 + 7 = ?\",
                    \"options\": [
                        \"10\",
                        \"11\",
                        \"12\",
                        \"13\"
                    ],
                    \"answer\": \"12\"
                },
                \"q2\": {
                    \"question\": \"12 - 8 = ?\",
                    \"options\": [
                        \"1\",
                        \"2\",
                        \"3\",
                        \"4\"
                    ],
                    \"answer\": \"4\"
                }
            }
        }
    }
    "

    result := json.parse(jsonString)
    assertTrue(result.value != null)
    assertTrue(result.value.type == "object")
    assertTrue(result.value.objectValue != null)

}