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
        // Replace escaped strings
        stringValue := str.subString(cleanedValue, 1, cleanedValue.len - 1)
        stringValue = str.replace(stringValue, "\\r", "\r")
        stringValue = str.replace(stringValue, "\\n", "\n")
        stringValue = str.replace(stringValue, "\\t", "\t")
        result.value = JSONValue("string", stringValue, 0, 0.0, false, null, null)
    }
    // object
    if (str.startsWith(cleanedValue, "{") && str.endsWith(cleanedValue, "}")) {
        objectString := str.trim(str.subString(cleanedValue, 1, cleanedValue.len - 1))
        propertyValue := ""
        propertyName := ""
        insideQuotes := false
        currentProperty := JSONProperty(null, null)
        objectProperties: JSONProperty[]
        oi := 0
        while (oi < objectString.len) {
            currentChar := str.subString(objectString, oi, oi +1)
            // Detect values beteween quotes
            if (currentChar == "\"") {
                insideQuotes = (insideQuotes == false)
            }
            // Collect property name
            if (currentProperty.name == null && insideQuotes) {
                propertyName = propertyName + currentChar
            }
            // Collect property value
            if (currentProperty.name != null) {
                propertyValue = propertyValue + currentChar
            }
            // Detect end of key name
            if (currentChar == ":" && (insideQuotes == false)) {
                // Drop the starting quote with substring
                currentProperty.name = str.subString(propertyName, 1, propertyName.len )
                propertyName = ""
            }
            // Detect end of property value
            if ((currentChar == "," || ((oi + 1) == objectString.len)) && (insideQuotes == false)) {
                pr := parse(propertyValue)
                result.error = pr.error
                if (pr.error == null) {
                    currentProperty.value = pr.value
                    propertyValue = ""
                    objectProperties = objectProperties + [currentProperty]
                    currentProperty = JSONProperty(null, null)
                }
                
            }
            oi = oi + 1
        }
        result.value = JSONValue("object", null, 0, 0.0, false, null, objectProperties)

    }

    // Unexpected error
    if (result.value == null) {
        result.error = "cannot parse JSON from " + cleanedValue
    }

    return result
}