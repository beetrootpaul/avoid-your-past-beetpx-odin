package ayp_gui

import "../g"
import "beetpx:bpx"
import "beetpx:bpxd"

@(private = "file")
_H_MAX :: 30.0

Sash :: struct {
	_ttl: int,
}

sash_make :: proc(duration: int) -> Sash {
	return {
		_ttl = duration,
	}
}

sash_update :: proc(s: ^Sash) {
	s._ttl -= 1
}

sash_has_collapsed :: proc(s: Sash) -> bool {
	return s._ttl <= 0
}

sash_draw :: proc() {
	bpxd.rect_filled(
		{0, g.SCREEN_SIZE.y / 2 - _H_MAX / 2},
		{g.SCREEN_SIZE.x, _H_MAX},
		bpx.p_pico8_moss,
	)
}
