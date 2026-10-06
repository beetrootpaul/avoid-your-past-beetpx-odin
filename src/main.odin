package main

import "beetpx:bpx"

MAX_R :: 255
SPEED :: 4

color: bpx.Rgb = {0, 128, 128}

main :: proc() {
	bpx.set_on_update(on_update)
	bpx.set_on_draw(on_draw)
	bpx.start()
}

on_update :: proc() {
	// Change the red channel of the color at a constant speed, from 0 to 255
	// and back to 0, on repeat.
	color.r = u8(bpx.u_ping_pong(int(bpx.frame_number() * SPEED), MAX_R))
}

on_draw :: proc() {
	bpx.d_clear_canvas(color)
}
