package ayp

import "./gui"

Screen_Start :: struct {}

screen_start_enter :: proc() -> Screen_Start {
	return {}
}

screen_start_update :: proc() -> Maybe(Screen) {
	return nil
}

screen_start_draw :: proc() {
	level_draw_bg()
	level_draw_items()
	player_draw()
	gui.topbar_draw()
}
