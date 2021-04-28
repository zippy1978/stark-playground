extern sleep(d: int)
extern time(t: any): int
extern localtime(t: any): any
extern strftime(buffer: any, bufferSize: int, format: any, time: any): int

/**
 * Time struct.
 */
struct Time {
    timeInfo: any
}

/**
 * Return Time struct at the current date
 */
func now(): Time {
    return Time(localtime(toIntPointer(time(null))))
}

/**
 * Format a Time struct to a string
 */
func formatTime(t: Time, format: string): string {
    cstr := toCString(format)
    strftime(cstr, format.len, toCString(format), t.timeInfo)
    return fromCString(cstr)
}

func main(): int {
    
    // Forever
    while(true) {
        
        // Print time
        print("⏰ " + formatTime(now(), "%H:%M:%S") + "\r")
        //print(formatTime(now(), "%H:%M:%S"))
        //print("\r")
        printflush()
        
        // Every second
        sleep(1)
    }
    
    return 0
}