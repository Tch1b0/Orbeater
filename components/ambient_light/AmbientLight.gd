extends Node2D

const MAX_FREQ: float = 20_000.0

var spectrum: AudioEffectSpectrumAnalyzerInstance
var vel: float = 0.0

func _ready():
	spectrum = AudioServer.get_bus_effect_instance(0, 0)

func _process(_delta):
	if Global.game_paused: return
	var magnitude = spectrum.get_magnitude_for_frequency_range(0.0, MAX_FREQ).length()
	vel = smoothstep(vel, magnitude, 0.265)
	$Light2D.energy = min(vel * 2, 15)
