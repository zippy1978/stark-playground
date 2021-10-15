extern sleep(d: int)

import time

func main() => int {
    
    // Forever
    while(true) {
        
        // Print time
        print("⏰ " + time.formatTime(time.now(), "%H:%M:%S") + "\r")
        printflush()
        
        // Every second
        sleep(1)
    }
    
    return 0
}