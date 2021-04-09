/**
 * String manipulation utility functions.
 */
 module str

 extern strcat(destination: any, source: any ): any

 func concatString(dest: string, source: string): string {
     cstr := strcat(toCString(dest), toCString(source))
     return fromCString(cstr)
 }