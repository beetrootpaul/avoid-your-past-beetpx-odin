package ayp

import "./g"
import "./gui"
import "beetpx:bpx"
import "beetpx:bpxd"

Screen_Splash :: struct {
	_sash: gui.Sash,
}

screen_splash_enter :: proc() -> Screen_Splash {
	bpx.play_audio_clip_looped(audio_clips.music_base)
	sounds.melody = bpx.play_audio_clip_looped(
		audio_clips.music_melody,
		mute_on_start = true,
	)
	sounds.mode_no_coins = bpx.play_audio_clip_looped(
		audio_clips.music_mode_no_coins,
		mute_on_start = true,
	)
	sounds.mode_no_memories = bpx.play_audio_clip_looped(
		audio_clips.music_mode_no_memories,
		mute_on_start = true,
	)

	return {
		_sash = gui.sash_make(8 * g.MUSIC_BEAT_FRAMES),
	}
}

screen_splash_update :: proc(s: ^Screen_Splash) -> Maybe(Screen) {
	if gui.sash_has_collapsed(s._sash) {
		return screen_start_enter()
	}
	return nil
}

screen_splash_draw :: proc(s: Screen_Splash) {
	bpxd.rect_filled({0, 0}, g.SCREEN_SIZE, g.COLOR_BG_MODE_NORMAL)
	gui.sash_draw(s._sash)
}
