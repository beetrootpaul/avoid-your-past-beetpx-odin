// TODO: Consider making it `sash` package instead, to keep things isolated and
//       re-usable.
package ayp_gui

import "../g"
import "beetpx:bpx"
import "beetpx:bpxd"

@(private = "file")
_H_MAX :: 30.0

Sash :: struct {
	_timer: bpx.Timer,
}

sash_make :: proc(duration: u32) -> Sash {
	return {
		_timer = bpx.timer_make(duration),
	}
}

sash_has_collapsed :: proc(s: Sash) -> bool {
	return bpx.timer_has_finished(s._timer)
}

sash_draw :: proc(s: Sash) {
	if bpx.timer_has_finished(s._timer) do return
	bpxd.rect_filled(
		{0, g.SCREEN_SIZE.y / 2 - _H_MAX / 2},
		{g.SCREEN_SIZE.x, _H_MAX},
		bpx.p_pico8_moss,
	)
}
