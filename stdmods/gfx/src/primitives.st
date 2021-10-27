module gfx

import _allegro5

// FIXME : adding a return is just a fix to prevent SEGFAULT with Color type
// This is probably a matter of having the type defined as Color and gfx.Color and a bitcast isue when returning void
func clearToColor(color: Color) => bool {
    allegroClearToColor(AllegroColor(color.r, color.g, color.b, color.a))
    return true
}
