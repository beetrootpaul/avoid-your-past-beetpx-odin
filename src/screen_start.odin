package ayp

import "./g"
import "beetpx:bpxd"

Screen_Start :: struct {}

screen_start_enter :: proc() -> Screen_Start {
	return {}
}

screen_start_draw :: proc() {
	bpxd.rect_filled(g.GAME_AREA_XY, g.GAME_AREA_SIZE, g.COLOR_BG_MODE_NORMAL)
}
