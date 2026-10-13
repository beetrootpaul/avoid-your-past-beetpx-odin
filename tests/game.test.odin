package tests_ayp

import ayp "../src"
import "beetpx:bpx"
import "core:hash"
import tt "core:testing"

// Runs the whole game on the "nil" platform and compares hashes of the canvas
// at given ticks. When the look of the game changes on purpose, take the new
// hashes from the failure output.
@(test)
splash_then_start_screen :: proc(t: ^tt.T) {
	ayp.main()
	tick_s := 1.0 / f64(bpx.tick_rate())

	// The splash screen, with the sash.
	bpx.nil_platform_step(tick_s)
	tt.expect_value(t, _canvas_hash(), 796951266)

	for _ in 1 ..< 200 {
		bpx.nil_platform_step(tick_s)
	}
	// The start screen, after the sash collapsed.
	tt.expect_value(t, _canvas_hash(), 3596187976)
}

@(private = "file")
_canvas_hash :: proc() -> u32 {
	return hash.crc32(bpx.nil_platform_canvas_rgba8_bytes())
}
