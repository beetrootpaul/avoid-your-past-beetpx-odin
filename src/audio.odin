package ayp

import "beetpx:bpx"

sounds: struct {
	music_base            : bpx.Sound,
	music_melody          : bpx.Sound,
	music_mode_no_coins   : bpx.Sound,
	music_mode_no_memories: bpx.Sound,
}

playback_ids: struct {
	melody          : bpx.Audio_Playback_Id,
	mode_no_coins   : bpx.Audio_Playback_Id,
	mode_no_memories: bpx.Audio_Playback_Id,
}

sounds_load :: proc() {
	sounds.music_base = bpx.sound_from_wav(#load("../assets/music_base.wav"))
	sounds.music_melody = bpx.sound_from_wav(
		#load("../assets/music_melody.wav"),
	)
	sounds.music_mode_no_coins = bpx.sound_from_wav(
		#load("../assets/mode_no_coins.wav"),
	)
	sounds.music_mode_no_memories = bpx.sound_from_wav(
		#load("../assets/mode_no_memories.wav"),
	)
}
