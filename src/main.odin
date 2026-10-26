package ayp

import "./g"
import "beetpx:bpx"
import "beetpx:bpxd"

State :: struct {
	curr_screen: Screen,
}

main :: proc() {
	bpx.start(
		State,
		canvas_size = .Square_128,
		tick_rate = .Hz_30,
		on_started = _on_started,
		on_tick = _on_tick,
		on_draw = _on_draw,
	)
}

@(private = "file")
_on_started :: proc(s: ^State) {
	bpxd.set_camera_xy(g.CAMERA_XY)
	s.curr_screen = screen_splash_enter()
}

@(private = "file")
_on_tick :: proc(s: ^State) {
	next_screen: Maybe(Screen)
	switch &screen in s.curr_screen {
	case Screen_Splash:
		next_screen = screen_splash_tick(&screen)
	case Screen_Start:
		next_screen = screen_start_tick()
	}
	s.curr_screen = next_screen.? or_else s.curr_screen
}

@(private = "file")
_on_draw :: proc(s: ^State) {
	bpxd.clear_canvas(bpx.p_pico8_black)

	switch screen in s.curr_screen {
	case Screen_Splash:
		screen_splash_draw(screen)
	case Screen_Start:
		screen_start_draw()
	}
}

// TODO: Introduce tracking memory allocator?
