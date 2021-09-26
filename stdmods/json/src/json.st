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
        objectDepth := 0
        arrayDepth := 0
        currentProperty := JSONProperty(null, null)
        objectProperties: JSONProperty[]
        hasError := false
        oi := 0
        previousChar := ""
        while (oi < objectString.len && (hasError == false)) {
            currentChar := str.subString(objectString, oi, oi +1)
            // Detect values between quotes
            if (currentChar == "\"" && previousChar != "\\") {
                insideQuotes = (insideQuotes == false)
            }
            // Detect values inside objets
            if (currentChar == "{") {
                objectDepth = objectDepth + 1
            }
            if (currentChar == "}") {
                objectDepth = objectDepth - 1
            }
            // Detect values inside arrays
            if (currentChar == "[") {
                arrayDepth = arrayDepth + 1
            }
            if (currentChar == "]") {
                arrayDepth = arrayDepth - 1
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
                if (propertyName.len > 0) {
                    currentProperty.name = str.subString(propertyName, 1, propertyName.len )
                    propertyName = ""
                }
            }
            // Detect end of property value
            if ((currentChar == "," || ((oi + 1) == objectString.len)) && (insideQuotes == false) && (objectDepth == 0) && (arrayDepth == 0)) {
                // Remove trailing comma if any
                if (str.endsWith(propertyValue, ",")) {
                    propertyValue = str.subString(propertyValue, 0, propertyValue.len - 1)
                }
                pr := parse(propertyValue)
                result.error = pr.error
                if (pr.error == null) {
                    currentProperty.value = pr.value
                    propertyValue = ""
                    objectProperties = objectProperties + [currentProperty]
                    currentProperty = JSONProperty(null, null)
                } else {
                    // Parsing error
                    hasError = true
                }
                
            }
            previousChar = currentChar
            oi = oi + 1
        }
        if (hasError == false) {
            result.value = JSONValue("object", null, 0, 0.0, false, null, objectProperties)
        }

    }

    // array
    if (str.startsWith(cleanedValue, "[") && str.endsWith(cleanedValue, "]")) {
        arrayString := str.trim(str.subString(cleanedValue, 1, cleanedValue.len - 1))
        entries: JSONValue[]
        objectDepth := 0
        arrayDepth := 0
        entryValue := ""
        insideQuotes := false
        hasError := false
        previousChar := ""
        oi := 0
        while (oi < arrayString.len && (hasError == false)) {
            currentChar := str.subString(arrayString, oi, oi +1)
            // Detect values between quotes
            if (currentChar == "\"" && previousChar != "\\") {
                insideQuotes = (insideQuotes == false)
            }
            // Detect values inside objets
            if (currentChar == "{") {
                objectDepth = objectDepth + 1
            }
            if (currentChar == "}") {
                objectDepth = objectDepth - 1
            }
            // Detect values inside arrays
            if (currentChar == "[") {
                arrayDepth = arrayDepth + 1
            }
            if (currentChar == "]") {
                arrayDepth = arrayDepth - 1
            }
            // Collect entry value
            entryValue = entryValue + currentChar
            // Detect end of entry value
            if ((currentChar == "," || ((oi + 1) == arrayString.len)) && (insideQuotes == false) && (objectDepth == 0) && (arrayDepth == 0)) {
                // Remove trailing comma if any
                if (str.endsWith(entryValue, ",")) {
                    entryValue = str.subString(entryValue, 0, entryValue.len - 1)
                }
                pr := parse(entryValue)
                result.error = pr.error
                if (pr.error == null) {
                    entries = entries + [pr.value]
                    entryValue = ""
                } else {
                    // Parsing error
                    hasError = true
                }
                
            }
            previousChar = currentChar
            oi = oi + 1
        }
        if (hasError == false) {
            result.value = JSONValue("array", null, 0, 0.0, false, entries, null)
        }

    }

    // Unexpected error
    if (result.value == null && result.error == null) {
        result.error = "cannot parse JSON from " + cleanedValue
    }

    return result
}