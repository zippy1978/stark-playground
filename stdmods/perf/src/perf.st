
/**
 * Performance tools.
 */
module perf

/**
 * Measure report.
 */
struct MeasureReport {
    /** Report name  */
    name: string,
    /** Sample count */
    count: int,
    /** Holds recorded execution times (in ms) */
    times: int [],
    /** Average execution time (in ms) */
    averageTime: int
}

/**
 * Measure code execution.
 * @param name: name of the test
 * @param count: execution count (samples)
 * @param logger: logger. Function (string, string) expecting a message, and a level.
 * @param function: code to measure
 * @return a MeasureReport
 */
func measure(name: string, count: int, logger: func(string, string) => void, function: func () => void) => MeasureReport {
    
    times: int []
    report := MeasureReport(name, count, times, 0)
    i := 0
    
    average := func(values: int[]) => int {
        j := 0
        total := 0
        while (j < values.len) {
            total = total + values[j]
            j = j + 1
        }
        return total / values.len
    }
    
    while (i < count) {
        
        if (logger != null) {
            logMessage := "🧪 Running " + name + " " + (i + 1) as string + "/" + count as string
            if (report.averageTime > 0) {
                logMessage = logMessage + " (average " + report.averageTime as string + "ms)"
            }
            logger(logMessage, "info")
        }
        
        start := time()
        function()
        end := time()
        time := end - start
        report.times = report.times + [time]
        report.averageTime = average(report.times)
        i = i + 1
    }
    return report
}

func analyze(report: MeasureReport, logger: func(string, string) => void, maxFirstLastExecutionDiffRatio: double, maxExecutionDiffRatio: double) {
    
    logger("Report analysis - " + report.name + " (execution count: " + report.count as string + ", average time: " + report.averageTime as string + "ms)           ", "title")
    
    findMinMax := func(values: int[]) => int[] {
        result := [0, 0] // min, max
        if (values.len > 0) {
            result[0] = values[0]
            result[1] = values[0]
        }
        i := 0
        while (i < values.len) {
            current := values[i]
            if (current < result[0]) {
                result[0] = current
            }
            if (current > result[1]) {
                result[1] = current
            }
            i = i + 1
        }
        return result
    }
    
    abs := func(value: double) => double {
        if (value < 0.0) {
            return value * -1.0
        } else {
            return value
        }
    }
    
    // Analyze execution times
    minAndMax := findMinMax(report.times)
    // First / last execution time difference %
    startEndTimeRatio := (report.times[report.count -  1] as double / report.times[0] as double) - 1.0
    logMessage := (startEndTimeRatio * 100.0) as string + "% execution time difference between first and last iteration"
    logLevel := "success"
    if (startEndTimeRatio > maxFirstLastExecutionDiffRatio) {
        logLevel = "error"
    }
    logger(logMessage, logLevel)
    // Absolute max difference between 2 executions
    maxTimeDiffRatio := 1.0 - abs(minAndMax[0] as double/ minAndMax[1] as double)
    logMessage = (maxTimeDiffRatio * 100.0) as string + "% execution time difference between fastest and slowest executions"
    logLevel = "success"
    if (maxTimeDiffRatio > maxExecutionDiffRatio) {
        logLevel = "error"
    }
    logger(logMessage, logLevel)
    
}