/**
 * HTTP utility functions.
 * Requires link to curl (-lcurl)
 */
module http

extern curl_easy_init() => any
extern curl_easy_setopt(curl: any, opt: int, param: any)
extern curl_easy_perform(curl: any) => int
extern curl_easy_cleanup(curl: any)
extern curl_easy_strerror(res: int) => any

import fs

/**
 * HTTP result.
 */
struct HttpResult {
    error: string
}

/**
 * Download resource pointed by an url
 * to a file.
 */
func downloadFile(url: string, file: fs.File) => HttpResult  {
    
    result := HttpResult(null)
    
    // Create session
    session := curl_easy_init()
    
    // Set options
    //curl_easy_setopt(session, 41, toCString("on"))
    curl_easy_setopt(session, 10000 + 2, toCString(url))
    curl_easy_setopt(session, 10000 + 1, file.descriptor)
    
    // Performa ction
    res := curl_easy_perform(session)
    
    if (res > 0) {
        result.error = fromCString(curl_easy_strerror(res))
    }
    curl_easy_cleanup(session)
    
    return result
}