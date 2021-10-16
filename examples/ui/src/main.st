//import gfx


extern SDL_Init(flags: int) => int
extern SDL_Quit()
extern SDL_GetError() => any
extern SDL_CreateWindow(title: any, x: int, y: int, w: int, h: int, flags: int) => any
extern SDL_DestroyWindow(window: any)
extern SDL_Delay(ms: int)
extern SDL_PollEvent(event: any) => int
extern SDL_WaitEvent(event: any) => int
extern SDL_CreateRenderer(window: any, index: int, flags: int) => any
extern SDL_DestroyRenderer(renderer: any)
extern SDL_SetRenderDrawColor(renderer: any, r: int, g: int, b: int, a: int) => int
extern SDL_RenderClear(renderer: any) => int
extern SDL_RenderPresent(renderer: any) => int
extern SDL_RenderDrawPoint(renderer: any, x: int, y: int) => int
extern SDL_RenderDrawLine(renderer: any, x1: int, y1: int, x2: int, y2: int) => int

func main() => int {
    
    SDL_INIT_EVERYTHING := 29233
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
        println("failed to initialize SDL : " + fromCString(SDL_GetError()))
        return 50
    }
    
    SDL_WINDOW_SHOWN := 4
    
    window := SDL_CreateWindow(toCString("Hello SDL"), 300, 300, 1000, 800, 36)
    if (window == null) {
        println("failed to create window : " + fromCString(SDL_GetError()))
        return 60
    }
    
    renderer := SDL_CreateRenderer(window, -1, 1)
    if (renderer == null) {
        println("failed to create renderer : " + fromCString(SDL_GetError()))
        return 70
    }
    
    println(SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255) as string)
    println(SDL_RenderClear(renderer) as string)
    
    println(SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255) as string)
    SDL_RenderDrawPoint(renderer, 50, 50)
    SDL_RenderDrawLine(renderer, 0, 0, 640, 480)

    SDL_RenderPresent(renderer)
    
    SDL_Delay(3000)
    
    event := toCString("                                                                                                               ")
    while (true) {
           
        SDL_WaitEvent(event)
    }
    
    SDL_DestroyRenderer(renderer)
    SDL_DestroyWindow(window)
    SDL_Quit()
    return 0
}
