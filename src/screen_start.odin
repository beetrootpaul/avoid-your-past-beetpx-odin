package ayp

import "./g"
import "beetpx:bpx"
import "beetpx:bpxd"

// The previous screen fades out to black, then this one fades in from black.
@(private = "file")
_FADE_OUT_FRAMES :: g.MUSIC_BEAT_FRAMES
@(private = "file")
_FADE_IN_FRAMES :: g.MUSIC_BEAT_FRAMES
@(private = "file")
_FADE_STEPS :: 4

Screen_Start :: struct {
	_prev_frame : bpxd.Canvas_Snapshot,
	_enter_frame: u32,
}

screen_start_enter :: proc() -> Screen_Start {
	return {
		// Falls back to `context.allocator`. It outlives a single frame, so we
		// delete it ourselves once the fade-out is over.
		_prev_frame  = bpxd.canvas_snapshot(),
		_enter_frame = bpx.frame_number(),
	}
}

screen_start_update :: proc(s: ^Screen_Start) -> Maybe(Screen) {
	if s._prev_frame.pixels != nil &&
	   _frames_since_enter(s^) >= _FADE_OUT_FRAMES {
		bpxd.canvas_snapshot_delete(s._prev_frame)
		s._prev_frame = {}
	}
	return nil
}

screen_start_draw :: proc(s: Screen_Start) {
	f := _frames_since_enter(s)

	if s._prev_frame.pixels != nil {
		_draw_dimmed(s._prev_frame, 1 - f64(f) / _FADE_OUT_FRAMES)
		return
	}

	bpxd.rect_filled(g.GAME_AREA_XY, g.GAME_AREA_SIZE, g.COLOR_BG_MODE_NORMAL)

	f -= _FADE_OUT_FRAMES
	if f < _FADE_IN_FRAMES {
		// Needed for this frame only, so we pass the temp allocator explicitly.
		// It is freed at the end of `_on_draw`.
		curr_frame := bpxd.canvas_snapshot(context.temp_allocator)
		_draw_dimmed(curr_frame, f64(f) / _FADE_IN_FRAMES)
	}
}

@(private = "file")
_frames_since_enter :: proc(s: Screen_Start) -> u32 {
	return bpx.frame_number() - s._enter_frame
}

// Draws the snapshot with its colors scaled by `brightness` (0 to 1), rounded
// down to one of `_FADE_STEPS` steps.
@(private = "file")
_draw_dimmed :: proc(snapshot: bpxd.Canvas_Snapshot, brightness: f64) {
	step := u16(clamp(brightness, 0, 1) * _FADE_STEPS)
	for y in 0 ..< snapshot.size.y {
		for x in 0 ..< snapshot.size.x {
			c := bpxd.canvas_snapshot_get(snapshot, {x, y})
			dimmed := bpx.Rgb {
				u8(u16(c.r) * step / _FADE_STEPS),
				u8(u16(c.g) * step / _FADE_STEPS),
				u8(u16(c.b) * step / _FADE_STEPS),
			}
			bpxd.pixel(x, y, dimmed)
		}
	}
}
