package ayp_gui

import "beetpx:bpx"
import "beetpx:bpxd"

// TODO: Consider moving it to BeetPx.

// Draws a text with a 1 px outline around it, also on the diagonals.
text_with_outline :: proc(
	text: string,
	xy: bpx.Xy,
	color: bpx.Rgb,
	outline_color: bpx.Rgb,
) {
	for dy in -1 ..= 1 {
		for dx in -1 ..= 1 {
			if dx == 0 && dy == 0 do continue
			bpxd.text(text, xy + {f64(dx), f64(dy)}, outline_color)
		}
	}
	bpxd.text(text, xy, color)
}
