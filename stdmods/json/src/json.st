/**
 * JSON manipulation functions.
 */
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

/**
 * Parse a JSON string to a JSONValue.
 * @param value: stirng to parse
 * @result a JSONResult containing either a value or an error
 */
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
    // string
    if (str.startsWith(cleanedValue, "\"") && str.endsWith(cleanedValue, "\"")) {
        // TODO replace escaped strings !
        result.value = JSONValue("string", str.subString(cleanedValue, 1, cleanedValue.len - 1), 0, 0.0, false, null, null)
    }

    // Unexpected error
    if (result.value == null) {
        result.error = "cannot parse JSON from " + cleanedValue
    }

    return result
}