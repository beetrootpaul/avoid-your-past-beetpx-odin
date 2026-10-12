package ayp

import "./g"
import "beetpx:bpx"
import "beetpx:bpxd"

Screen_Start :: struct {}

screen_start_enter :: proc() -> Screen_Start {
	bpx.mute_playback(playback_ids.melody)
	bpx.mute_playback(playback_ids.mode_no_coins)
	bpx.mute_playback(playback_ids.mode_no_memories)

	return {}
}

screen_start_update :: proc() -> Maybe(Screen) {
	return nil
}

screen_start_draw :: proc() {
	bpxd.rect_filled(g.GAME_AREA_XY, g.GAME_AREA_SIZE, g.COLOR_BG_MODE_NORMAL)
}
