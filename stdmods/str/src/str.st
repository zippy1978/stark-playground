/**
 * String manipulation functions.
 */
module str

func subString(value: string, start: int, end: int): string {
    return fromCSubString(toCString(value), start, end)
}

func trim(value: string): string {
    start := 0
    end := value.len
    while (subString(value, start, start + 1) == " ") {
        start = start + 1
    }
    while (subString(value, end - 1, end) == " ") {
        end = end - 1
    }
    return subString(value, start, end)
}
