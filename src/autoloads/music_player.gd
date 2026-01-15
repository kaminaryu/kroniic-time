extends Node

const MUSICS: Dictionary[String, AudioStream] = {
    "MainMenu": preload("res://audios/musics/WaterLevelMusic.mp3"),
    "Gameplay": preload("res://audios/musics/ActionMan.mp3"),
    "Gameplay2": preload("res://audios/musics/BattleMan.mp3"),
    "TimesOut": preload("res://audios/SFX/TIMES_OUT.mp3")
}

var current_music_name: String = ""
var music_playing: AudioStreamPlayer

func _ready() -> void:
    randomize()

func play_music(music_name: String) -> void:
    if music_name == current_music_name:
        return

    current_music_name = music_name

    if music_playing:
        music_playing.queue_free()

    var stream: AudioStream

    if music_name == "Gameplay":
        stream = MUSICS[
            "Gameplay" if randi_range(0, 1) == 1 else "Gameplay2"
        ]
    else:
        if not MUSICS.has(music_name):
            push_warning("Music not found: %s" % music_name)
            return
        stream = MUSICS[music_name]

    music_playing = AudioStreamPlayer.new()
    music_playing.stream = stream
    music_playing.bus = "Music"

    add_child(music_playing)
    music_playing.play()
