module gfx

import _allegro5

/**
 * Gfx context.
 * Holds every data necessary
 * to run the graphic engine.
 */
struct Context {
    queue: any,
    display: any,
    timer: any,
    fonts: Font[],
    bitmaps: Bitmap[],
    event: any
}

struct ContextResult {
    value: Context,
    error: string
}

func run(startFunc: func(int, any) => int) => int {
    return al_run_main(0, null, startFunc)
}

func init(width: int, height: int) => ContextResult {
    result := ContextResult(null, null)
    if (al_install_system(al_get_allegro_version(), null) == true) {
        
        if (al_init_image_addon() != true) {
            result.error = "failed to initialize image addon"
            return result
        }
        
        queue := al_create_event_queue()
        if (queue == null) {
            result.error = "failed to initialize queue"
            return result
        }
        display := al_create_display(width, height)
        if (display == null) {
            result.error = "failed to initialize display"
            return result
        }
        timer := al_create_timer(1.0 / 30.0)
        if (timer == null) {
            result.error = "failed to initialize timer"
            return result
        }
        
        al_register_event_source(queue, al_get_display_event_source(display))
        al_register_event_source(queue, al_get_timer_event_source(timer))
        al_start_timer(timer)
        
        fonts := [Font("builtin", al_create_builtin_font())]
        context := Context(queue, display, timer, fonts, null, createAllegroEvent())
        result.value = context
        
    } else {
        result.error = "failed to initialize context"
    }
    return result
}


func destroy(context: Context) {
    al_destroy_display(context.display)
    al_destroy_timer(context.timer)
    al_destroy_event_queue(context.queue)
    
    i := 0
    if (context.fonts != null) {
        while (i < context.fonts.len) {
            destroyFont(context.fonts[i])
            i = i + 1
        }
    }
    
    i = 0
    if (context.bitmaps != null) {
        while (i < context.bitmaps.len) {
            destroyBitmap(context.bitmaps[i])
            i = i + 1
        }
    }
}