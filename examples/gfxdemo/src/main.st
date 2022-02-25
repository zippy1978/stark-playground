// FIXME : for some reason complier crashes when main loop is commented
// Also as a minimal example: just importing gfx with an empty main fails
// Seems to be releated to module import
import gfx

func main() => int {

    // FIXE ME : local var in while segfaults !
    /*while(true) {
       f := gfx.Event("OK")
    }*/

    // Gfx start function
    return gfx.run(func(argc: int, argv: any) => int {
        
        // Initialize (create context)
        cr := gfx.init(1024, 768)
        if (cr.error != null) {
            println("an error occured: " + cr.error)
            return 1
        }
        context := cr.value

        // Fonts
        builtinFont := gfx.getFont(context, "builtin")

        // Colors
        whiteColor := gfx.Color(1.0, 1.0, 1.0, 1.0)
        blackColor := gfx.Color(0.0, 0.0, 0.0, 1.0)
        redColor := gfx.Color(1.0, 0.0, 0.0, 1.0)
        greenColor := gfx.Color(0.0, 1.0, 0.0, 1.0)
        blueColor := gfx.Color(0.0, 0.0, 1.0, 1.0)

        // Bitmaps
        tonyBitmap := gfx.loadBitmap(context, "/Users/ggrousset/Projects/perso/starklang/tony.png")

        // Main loop
        shouldClose := false
        redraw := true
        x := 0 // for animation testing

        event: gfx.Event
        DISPLAY_CLOSE := "DISPLAY_CLOSE"
        TIMER := "TIMER"
        
        while(shouldClose != true) {
           
            // Retrieve event
            event = gfx.waitForEvent(context)
            
            
            // Handle events
            if (event.type == DISPLAY_CLOSE) {
                shouldClose = true
            }
            if (event.type == TIMER) {
                redraw = true
                //x = x + 1
            }
            
            // Draw
            if (redraw == true && gfx.isEventQueueEmpty(context)) {

                // Disabled until issue is fixed in lib
                //gfx.clearToColor(blueColor as any)
                gfx.drawText(builtinFont, whiteColor, 20, 20, 0, "Hello Stark !")

                gfx.drawBitmap(tonyBitmap, x, 50, 0)

                // Finish
                gfx.flipDisplay()
                redraw = false
            }
            
        }

        // Clean up
        gfx.destroy(context)

        return 0
    })

}



