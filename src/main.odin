package ayp

import "beetpx:bpx"
import "beetpx:bpxd"

@(private = "file")
_curr_screen: Screen

main :: proc() {
	_curr_screen = screen_splash_enter()

	bpx.set_on_update(_on_update)
	bpx.set_on_draw(_on_draw)
	bpx.start(canvas_size = .Square_128, tick_rate = .Hz_30)
}

@(private = "file")
_on_update :: proc() {
	next_screen: Maybe(Screen)
	switch &s in _curr_screen {
	case Screen_Splash:
		next_screen = screen_splash_update(&s)
	case Screen_Start:
		next_screen = screen_start_update()
	}
	_curr_screen = next_screen.? or_else _curr_screen
}

@(private = "file")
_on_draw :: proc() {
	bpxd.clear_canvas(bpx.p_pico8_black)

	switch s in _curr_screen {
	case Screen_Splash:
		screen_splash_draw(s)
	case Screen_Start:
		screen_start_draw()
	}
}
