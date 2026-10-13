package ayp

import "./g"
import "./gameplay"
import "beetpx:bpxd"

Screen_Start :: struct {
	_player: gameplay.Player,
	_level : gameplay.Level,
}

screen_start_enter :: proc() -> Screen_Start {
	s := Screen_Start {
		_player = gameplay.player_make(),
	}
	gameplay.level_spawn_items(&s._level, s._player)
	return s
}

screen_start_update :: proc() -> Maybe(Screen) {
	return nil
}

screen_start_draw :: proc(s: Screen_Start) {
	bpxd.rect_filled(g.GAME_AREA_XY, g.GAME_AREA_SIZE, g.COLOR_BG_MODE_NORMAL)
	gameplay.level_draw_items(s._level)
	gameplay.player_draw(s._player)
}
