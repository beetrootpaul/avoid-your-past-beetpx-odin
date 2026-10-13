package ayp

import "./g"
import "./gui"
import "beetpx:bpx"
import "beetpx:bpxd"

Screen_Splash :: struct {
	_sash: gui.Sash,
}

screen_splash_enter :: proc() -> Screen_Splash {
	return {
		_sash = gui.sash_make(8 * g.MUSIC_BEAT_FRAMES),
	}
}

screen_splash_update :: proc(s: ^Screen_Splash) -> Maybe(Screen) {
	if gui.sash_has_collapsed(s._sash) {
		return screen_start_enter()
	}
	return nil
}

screen_splash_draw :: proc(s: Screen_Splash) {
	bpxd.rect_filled({0, 0}, g.SCREEN_SIZE, g.COLOR_BG_MODE_NORMAL)
	gui.sash_draw(s._sash)

	if !gui.sash_has_collapsed(s._sash) {
		center := g.SCREEN_SIZE / 2
		title := "Avoid Your Past"
		title_wh := bpxd.text_measure(title)
		author := "by @beetrootpaul"
		author_wh := bpxd.text_measure(author)
		gui.text_with_outline(
			title,
			center + {-title_wh.x / 2, -author_wh.y - 3},
			bpx.p_pico8_pink,
			bpx.p_pico8_black,
		)
		bpxd.text(author, center + {-author_wh.x / 2, 2}, bpx.p_pico8_white)
	}
}
