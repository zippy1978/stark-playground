import gfx

extern glClearColor(red: double, gree: double, blue: double, alpha: double)

func main() => int {

    // Init context
    if (gfx.init() == false) {
        println("Init error")
        return 1
    }

    // Create window
    width := 1200
    height:= 800
    window := gfx.createWindow(width, height, "Hello")

    // Set active context
    gfx.makeContextCurrent(window)
    
    // Loop
    while(gfx.windowShouldClose(window) == false) {
        
        gfx.pollEvents()

        // Draw here
        gfx.clear()
        glClearColor(1.0, 1.0, 1.0, 1.0)

        gfx.swapBuffers(window)
    }

    gfx.terminate()

    return 0
}