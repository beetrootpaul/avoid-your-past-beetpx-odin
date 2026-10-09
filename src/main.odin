package main

import "beetpx:bpx"
import "beetpx:bpxd"

MAX_R :: 255
SPEED :: 4

color: bpx.Rgb = {0, 128, 128}

main :: proc() {
	bpx.set_on_update(on_update)
	bpx.set_on_draw(on_draw)
	bpx.start(canvas_size = .Square_128, tick_rate = .Hz_30)
}

on_update :: proc() {
}

on_draw :: proc() {
	bpxd.clear_canvas(bpx.p_pico8_black)
}
