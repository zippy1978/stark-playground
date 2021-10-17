/**
 * String manipulation functions.
 */
module str

extern strtok(str: any, delim: any) => any
extern strlen(str: any ) => int

/**
 * Get a sub string of a string.
 * @param value: original stirng
 * @param start: sub stirng start index
 * @param end: sub stirng end index
 * @return sub string as a new string
 */
func subString(value: string, start: int, end: int) => string {
    return fromCSubString(value.data, start, end)
}

/**
 * Trims a string.
 * @param value: original string
 * @return trimmed string as a new string
 */
func trim(value: string) => string {

    if (value.len == 0) {
        return ""
    }

    start := 0
    end := value.len
    test := subString(value, start, start + 1)
    while (test == " " || test == "\t" || test == "\r" || test == "\n") {
        start = start + 1
        test = subString(value, start, start + 1)
    }
    test = subString(value, end - 1, end)
    while (test == " " || test == "\t" || test == "\r" || test == "\n") {
        end = end - 1
        test = subString(value, end - 1, end)
    }
    if (start < end) {
        return subString(value, start, end)
    } else {
        return ""
    }
    
}

/**
 * Tests if a string starts with a given string.
 * @param value: string to test on
 * @param test: sub string to test
 * @return true if value starts with test
 */
func startsWith(value: string, test: string) => bool {
    return subString(value, 0, test.len) == test
}

/**
 * Tests if a string ends with a given string.
 * @param value: string to test on
 * @param test: sub string to test
 * @return true if value ends with test
 */
func endsWith(value: string, test: string) => bool {
    return subString(value, value.len - test.len, value.len) == test
}

/**
 * Splits a string on the a given separator.
 * @param value: string to split
 * @param separator: string to use a separator
 * @return a string[] contaning split string parts
 */
func split(value: string, separator: string) => string[] {
    separatorAsCString := separator.data
    result: string[]
    valueAsCString := toCString(value)
    ptr := strtok(valueAsCString, separatorAsCString)
    while(ptr != null) {
        result = result + [fromCString(ptr)]
        ptr = strtok(null, separatorAsCString)
    }
    return result
}

/**
 * Checks if a string contains a given substring.
 * @param value: string to search in
 * @param separator: sub string to search
 * @return true/false
 */
func contains(value: string, subString: string) => bool {
    found := 0
    subStringCString := toCString(subString)
    valueCString := toCString(value)
    ptr := strtok(valueCString, subStringCString)
    while(ptr != null) {
        found = found + 1
        ptr = strtok(null, subStringCString)
    }
    return found > 1
}

/**
 * Joins a string with a given separator.
 * @param parts: string[] containing strings to join
 * @param separator: string to use a separator
 * @return the joined string
 */
func join(parts: string[], separator: string) => string {
    result := ""
    if (parts != null) {
        i := 0
        while (i < parts.len) {
            result = result + parts[i]
            i = i + 1
            if (i != parts.len) {
                result = result + separator
            }
        }
    }
    return result
}

/**
 * Replaces each occurence of sub string in a given string with another sub string.
 * @param value: target string
 * @param old: sub string to replace
 * @param new: replacement sub string
 * return a string
 */
func replace(value: string, old: string, new: string) => string {
    parts := split(value, old)
    result := ""
    if (startsWith(value, old)) {
        result = result + new
    }
    result = result + join(parts, new)
    if (endsWith(value, old)) {
        result = result + new
    }
    return result
}

