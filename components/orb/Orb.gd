tool
extends Node2D
class_name Orb

export var color: Color setget set_color
export var energy: float = 2.0 setget set_energy
export var display_dot: bool = true setget set_display_dot

const MAX_FREQ: float = 20_000.0
var vel: float = 0.0
var spectrum: AudioEffectInstance

func set_display_dot(new_val: bool) -> void:
	display_dot = new_val
	if display_dot:
		$Sprite.show()
	else:
		$Sprite.hide()

func set_color(new_color: Color) -> void:
	color = new_color
	$CircleLight.color = color

func set_energy(new_energy: float) -> void:
	energy = clamp(new_energy, 2, 20)
	$CircleLight.energy = energy

func explode():
	var particle_material = $CircleParticles.process_material
	$CircleLight.enabled = false
	$Sprite.hide()
	particle_material.initial_velocity = 500.0
	$DeathTimer.start()

func _ready():
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	$CircleParticles.process_material = $CircleParticles.process_material.duplicate()

func _process(_delta):
	if not spectrum: return
	var magnitude = spectrum.get_magnitude_for_frequency_range(0.0, MAX_FREQ).length()
	vel = smoothstep(vel, magnitude, 0.27)
	set_energy(vel * 3)

func _on_Timer_timeout():
	if $CircleParticles.emitting:
		$CircleParticles.emitting = false
		$DeathTimer.start(5)
	else:
		queue_free()
