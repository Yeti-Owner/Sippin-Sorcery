extends Node3D

@export var Showcase:bool = false
var ShowcaseStage:int = 0

@onready var WorldSun := $Sun
@onready var SpawnerAmt:float = get_parent().get_node("Spawner").Num
@onready var MinistryAmt:float = get_parent().get_node("Spawner").MinistryNum
@onready var Boss:float = get_parent().get_node("Spawner").BossSpawn
@onready var EnvironmentSky = $Environment.environment.sky.sky_material # .get_shader_parameter("top_color")
const bright_top := Color(0.34901961684227, 0.58823531866074, 1)
const bright_bottom := Color(0, 0.32941177487373, 0.96862745285034)
const bright_scatter := Color(0.32915836572647, 0.32915839552879, 0.32915836572647)

const dark_top := Color(0, 0.07843137532473, 0.24313725531101)#Color(0.10588235408068, 0.14509804546833, 0.4745098054409) 
const dark_bottom := Color(0, 0, 0)#Color(0.09019608050585, 0.07058823853731, 0.27843138575554)
const dark_scatter := Color(0.12156862765551, 0.12156862765551, 0.20000000298023)#Color(0.15487596392632, 0.15487599372864, 0.15487590432167)

var FinalPosition:int = -160

var RotationSteps:float
var StepAmt:float = 0
var TweenValue:float = -10 # Start position of the Sun's X

# in ready it does slight tween from set position to whatever the "first" one is

func _ready():
	if Showcase:
		_showcase()
		return
	
	# Emitted every time a customer/minister/boss reaches the end of the path
	EventBus.connect("CustomerDone", _next_stage)
	
	# Get value of "steps" to reach "FinalPosition"
	# the steps is just customers + ministers + boss
	RotationSteps = FinalPosition/(SpawnerAmt + MinistryAmt + clamp(Boss, 0, 1))
	
	_set_color()

# Depreciated, don't use
func _showcase():
	ShowcaseStage = wrap(ShowcaseStage + 1, 1, 4)
	match ShowcaseStage:
		1:
			var tween := get_tree().create_tween()
			tween.tween_property(WorldSun, "rotation_degrees", Vector3(-90, -16.3, 0), 10)
			tween.tween_callback(_showcase)
			
			EnvironmentSky.set_shader_parameter("top_color", dark_top)
			var tween2 := get_tree().create_tween()
			tween2.tween_method(func(it): EnvironmentSky.set_shader_parameter("top_color", it), dark_top, bright_top, 10)
			
			EnvironmentSky.set_shader_parameter("bottom_color", dark_bottom)
			var tween3 := get_tree().create_tween()
			tween3.tween_method(func(it): EnvironmentSky.set_shader_parameter("bottom_color", it), dark_bottom, bright_bottom, 10)
			
			EnvironmentSky.set_shader_parameter("sun_scatter", dark_scatter)
			var tween4 := get_tree().create_tween()
			tween4.tween_method(func(it): EnvironmentSky.set_shader_parameter("sun_scatter", it), dark_scatter, bright_scatter, 10)
			
		2:
			var tween := get_tree().create_tween()
			tween.tween_property(WorldSun, "rotation_degrees", Vector3(-170, -16.3, 0), 10)
			tween.tween_callback(_showcase)
			
			EnvironmentSky.set_shader_parameter("top_color", bright_top)
			var tween2 := get_tree().create_tween()
			tween2.tween_method(func(it): EnvironmentSky.set_shader_parameter("top_color", it), bright_top, dark_top, 10)
			
			EnvironmentSky.set_shader_parameter("bottom_color", bright_bottom)
			var tween3 := get_tree().create_tween()
			tween3.tween_method(func(it): EnvironmentSky.set_shader_parameter("bottom_color", it), bright_bottom, dark_bottom, 10)
			
			EnvironmentSky.set_shader_parameter("sun_scatter", bright_scatter)
			var tween4 := get_tree().create_tween()
			tween4.tween_method(func(it): EnvironmentSky.set_shader_parameter("sun_scatter", it), bright_scatter, dark_scatter, 10)
			
		3:
			WorldSun.rotation_degrees = Vector3(0, -16.3, 0)
			var tween := get_tree().create_tween()
			
			EnvironmentSky.set_shader_parameter("top_color", dark_top)
			EnvironmentSky.set_shader_parameter("bottom_color", dark_bottom)
			EnvironmentSky.set_shader_parameter("sun_scatter", dark_scatter)
			
			tween.tween_property(WorldSun, "rotation_degrees", Vector3(-10, -16.3, 0), 5)
			tween.tween_callback(_showcase)
	

func _set_rotation(deg):
	TweenValue = (-10 + deg) # X value used for tween
	
	var tween := get_tree().create_tween()
	# Only the X value is rotated
	tween.tween_property(WorldSun, "rotation_degrees", Vector3(TweenValue, -16.3, 0), 10)
	
	
	_set_color()
	
	# Check if done basically
	if deg == FinalPosition:
		tween.tween_callback(fin)
 
func fin():
	# Emits signal recieved by Clock to allow player to end day
	EventBus.emit_signal("DayDone")

func _next_stage():
	# StepAmt increments the "RotationSteps" 
	# +1 at the end of each customer/minister/boss
	StepAmt += 1

	# calculate the next degrees
	var d:float = RotationSteps * StepAmt
	_set_rotation(d)

# There is prob a better way but I just do NOT want to work on this anymore
func _set_color():
	# Finds if x is closer to 0 or -180
	if floor(abs(TweenValue) / 90.0) == 1: # floor division
		var tween := get_tree().create_tween()
		tween.set_parallel(true)
		
		# get ratio for where between -90 and -180 it is
		var Ratio:float = (float(TweenValue + 90) / -90.0)
		# As Ratio increases there is more of dark_top and less of bright_top
		var NewTopColor := (dark_top * Ratio) + (bright_top * (1 - Ratio))
		var OldTopColor = EnvironmentSky.get_shader_parameter("top_color")
		tween.tween_method(func(it): EnvironmentSky.set_shader_parameter("top_color", it), OldTopColor, NewTopColor, 10)
		
		var NewBottomColor := (dark_bottom * Ratio) + (bright_bottom * (1 - Ratio))
		var OldBottomColor = EnvironmentSky.get_shader_parameter("bottom_color")
		tween.tween_method(func(it2): EnvironmentSky.set_shader_parameter("bottom_color", it2), OldBottomColor, NewBottomColor, 10)
		
		var NewScatter := (dark_scatter * Ratio) + (bright_scatter * (1 - Ratio))
		var OldScatter = EnvironmentSky.get_shader_parameter("sun_scatter")
		tween.tween_method(func(it3): EnvironmentSky.set_shader_parameter("sun_scatter", it3), OldScatter, NewScatter, 10)
		
	else: # closer to 0 aka start
		# Basically repeats code above but slightly backwards
		var tween := get_tree().create_tween()
		tween.set_parallel(true)
		
		
		# Same as above but don't need to offset by 90
		var Ratio:float = abs(float(TweenValue) / -90.0)
		
		# As Ratio increases there is more of bright_top and less of dark_top
		var NewTopColor := (bright_top * Ratio) + (dark_top * (1 - Ratio))
		var OldTopColor = EnvironmentSky.get_shader_parameter("top_color")
		tween.tween_method(func(it): EnvironmentSky.set_shader_parameter("top_color", it), OldTopColor, NewTopColor, 10)
		
		var NewBottomColor := (bright_bottom * Ratio) + (dark_bottom * (1 - Ratio))
		var OldBottomColor = EnvironmentSky.get_shader_parameter("bottom_color")
		tween.tween_method(func(it2): EnvironmentSky.set_shader_parameter("bottom_color", it2), OldBottomColor, NewBottomColor, 10)
		
		
		var NewScatter := (bright_scatter * Ratio) + (dark_scatter * (1 - Ratio))
		var OldScatter = EnvironmentSky.get_shader_parameter("sun_scatter")
		tween.tween_method(func(it3): EnvironmentSky.set_shader_parameter("sun_scatter", it3), OldScatter, NewScatter, 10)

