tool
extends Node2D

export var color: Color setget set_color
export var energy: float = 1.0 setget set_energy

const MAX_FREQ: float = 20_000.0
var vel: float = 0.0
var spectrum: AudioEffectInstance

func set_color(new_color: Color) -> void:
	color = new_color
	$CircleLight.color = color

func set_energy(new_energy: float) -> void:
	energy = clamp(new_energy, 1, 15)
	$CircleLight.energy = energy

func _ready():
	spectrum = AudioServer.get_bus_effect_instance(0, 0)

func _process(_delta):
	if not spectrum: return
	var magnitude = spectrum.get_magnitude_for_frequency_range(0.0, MAX_FREQ).length()
	vel = smoothstep(vel, magnitude, 0.27)
	set_energy(vel * 2)
