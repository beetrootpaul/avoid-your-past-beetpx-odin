package ayp

import "./g"
import "./gui"
import "beetpx:bpx"
import "beetpx:bpxd"

Screen_Splash :: struct {
	_sash: gui.Sash,
}

screen_splash_enter :: proc() -> Screen_Splash {
	return {
		_sash = gui.sash_make(8 * g.MUSIC_BEAT_FRAMES),
	}
}

screen_splash_update :: proc(s: ^Screen_Splash) -> Maybe(Screen) {
	if gui.sash_has_collapsed(s._sash) {
		return screen_start_enter()
	}

	if bpx.key_was_just_pressed(.Left) ||
	   bpx.key_was_just_pressed(.Right) ||
	   bpx.key_was_just_pressed(.Up) ||
	   bpx.key_was_just_pressed(.Down) {
		gui.sash_collapse(&s._sash)
	}

	return nil
}

screen_splash_draw :: proc(s: Screen_Splash) {
	bpxd.rect_filled({0, 0}, g.SCREEN_SIZE, g.COLOR_BG_MODE_NORMAL)
	gui.sash_draw(s._sash)
}
