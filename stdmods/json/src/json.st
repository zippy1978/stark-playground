module json

// Forward declaration
struct JSONValue

/**
 * JSON property.
 */
struct JSONProperty {
    name: string,
    value: JSONValue
}

/**
 * JSON value.
 */
struct JSONValue {
    type: string,
    stringValue: string,
    intValue: int,
    doubleValue: double,
    boolValue: bool,
    arrayValue: JSONValue[],
    objectValue: JSONProperty[]
}

/**
 * JSON result.
 */
struct JSONResult {
    value: JSONValue,
    error: string
}

func parse(value: string): JSONResult {
    result := JSONResult(null, null)
    // null
    if (value == "null") {
        result.value = JSONValue("null", null, 0, 0.0, false, null, null)
    }
    // boolean
    if (value == "true" || value == "false") {
        result.value = JSONValue("bool", null, 0, 0.0, value as bool, null, null)
    }
    // int
    intValue := value as int
    if (intValue != 0 || value == "0") {
        result.value = JSONValue("int", null, intValue, 0.0, false, null, null)
    }

    return result
}