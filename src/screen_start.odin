package ayp

import "./g"
import "./gameplay"
import "./gui"
import "beetpx:bpx"
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

	_draw_prompt(s._player)
}

@(private = "file")
_draw_prompt :: proc(player: gameplay.Player) {
	margin :: 6
	xy_min := g.GAME_AREA_XY + gameplay.player_xy_min(player)
	xy_max := g.GAME_AREA_XY + gameplay.player_xy_max(player)
	center := (xy_min + xy_max) / 2

	prompt_1 := "press an arrow"
	prompt_2 := "to choose direction"
	prompt_1_wh := bpxd.text_measure(prompt_1)
	prompt_2_wh := bpxd.text_measure(prompt_2)
	gui.text_with_outline(
		prompt_1,
		{center.x - prompt_1_wh.x / 2, xy_min.y - margin - 26},
		bpx.p_pico8_dusk,
		bpx.p_pico8_storm,
	)
	gui.text_with_outline(
		prompt_2,
		{center.x - prompt_2_wh.x / 2, xy_min.y - margin - 17},
		bpx.p_pico8_dusk,
		bpx.p_pico8_storm,
	)

	// Blinks to the music's beat.
	is_highlighted :=
		bpx.frame_number() % (2 * g.MUSIC_BEAT_FRAMES) < g.MUSIC_BEAT_FRAMES
	arrow_color := is_highlighted ? bpx.p_pico8_sky : bpx.p_pico8_dusk
	gui.text_with_outline(
		"⬅",
		{xy_min.x - margin - 8, center.y - 2},
		arrow_color,
		bpx.p_pico8_storm,
	)
	gui.text_with_outline(
		"➡",
		{xy_max.x + margin + 2, center.y - 2},
		arrow_color,
		bpx.p_pico8_storm,
	)
	gui.text_with_outline(
		"⬆",
		{center.x - 3, xy_min.y - margin - 6},
		arrow_color,
		bpx.p_pico8_storm,
	)
	gui.text_with_outline(
		"⬇",
		{center.x - 3, xy_max.y + margin + 2},
		arrow_color,
		bpx.p_pico8_storm,
	)
}
