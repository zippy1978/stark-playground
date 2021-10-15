module gfx

// GLFW
extern glfwInit() => bool
extern glfwTerminate()
extern glfwCreateWindow(width: int, height: int, name: any, x: any, y: any) => any
extern glfwMakeContextCurrent(window: any)
//extern glfwGetFramebufferSize(window: any, width: any, height: any)
extern glfwGetWindowSize(window: any, width: any, height: any)
extern glfwWindowShouldClose(window: any) => bool
extern glfwPollEvents()
extern glfwSwapBuffers(window: any)

// GLEW
extern glewInit() => int

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
    return glfwInit()
}

func createWindow(width: int, height: int, name: string) => Window {
    handle := glfwCreateWindow(width, height, toCString(name), null, null)
    glViewport(0, 0, width, height)
    return Window(handle)
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
    glClear(100000)
}