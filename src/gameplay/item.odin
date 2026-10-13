package ayp_gameplay

import "../g"
import "beetpx:bpx"
import "beetpx:bpxd"

@(private)
Item :: struct {
	// Tiles are numbered from 1.
	_tile           : bpx.Xy,
	_animated_sprite: bpx.Animated_Sprite,
}

@(private)
item_make :: proc(tile: bpx.Xy, animated_sprite: bpx.Animated_Sprite) -> Item {
	return {_tile = tile, _animated_sprite = animated_sprite}
}

@(private)
item_draw :: proc(item: Item) {
	bpxd.sprite(
		item._animated_sprite,
		g.GAME_AREA_XY + (item._tile - 1) * g.TILE_SIZE,
	)
}
