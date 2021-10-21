/**
 * String manipulation functions.
 */
module str

extern strlen(str: any ) => int
extern strstr(str: any, subStr: any) => any

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
 * Get a slice of a string. A slice is a sub string created without memory allocation.
 * Meaning: it is faster, but inner data may change as it is only pointed from another object.
 * @param value: original stirng
 * @param start: sub stirng start index
 * @param end: sub stirng end index
 * @return sub string as a new string
 */
func slice(value: string, start: int, end: int) => string {
    slice: string
    slice.data = offsetCharPointer(value.data, start)
    slice.len = end - start
    return slice
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
    test := slice(value, start, start + 1)
    while (test == " " || test == "\t" || test == "\r" || test == "\n") {
        start = start + 1
        test = slice(value, start, start + 1)
    }
    test = slice(value, end - 1, end)
    while (test == " " || test == "\t" || test == "\r" || test == "\n") {
        end = end - 1
        test = slice(value, end - 1, end)
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
    return slice(value, 0, test.len) == test
}

/**
 * Tests if a string ends with a given string.
 * @param value: string to test on
 * @param test: sub string to test
 * @return true if value ends with test
 */
func endsWith(value: string, test: string) => bool {
    return slice(value,  value.len - test.len, value.len) == test
}

/**
 * Splits a string on the a given separator.
 * @param value: string to split
 * @param separator: string to use a separator
 * @return a string[] contaning split string parts
 */
func split(value: string, separator: string) => string[] {

    result: string[]
    
    ptr := strstr(value.data, separator.data)
    startPtr := value.data
    previousLen := value.len
    len := 0
    slice: string
    while (ptr != null) {
        len = strlen(ptr)
        slice.data = startPtr
        slice.len = previousLen - len
        if (slice.len > 0) {
            result = result + [str.subString(slice, 0, slice.len)]
        }
        startPtr = offsetCharPointer(ptr, separator.len)
        previousLen = len - separator.len
        ptr = strstr(startPtr, separator.data)
    }
     
    // Last occurence case
    if (previousLen > 0 ) {
        slice.data = startPtr
        slice.len = value.len - len
        if (slice != separator) {
            result = result + [str.subString(slice, 0, slice.len)]
        }
        
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
    return strstr(value.data, subString.data) != null
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

