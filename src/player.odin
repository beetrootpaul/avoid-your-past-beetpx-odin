package ayp

import "./g"
import "beetpx:bpx"
import "beetpx:bpxd"

Player :: struct {
	// TODO: Keep these fields prefixed with `_`? When not to prefix? When to
	//       have a dedicated `foo_make` proc?
	_xy: bpx.Xy,
	_r : int,
}

player_make :: proc() -> Player {
	return {
		_xy = g.GAME_AREA_WH / 2,
		_r  = 3,
	}
}

player_draw :: proc(p: Player) {
	// TODO: Is this `f64(…)` an idiomatic way to get this expression compile?
	bpxd.sprite(p._xy - f64(p._r), bpx.Sprite {
		image_path = g.ASSETS_SPRITESHEET,
		xy         = {8, 2} * g.ASSETS_SPRITESHEET_CELL_WH,
		wh         = g.ASSETS_SPRITESHEET_CELL_WH,
	})
}
