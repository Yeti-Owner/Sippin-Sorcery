extends Path3D

@export_category("Customer Spawning")
@export var Num:int = 1
@export_enum("Tutorial:0","Basic:1","Medium:2","Hard:3") var List:int

@export_category("Ministry Spawning")
@export var MinistryNum:int = 0

@export_category("Boss Spawning")
@export_enum("None:-1","Tom:0", "Humphrey:1", "Monkey:2","Garfield:3") var BossSpawn:int = -1

@onready var timer := $MiscTimer
const Customer := preload("res://scenes/customer.tscn")
const MinistryAgent := preload("res://scenes/ministry_agent.tscn")
const HealthInspector := preload("res://scenes/health_inspector.tscn") # Boss

const CustomerLists := {
	0: TutorialCustomers,
	1: BasicCustomers,
	2: MediumCustomers,
	3: HardCustomers
}
const TutorialCustomers := ["Ben", "Mary", "Emma", "Charles", "Krystal", "Jokez", "Hunter", "Dalidoah"]
const BasicCustomers := ["Ben", "Charles", "Reeseman5", "Artemis", "Emma", "Mary", "Krystal", "Krystal2", "Jokez", "Imoorzy", "Noto", "Hunter", "Formag", "Kuspy", "45Glockz", "Deathrow", "Carlito", "Sly", "sselemoh", "Nevaa", "Dalidoah", "Vrile", "Yurei", "Eivan", "Keta", "Flueve", "soap", "CptLegend", "Reibean", "Teethbat", "KSS", "Whatmaster", "Proccessing", "Blackout","Bruhgby"]
const MediumCustomers := ["Jokez", "High", "Kaze", "Imoorzy", "Noto", "NanoCup", "Formag", "Kuspy", "45Glockz", "Moriarty", "Moriarty2", "Carlito2", "Ufrz", "Nevaa", "Reeseman5", "MrInfernal", "Kangaroo_Knight", "Iconography", "BurgerkingCandycrush", "BaronDipitous", "Eivan2", "CptLegend", "April", "Benzeenee10", "Jammi", "Kyubi", "JinBoi"]
const HardCustomers := ["Slight", "Breo", "Skup", "Snipes", "Orion", "TCArk", "Leah", "Iconography", "Eidolonic", "BedHeadNinja", "Strabster"]
var Spawned := []

func _ready():
	randomize()

func _start():
	timer.wait_time = randi_range(5, 8)
	timer.start()

func _on_misc_timer_timeout():
	_spawn()

func _spawn():
	# Priority: 1 in 3 chance of spawning ministry if exists otherwise spawning customers
	# until there are no more spawns then spawns ministry if any left over then 
	# boss if a boss is selected 
	if Num == 0:
		if MinistryNum != 0:
			_spawn_ministry()
		
		if (BossSpawn != -1) and (EventBus.ActiveCustomers == 0):
			_spawn_boss()
		elif BossSpawn != -1:
			timer.wait_time = randi_range(10, 20)
			timer.start()
	else:
		var RNG := (randi() % 3)
		if (RNG == 0) and (MinistryNum != 0):
			_spawn_ministry()
		else:
			_spawn_customer()

func _spawn_customer():
	# 1 in 3 chance to select from different (lower) difficulty
	var CustomerRes:String
	var level:int
	
	var RNG := randi() % 3
	if RNG == 0:
		match List:
			0:
				level = List
			1:
				level = List
			2:
				level = (randi() % 2 + 1)
			3:
				level = (randi() % 3 + 1)
	else:
		level = List
	
	CustomerRes = str("res://characters/" + str(CustomerLists[level][randi() % CustomerLists[List].size()]) + ".tres")
	
	if Spawned.has(CustomerRes):
		_spawn_customer()
		return
	else:
		Spawned.append(CustomerRes)
	
	var c = Customer.instantiate()
	c.Info = load(CustomerRes)
	add_child(c)
	
	Num -= 1
	timer.wait_time = randi_range(10, 20)
	timer.start()

func _spawn_ministry():
	MinistryNum -= 1
	var m = MinistryAgent.instantiate()
	add_child(m)
	
	timer.wait_time = randi_range(10, 20)
	timer.start()

func _spawn_boss():
	# Spawn boss
	var b = HealthInspector.instantiate()
	add_child(b)
	
	return
#	BossSpawn = -1
#	# technically last thing spawned so can prolly remove this code?
#	timer.wait_time = randi_range(10, 20)
#	timer.start()
