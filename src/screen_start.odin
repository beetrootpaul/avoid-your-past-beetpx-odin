package ayp

import "./gui"

Screen_Start :: struct {
	_player: Player,
}

screen_start_enter :: proc() -> Screen_Start {
	return {
		_player = player_make(),
	}
}

screen_start_tick :: proc() -> Maybe(Screen) {
	return nil
}

screen_start_draw :: proc(s: Screen_Start) {
	level_draw_bg()
	level_draw_items()
	player_draw(s._player)
	gui.topbar_draw()
}
