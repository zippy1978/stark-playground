module gfx

import _allegro5

struct Bitmap {
    allegroBitmap: any
}


func loadBitmap(context: Context, path: string) => Bitmap {
    // TODO check bitmap is loaded
    b := Bitmap(al_load_bitmap(path.data))
    if (context.bitmaps == null) {
        context.bitmaps = [b]
    } else {
        context.bitmaps = context.bitmaps + [b]
    }
    return b
}

func drawBitmap(bitmap: Bitmap, x: int, y: int, flags: int) {
    allegroDrawBitmap(bitmap.allegroBitmap, x, y, flags)
}

func destroyBitmap(bitmap: Bitmap) {
    al_destroy_bitmap(bitmap.allegroBitmap)
}