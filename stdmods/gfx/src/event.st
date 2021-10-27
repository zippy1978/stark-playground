module gfx

import _allegro5

struct Event {
    type: string
}

func waitForEvent(context: Context) => Event {
    al_wait_for_event(context.queue, context.event)
    event := fromAllegroEvent(context.event)
    return Event(event.type)
}

func isEventQueueEmpty(context: Context) => bool {
    return al_is_event_queue_empty(context.queue)
}