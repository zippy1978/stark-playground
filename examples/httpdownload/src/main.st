extern exit(code: int)

import fs
import http

func handleFileError(fr: fs.FileResult) {
    if (fr.error != null) {
        println(fr.error)
        exit(1)
    }
}

func handleHttpError(hr: http.HttpResult) {
    if (hr.error != null) {
        println(hr.error)
        exit(1)
    }
}

func main() => int {
    
    // Open file
    f := fs.openFile("example.html", "w")
    handleFileError(f)
    
    // Download
    url := "https://example.com"
    hr := http.downloadFile(url, f.value)
    handleHttpError(hr)
    
    // Close file
    f = fs.closeFile(f.value)
    handleFileError(f)

    println("file downloaded !")
    
    return 0
}