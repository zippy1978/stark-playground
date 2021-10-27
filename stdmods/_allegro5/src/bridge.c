#include <allegro5/allegro5.h>
#include <allegro5/allegro_font.h>

typedef long long int_t;
typedef double double_t;
typedef void *any_t;
typedef unsigned char bool_t;

typedef struct
{
    char *data;
    int_t len;
} string_t;

typedef struct
{
    void *elements;
    int_t len;
} array_t;

extern any_t stark_runtime_priv_mm_alloc(int_t size);

typedef struct
{
    string_t *type;

} allegro_event_t;

typedef struct
{
    double_t r;
    double_t g;
    double_t b;
    double_t a;
} allegro_color_t;

string_t *createAllegroString(const char *s)
{
    string_t *result = (string_t *)stark_runtime_priv_mm_alloc(sizeof(string_t));
    result->len = strlen(s);
    result->data = (char *)stark_runtime_priv_mm_alloc(sizeof(char) * (result->len + 1));
    memcpy(result->data, s, result->len);
    result->data[result->len] = '\0';
    return result;
}

any_t *createAllegroEvent()
{
    ALLEGRO_EVENT *event = (ALLEGRO_EVENT *)stark_runtime_priv_mm_alloc(sizeof(ALLEGRO_EVENT));
    return (any_t)event;
}

allegro_event_t *fromAllegroEvent(any_t ae)
{
    ALLEGRO_EVENT *event = (ALLEGRO_EVENT *)ae;
    allegro_event_t *result = (allegro_event_t *)stark_runtime_priv_mm_alloc(sizeof(allegro_event_t));

    switch (event->type)
    {
    case ALLEGRO_EVENT_DISPLAY_CLOSE:
        result->type = createAllegroString("DISPLAY_CLOSE");
        break;
    case ALLEGRO_EVENT_TIMER:
        result->type = createAllegroString("TIMER");
        break;
    default:
        result->type = createAllegroString("UNKOWN");
        break;
    }

    return result;
}

void allegroClearToColor(allegro_color_t *color)
{
    al_clear_to_color(al_map_rgba_f(color->r, color->g, color->b, color->a));
}

void allegroDrawText(any_t font, allegro_color_t *color, int_t x, int_t y, int_t flags, string_t *text)
{
    al_draw_text((ALLEGRO_FONT *)font, al_map_rgba_f(color->r, color->g, color->b, color->a), x, y, flags, text->data);
}

void allegroDrawBitmap(any_t bitmap, int_t x, int_t y, int_t flags)
{
    al_draw_bitmap((ALLEGRO_BITMAP *)bitmap, x, y, flags);
}