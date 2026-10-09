package ayp

import "./g"
import "./gui"
import "beetpx:bpxd"

Screen_Splash :: struct {
	_sash: gui.Sash,
}

screen_splash_enter :: proc() -> Screen_Splash {
	return {
		_sash = gui.sash_make(8 * g.MUSIC_BEAT_FRAMES),
	}
}

// Returns `true` if it's high time for screen transition.
screen_splash_update :: proc(s: ^Screen_Splash) -> bool {
	if gui.sash_has_collapsed(s._sash) {
		return true
	}
	gui.sash_update(&s._sash)
	return false
}

screen_splash_draw :: proc() {
	bpxd.rect_filled({0, 0}, g.SCREEN_SIZE, g.COLOR_BG_MODE_NORMAL)
	gui.sash_draw()
}
