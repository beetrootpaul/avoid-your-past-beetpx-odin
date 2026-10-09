package main

import "beetpx:bpx"

Splash :: struct {
	sash: Sash,
}

splash_enter :: proc() -> Splash {
	return {sash = sash_make(duration = 8 * MUSIC_BEAT_FRAMES, expand = false)}
}

splash_update :: proc(s: ^Splash) -> (done: bool) {
	if sash_has_collapsed(s.sash) do return true

	sash_update(&s.sash)

	return false
}

splash_draw :: proc(s: Splash) {
	bpx.d_rect_filled({0, 0}, SCREEN_SIZE, BG_COLOR_MODE_NORMAL)

	sash_draw(s.sash)
	// TODO: Draw the title and the author, once BeetPx has text.
}
