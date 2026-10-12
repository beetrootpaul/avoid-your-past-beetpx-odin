package ayp

import "./g"
import "./gameplay"
import "beetpx:bpxd"

Screen_Start :: struct {
	_player: gameplay.Player,
}

screen_start_enter :: proc() -> Screen_Start {
	return {_player = gameplay.player_make()}
}

screen_start_update :: proc() -> Maybe(Screen) {
	return nil
}

screen_start_draw :: proc(s: Screen_Start) {
	bpxd.rect_filled(g.GAME_AREA_XY, g.GAME_AREA_SIZE, g.COLOR_BG_MODE_NORMAL)
	gameplay.player_draw(s._player)
}
