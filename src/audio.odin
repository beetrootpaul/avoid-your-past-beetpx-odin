package ayp

import "beetpx:bpx"

audio_clips: struct {
	music_base            : bpx.Audio_Clip,
	music_melody          : bpx.Audio_Clip,
	music_mode_no_coins   : bpx.Audio_Clip,
	music_mode_no_memories: bpx.Audio_Clip,
}

sounds: struct {
	melody          : bpx.Sound,
	mode_no_coins   : bpx.Sound,
	mode_no_memories: bpx.Sound,
}

audio_clips_load :: proc() {
	audio_clips.music_base = bpx.audio_clip_from_wav(
		#load("../assets/music_base.wav"),
	)
	audio_clips.music_melody = bpx.audio_clip_from_wav(
		#load("../assets/music_melody.wav"),
	)
	audio_clips.music_mode_no_coins = bpx.audio_clip_from_wav(
		#load("../assets/mode_no_coins.wav"),
	)
	audio_clips.music_mode_no_memories = bpx.audio_clip_from_wav(
		#load("../assets/mode_no_memories.wav"),
	)
}
