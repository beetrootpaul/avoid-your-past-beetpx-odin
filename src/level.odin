package ayp

import "./g"
import "beetpx:bpxd"

level_draw_bg :: proc() {
	bpxd.rect_filled(g.GAME_AREA_XY, g.GAME_AREA_WH, mode_bg_color())
}

level_draw_items :: proc() {
	// TODO: Do something here or remove the proc.
}
