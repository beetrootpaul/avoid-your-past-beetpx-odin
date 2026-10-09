package main

import "beetpx:bpx"

SCREEN_SIZE    :: bpx.Xy{128, 128}
GAME_AREA_SIZE :: bpx.Xy{128, 112}
// TODO: Replace with a camera offset, once BeetPx has a camera.
GAME_AREA_XY :: bpx.Xy{0, 16}

MUSIC_BEAT_FRAMES :: 16

BG_COLOR_MODE_NORMAL :: bpx.p_pico8_storm
