extends Path3D

@export_category("Customer Spawning")
@export var Num:int = 1
@export_enum("Tutorial:0","Tier 1:1","Tier 2:2","Tier 3:3","Tier 4:4") var List:int

@export_category("Ministry Spawning")
@export var MinistryNum:int = 0

@export_category("Boss Spawning")
@export_enum("None:-1","Tom:0", "Humphrey:1", "Sir Higgins:2","Garfield:3") var BossSpawn:int = -1

@onready var timer := $MiscTimer
const Customer := preload("res://scenes/characters/customer.tscn")
const MinistryAgent := preload("res://scenes/characters/ministry_agent.tscn")
const HealthInspector := preload("res://scenes/characters/health_inspector.tscn") # Boss


@onready var TutorialCustomers:Array = ['Ben.tres', 'Breo.tres', 'Charles.tres', 'Dalidoah.tres', 'Emma.tres', 'Hunter.tres', 'Jokez.tres', 'Krystal.tres']
#@onready var TutorialCustomers:Array = DirAccess.get_files_at("res://customers/Tutorial/")
@onready var Tier1:Array = ['45Glockz.tres', 'Ben.tres', 'Blackout.tres', 'Breo.tres', 'Charles.tres', 'CptLegend.tres', 'Dalidoah.tres', 'Eivan.tres', 'Emma.tres', 'Felix.tres', 'Formag.tres', 'Hunter.tres', 'Jokez.tres', 'Krystal.tres', 'KSS.tres', 'Kuspy.tres', 'Kyubi.tres', 'Mark.tres', 'Mary.tres', 'Orion.tres', 'Peter.tres', 'Proccessing.tres', 'Skup.tres', 'soap.tres', 'TCArk.tres', 'Yurei.tres']
#@onready var Tier1:Array = DirAccess.get_files_at("res://customers/Tier1/")
@onready var Tier2:Array = ['Artemis.tres', 'Benzeenee10.tres', 'Bruhgby.tres', 'Carlito2.tres', 'Deathrow.tres', 'Eidolonic.tres', 'Eivan2.tres', 'Garry.tres', 'Imoorzy.tres', 'JinBoi.tres', 'Kaze.tres', 'Krystal2.tres', 'Leah.tres', 'Moriarty2.tres', 'MrInfernal.tres', 'Noto.tres', 'Peter.tres', 'Slight.tres', 'Teethbat.tres', 'Ufrz.tres', 'Whatmaster.tres']
#@onready var Tier2:Array = DirAccess.get_files_at("res://customers/Tier2/")
@onready var Tier3:Array = ['April.tres', 'BaronDipitous.tres', 'Bruce.tres', 'BurgerkingCandycrush.tres', 'Carlito.tres', 'Flueve.tres', 'High.tres', 'Jammi.tres', 'Kangaroo_Knight.tres', 'Keta.tres', 'Mia.tres', 'Moriarty.tres', 'NanoCup.tres', 'Phoenix.tres', 'Reeseman5.tres', 'Reibean.tres', 'Sly.tres', 'Snipes.tres', 'sselemoh.tres', 'Strabster.tres', 'Vrile.tres']
#@onready var Tier3:Array = DirAccess.get_files_at("res://customers/Tier3/")
@onready var Tier4:Array = ['BedHeadNinja.tres', 'Iconography.tres', 'Lily.tres', 'Nevaa.tres', 'Oliver.tres']
#@onready var Tier4:Array = DirAccess.get_files_at("res://customers/Tier4/")

# Increment : [Customers, Path]
@onready var CustomerLists := {
	0: [TutorialCustomers, "res://customers/Tutorial/"],
	1: [Tier1, "res://customers/Tier1/"],
	2: [Tier2, "res://customers/Tier2/"],
	3: [Tier3, "res://customers/Tier3/"],
	4: [Tier4, "res://customers/Tier4/"]
}

var Spawned:Array

func _ready():
	randomize()

func _start():
#	timer.wait_time = 0.05
	timer.wait_time = randi_range(5, 8)
	timer.start()

func _on_misc_timer_timeout():
	_spawn()

func _spawn():
	# 1 in 3 chance to spawn ministry if exists otherwise spawn customer
	# When no more ministry/customers spawn boss if exists
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
	var CustomerRes:String
	var level:int
	
	# 1 in 3 chance to (possibly) draw from a lower pool of customers
	var RNG := randi() % 3
	if RNG == 0:
		match List:
			0:
				level = List # tutorial will only draw from tutorial
			1:
				level = List # Tier1 will only draw from Tier1
			2:
				level = (randi() % 2 + 1) # Draw from Tier1 or Tier2
			3:
				level = (randi() % 3 + 1) # Draw from Tier1, Tier2, or Tier3
			4:
				level = (randi() % 4 + 1)
	else:
		level = List
	
	CustomerRes = CustomerLists[level][0].pick_random()

	# Check if they've spawned yet, re-run if they have
	if Spawned.has(CustomerRes):
		_spawn_customer()
		return
	else:
		Spawned.append(CustomerRes)
		
		CustomerRes = str(CustomerLists[level][1] + CustomerRes)
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
