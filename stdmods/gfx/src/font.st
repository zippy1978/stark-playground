module gfx

import _allegro5

struct Font {
    name: string,
    allegroFont: any
}

func getFont(context: Context, name: string) => Font {
    // Always return the builtin font for the moment
    return context.fonts[0]
}

func destroyFont(font: Font) {
    al_destroy_font(font.allegroFont)
}

func drawText(font: Font, color: Color, x: int, y: int, flags: int, text: string) {
    c := AllegroColor(color.r, color.g, color.b, color.a)
    allegroDrawText(font.allegroFont, c, x, y, flags, text)
}