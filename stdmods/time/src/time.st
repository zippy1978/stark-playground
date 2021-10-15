/**
 * Time manipulation utility functions.
 */
module time

extern time(t: any) => int
extern localtime(t: any) => any
extern strftime(buffer: any, bufferSize: int, format: any, time: any) => int

/**
 * Time struct.
 */
struct Time {
    timeInfo: any
}

/**
 * Return Time struct at the current date.
 */
func now() => Time {
    return Time(localtime(toIntPointer(time(null))))
}

/**
 * Format a Time struct to a string.
 */
func formatTime(t: Time, format: string) => string {
    cstr := toCString(format)
    strftime(cstr, format.len, toCString(format), t.timeInfo)
    return fromCString(cstr)
}