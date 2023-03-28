extends KinematicBody2D


onready var wonder=$WonderTimer
onready var CanSeePlayer=$PlayerDetection
onready var CanSeeEnemys=$EnemyDetection
var vectorWond= Vector2();
var velocity=Vector2.ZERO;
var movement=Vector2.ZERO
var possition= self.global_position
var health=100;
var player
var run=false
var OtherEnemies
var OthersExhist=false
var actionOnHealth= true
var knockback=Vector2.ZERO


func _ready():
	var animation= $AnimationPlayer

func _physics_process(delta):
	if !CanSeePlayer.SeePlayer():
		var direction=global_position.direction_to(wonder.endPosition)
		velocity=velocity.move_toward(direction*2000,10000*delta)
		if global_position.distance_to(wonder.endPosition)>10:
			move_and_slide(velocity*delta)
	knockback=knockback.move_toward(Vector2.ZERO,200*delta)
	knockback=move_and_slide(knockback)
	OtherEnemies=CanSeeEnemys.Enemy
	if CanSeePlayer.SeePlayer() :
		if player!=null :
			if actionOnHealth==true || OtherEnemies!=null:
				var direction= (player.global_position - global_position).normalized()
				velocity=velocity.move_toward(direction*2000,10000*delta)
				move_and_slide(velocity*delta)
			elif actionOnHealth==false && OtherEnemies==null:
				var direction= (global_position-player.global_position ).normalized()
				velocity=velocity.move_toward(direction*2000,5000*delta)
				move_and_slide(velocity*delta)
	
func task_Chase_Player(task):
		if CanSeePlayer.SeePlayer():
			player=CanSeePlayer.Player
			if player!=null:
				task.succeed()
			else:
				task.failed()

func task_Check_For_Other_BadGuys(task):
	if CanSeeEnemys.SeeEnemy():
		OtherEnemies=CanSeeEnemys.Enemy
		if OtherEnemies!=null:
			task.succeed()
		
	
func task_Run_From_Player(task):
	
	if OthersExhist==false && actionOnHealth==false:
		run=true
		task.succeed()
	else:
		run=false
		task.failed()

func task_wander_around(task):
	var animation= $AnimationPlayer
	if !CanSeePlayer.SeePlayer():
		if wonder.get_time()==0:
			vectorWond=wonder.get_vector()
			if vectorWond.y>0 :
				if vectorWond.x>0:
					animation.play("BatGoingRight")
				elif vectorWond.x<0:
					animation.play("BatGoingLeft")
			elif vectorWond.y<0:
				if vectorWond.x>0:
					animation.play("BatGoingRight")
				elif vectorWond.x<0:
					animation.play("BatGoingLeft")
			elif vectorWond.y==0 && vectorWond.x>0 :
				animation.play("BatGoingUp")
			elif vectorWond.y==0 && vectorWond.x<0:
				animation.play("BatGoingDown")
			wonder.start_time();	
			task.succeed()
	else:
		task.failed()
		

func task_Check_Health(task):
	if health>40:
		actionOnHealth=true
		task.succeed()
	elif health<40:
		actionOnHealth=false
		task.succeed()
	else:
		task.failed()
	

func _on_HurtBox_area_entered(area):
	if health>0:
		health=health-30
		var animation= $AnimationPlayer
		animation.play("BatDamage")
		knockback=area.knockback_vector*200
		
	else:
		var animation= $AnimationPlayer
		animation.play("BatDying")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	
	match anim_name:
		"BatDying":
			queue_free()
		"BatDamage":
			$AnimationPlayer.play("BatGoingDown")

