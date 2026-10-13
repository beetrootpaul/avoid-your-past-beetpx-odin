package ayp

import "beetpx:bpx"
import "beetpx:bpxd"

@(private = "file")
_State :: struct {
	curr_screen: Screen,
}

main :: proc() {
	bpx.start(
		_State,
		canvas_size = .Square_128,
		tick_rate = .Hz_30,
		on_started = _on_started,
		on_update = _on_update,
		on_draw = _on_draw,
	)
}

@(private = "file")
_on_started :: proc(state: ^_State) {
	state.curr_screen = screen_splash_enter()
}

@(private = "file")
_on_update :: proc(state: ^_State) {
	next_screen: Maybe(Screen)
	switch &s in state.curr_screen {
	case Screen_Splash:
		next_screen = screen_splash_update(&s)
	case Screen_Start:
		next_screen = screen_start_update()
	}
	state.curr_screen = next_screen.? or_else state.curr_screen
}

@(private = "file")
_on_draw :: proc(state: ^_State) {
	bpxd.clear_canvas(bpx.p_pico8_black)

	switch s in state.curr_screen {
	case Screen_Splash:
		screen_splash_draw(s)
	case Screen_Start:
		screen_start_draw()
	}
}

// TODO: Introduce tracking memory allocator?
