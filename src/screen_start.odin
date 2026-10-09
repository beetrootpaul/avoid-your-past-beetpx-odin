package main

import "beetpx:bpx"

Start :: struct {}

start_enter :: proc() -> Start {
	return {}
}

start_draw :: proc(s: Start) {
	bpx.d_rect_filled(GAME_AREA_XY, GAME_AREA_SIZE, BG_COLOR_MODE_NORMAL)
}
