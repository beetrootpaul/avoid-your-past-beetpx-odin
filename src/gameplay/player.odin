package ayp_gameplay

import "../g"
import "beetpx:bpx"
import "beetpx:bpxd"

Direction :: enum {
	Up,
	Right,
	Down,
	Left,
}

@(private = "file")
_R :: 3.0

@(private = "file")
@(rodata)
_sprite_cell_for_direction := [Direction]bpx.Xy {
	.Up    = {7, 2},
	.Right = {8, 2},
	.Down  = {9, 2},
	.Left  = {10, 2},
}

Player :: struct {
	_xy       : bpx.Xy,
	_direction: Direction,
}

player_make :: proc() -> Player {
	return {
		_xy        = g.GAME_AREA_SIZE / 2,
		// Effectively unused, since the user chooses the direction at the
		// game's start.
		_direction = .Right,
	}
}

player_draw :: proc(p: Player) {
	sprite_cell := _sprite_cell_for_direction[p._direction]
	bpxd.sprite(
		bpx.sprite_make(
			&g.spritesheet,
			sprite_cell * g.SPRITE_SHEET_CELL_SIZE,
			g.SPRITE_SHEET_CELL_SIZE,
		),
		g.GAME_AREA_XY + p._xy - _R,
	)
}
