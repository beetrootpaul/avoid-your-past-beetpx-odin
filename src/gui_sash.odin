package main

import "beetpx:bpx"

@(private = "file")
_TTL_COLLAPSE_START :: MUSIC_BEAT_FRAMES / 4

@(private = "file")
_H_MAX :: 30

Sash :: struct {
	ttl                : int,
	ttl_expansion_start: int,
	ttl_expansion_end  : int,
}

sash_make :: proc(duration: int, expand: bool) -> Sash {
	expansion_start := duration
	expansion_end := duration
	if expand {
		expansion_start = duration - MUSIC_BEAT_FRAMES
		expansion_end = expansion_start - MUSIC_BEAT_FRAMES / 4
	}
	return {
		ttl                 = duration,
		ttl_expansion_start = expansion_start,
		ttl_expansion_end   = expansion_end,
	}
}

sash_has_collapsed :: proc(s: Sash) -> bool {
	return s.ttl <= 0
}

sash_update :: proc(s: ^Sash) {
	s.ttl -= 1
}

sash_draw :: proc(s: Sash) {
	h: f64
	if s.ttl > s.ttl_expansion_start {
		h = 0
	} else if s.ttl > s.ttl_expansion_end {
		h =
			_H_MAX *
			f64(s.ttl_expansion_start - s.ttl) /
			f64(s.ttl_expansion_start - s.ttl_expansion_end)
	} else if s.ttl > _TTL_COLLAPSE_START {
		h = _H_MAX
	} else {
		h = _H_MAX * f64(s.ttl) / _TTL_COLLAPSE_START
	}

	if h > 0 {
		bpx.d_rect_filled(
			{0, SCREEN_SIZE.y / 2 - h / 2},
			{SCREEN_SIZE.x, h},
			bpx.p_pico8_moss,
		)
	}
}
