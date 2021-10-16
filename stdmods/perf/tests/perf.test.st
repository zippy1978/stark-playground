import perf
import str

extern sleep(d: int)

func testMeasure() {

    report := perf.measure("Measure test", 2, null, func () => void {
        sleep(1)
    })
    assertIntEquals(report.count, 2)
    assertIntEquals(report.times.len, 2)
    assertTrue(report.times[0] > 0)
}

func testAnalyze() {
    logger := func (message: string, level: string) {
        if (level == "title") {
            assertTrue(str.startsWith(message, "Report analysis"))
        }
    }
    report := perf.measure("Measure test", 2, null, func () => void {
        sleep(1)
    })
    perf.analyze(report, logger, 0.0, 0.0)
}