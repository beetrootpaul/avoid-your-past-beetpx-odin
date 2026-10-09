package main

import "beetpx:bpx"

Screen :: union {
	Splash,
	Start,
}

screen: Screen

main :: proc() {
	screen = splash_enter()

	bpx.set_on_update(on_update)
	bpx.set_on_draw(on_draw)
	bpx.start(canvas_size = .Square_128, tick_rate = .Hz_30)
}

on_update :: proc() {
	next: Screen

	switch &s in screen {
	case Splash:
		if splash_update(&s) do next = start_enter()
	case Start:
	}

	if next != nil do screen = next
}

on_draw :: proc() {
	bpx.d_clear_canvas(bpx.p_pico8_black)

	switch s in screen {
	case Splash:
		splash_draw(s)
	case Start:
		start_draw(s)
	}
}
