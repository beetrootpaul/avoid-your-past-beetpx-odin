package ayp_gameplay

import "../g"
import "beetpx:bpx"
import "core:math"
import "core:math/rand"

@(private = "file")
_TILES :: bpx.Xy {
	g.GAME_AREA_SIZE.x / g.TILE_SIZE.x,
	g.GAME_AREA_SIZE.y / g.TILE_SIZE.y,
}

@(private = "file")
@(rodata)
_coin_xys := [16]bpx.Xy {
	{0, 8},
	{8, 8},
	{16, 8},
	{24, 8},
	{32, 8},
	{40, 8},
	{48, 8},
	{56, 8},
	{64, 8},
	{72, 8},
	{80, 8},
	{88, 8},
	{96, 8},
	{104, 8},
	{112, 8},
	{120, 8},
}

@(private = "file")
@(rodata)
_droplet_no_coins_xys := [1]bpx.Xy{{0, 16}}

@(private = "file")
@(rodata)
_droplet_no_memories_xys := [1]bpx.Xy{{0, 24}}

Level :: struct {
	_coin               : Maybe(Item),
	_droplet_no_coins   : Maybe(Item),
	_droplet_no_memories: Maybe(Item),
}

level_spawn_items :: proc(l: ^Level, player: Player) {
	close_tile_min := _tile_at(player_xy_min(player)) - 3
	close_tile_max := _tile_at(player_xy_max(player)) + 3

	available_tiles_buf: [int(_TILES.x * _TILES.y)]bpx.Xy
	available_tiles_len := 0
	margin_tiles :: 1
	for tile_x in 1 + margin_tiles ..= int(_TILES.x) - margin_tiles {
		for tile_y in 1 + margin_tiles ..= int(_TILES.y) - margin_tiles {
			tile := bpx.Xy{f64(tile_x), f64(tile_y)}
			is_close_to_player :=
				close_tile_min.x <= tile.x &&
				tile.x <= close_tile_max.x &&
				close_tile_min.y <= tile.y &&
				tile.y <= close_tile_max.y
			if is_close_to_player do continue
			available_tiles_buf[available_tiles_len] = tile
			available_tiles_len += 1
		}
	}
	available_tiles := available_tiles_buf[:available_tiles_len]

	if len(available_tiles) > 0 {
		i := rand.int_max(len(available_tiles))
		l._coin = item_make(
			available_tiles[i],
			bpx.animated_sprite_make(
				&g.spritesheet,
				_coin_xys[:],
				g.SPRITE_SHEET_CELL_SIZE,
				frame_duration = 2,
			),
		)
		// Remove the coin's tile, by swapping it with the last one.
		available_tiles[i] = available_tiles[len(available_tiles) - 1]
		available_tiles = available_tiles[:len(available_tiles) - 1]
	}

	// TODO: Spawn no droplets in the "no coins" and "no memories" modes, once
	//       the modes are ported.
	if l._droplet_no_coins == nil &&
	   l._droplet_no_memories == nil &&
	   len(available_tiles) > 0 {
		tile := rand.choice(available_tiles)
		probability := rand.float64()
		if probability < 0.3 {
			l._droplet_no_coins = item_make(
				tile,
				bpx.animated_sprite_make(
					&g.spritesheet,
					_droplet_no_coins_xys[:],
					g.SPRITE_SHEET_CELL_SIZE,
				),
			)
		} else if probability > 0.7 {
			l._droplet_no_memories = item_make(
				tile,
				bpx.animated_sprite_make(
					&g.spritesheet,
					_droplet_no_memories_xys[:],
					g.SPRITE_SHEET_CELL_SIZE,
				),
			)
		}
	}
}

level_draw_items :: proc(l: Level) {
	// TODO: Do not draw the coin in the "no coins" mode, once the modes are
	//       ported.
	if coin, ok := l._coin.?; ok do item_draw(coin)
	if droplet, ok := l._droplet_no_coins.?; ok do item_draw(droplet)
	if droplet, ok := l._droplet_no_memories.?; ok do item_draw(droplet)
}

// Returns the tile at `xy`. Tiles are numbered from 1.
@(private = "file")
_tile_at :: proc(xy: bpx.Xy) -> bpx.Xy {
	return {
		math.floor(xy.x / g.TILE_SIZE.x) + 1,
		math.floor(xy.y / g.TILE_SIZE.y) + 1,
	}
}
