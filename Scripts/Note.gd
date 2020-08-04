extends Area2D

#position of the hit targets on y axis
const TARGET_Y = 164
const SPAWN_Y = -16
const DIST_TO_TARGET = TARGET_Y - SPAWN_Y

#position of lanes
const UP_LANE_SPAWN = Vector2(120, SPAWN_Y)
const RIGHT_LANE_SPAWN = Vector2(160, SPAWN_Y)
const DOWN_LANE_SPAWN = Vector2(200, SPAWN_Y)
const LEFT_LANE_SPAWN = Vector2(240, SPAWN_Y)

var speed = 0
var hit = false


func _ready():
	pass

#combo logic
func _physics_process(delta):
	if !hit:
		position.y += speed * delta
		#miss the target resets combo
		
		if position.y > 200:
			get_parent().reset_combo()
			queue_free()

	else:
		$Indicator.position.y -= speed * delta

#targets
func initialize(lane):
	if lane == 0:
		$TargetAnimatedSprite.frame = 0
		position = UP_LANE_SPAWN
	elif lane == 1:
		$TargetAnimatedSprite.frame = 1
		position = RIGHT_LANE_SPAWN
	elif lane == 2:
		$TargetAnimatedSprite.frame = 2
		position = DOWN_LANE_SPAWN
		
	elif lane == 3:
		$TargetAnimatedSprite.frame = 3
		position = LEFT_LANE_SPAWN
	else:
		#invalid lane
		printerr("Invalid lane set for note: " + str(lane))
		return
	#time took to reach this arrow button
	speed = DIST_TO_TARGET / 2.0

#note ranks indicator
func destroy(score):
	$DestroyParticles2D.emitting = true
	$TargetAnimatedSprite.visible = false
	$DestroyTimer.start()
	hit = true
	if score == 3:
		$Indicator/HitLabel.text = "PERFECT"
		$Indicator/HitLabel.modulate = Color("ffd700")
	elif score == 2:
		$Indicator/HitLabel.text = "GREAT"
		$Indicator/HitLabel.modulate = Color("c3a38a")
	elif score == 1:
		$Indicator/HitLabel.text = "GOOD"
		$Indicator/HitLabel.modulate = Color("997577")
	else:
		$DestroyParticles2D.emitting = false
		$Indicator/HitLabel.text = "MISS"
		$Indicator/HitLabel.modulate = Color("#ff0000")
#resets timer
func _on_Timer_timeout():
	queue_free()



func _on_MissTimer_timeout():
	queue_free()
