module json

import str

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
    cleanedValue := str.trim(value)
    // null
    if (cleanedValue == "null") {
        result.value = JSONValue("null", null, 0, 0.0, false, null, null)
    }
    // boolean
    if (cleanedValue == "true" || value == "false") {
        result.value = JSONValue("bool", null, 0, 0.0, cleanedValue as bool, null, null)
    }
    // int
    intValue := cleanedValue as int
    if (intValue != 0 || cleanedValue == "0") {
        result.value = JSONValue("int", null, intValue, 0.0, false, null, null)
    }

    // Unexpected error
    if (result.value == null) {
        result.error = "cannot parse JSON from " + cleanedValue
    }

    return result
}