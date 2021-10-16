module gfx

// GLFW
extern glfwInit() => bool
extern glfwTerminate()
extern glfwCreateWindow(width: int, height: int, name: any, x: any, y: any) => any
extern glfwMakeContextCurrent(window: any)
extern glfwGetFramebufferSize(window: any, width: any, height: any)
extern glfwGetWindowSize(window: any, width: any, height: any)
extern glfwWindowShouldClose(window: any) => bool
extern glfwPollEvents()
extern glfwSwapBuffers(window: any)
extern glfwSetErrorCallback(callback: func (int, any) => void)

// GLEW
extern glewInit() => bool

// OpenGL
extern glViewport(x: int, y: int, width: int, height: int)
extern glClearColor(red: double, gree: double, blue: double, alpha: double)
extern glClear(mask: int)


struct Window {
    handle: any
}

struct Size {
    x: int,
    y: int
}

func init() => bool {
    // TODO : find a cleaner way to report errors
    glfwSetErrorCallback(func (code: int, message: any) => void {
        println("Error " + code as string + ": " + fromCString(message))
    })
    return glfwInit()
}

func initGlew() => bool {
    glewInit()
}

func createWindow(width: int, height: int, name: string) => Window {
    handle := glfwCreateWindow(width, height, toCString(name), null, null)
    return Window(handle)
}

func getFramebufferSize(window: Window) => Size {
    widthPtr := toIntPointer(0)
    heightPtr : = toIntPointer(0)
    glfwGetFramebufferSize(window.handle, widthPtr, heightPtr)
    return Size(fromIntPointer(widthPtr), fromIntPointer(heightPtr))
}

func getWindowSize(window: Window) => Size {
    widthPtr := toIntPointer(0)
    heightPtr : = toIntPointer(0)
    glfwGetWindowSize(window.handle, widthPtr, heightPtr)
    return Size(fromIntPointer(widthPtr), fromIntPointer(heightPtr))
}

func setViewport(x: int, y: int, width: int, height: int) {
    glViewport(x, y, width, height)
}

func windowShouldClose(window: Window) => bool {
    return glfwWindowShouldClose(window.handle)
}

func makeContextCurrent(window: Window) {
    glfwMakeContextCurrent(window.handle)
}

func terminate() {
    glfwTerminate()
}

func pollEvents() {
    glfwPollEvents()
}

func swapBuffers(window: Window) {
    glfwSwapBuffers(window.handle)
}

func clear() {
    GL_COLOR_BUFFER_BIT := 16384
    glClear(GL_COLOR_BUFFER_BIT)
}