/**
 * String manipulation utility functions.
 */
 extern strcat(destination: any, source: any ): any

 func concatString(dest: string, source: string): string {
     cstr := strcat(toCString(dest), toCString(source))
     return fromCString(cstr)
 }