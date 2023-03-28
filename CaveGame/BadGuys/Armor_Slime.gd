extends KinematicBody2D


# Declare member variables here. Examples:
var animation
var health=100;
var knockback=Vector2.ZERO
onready var CanSeePlayer=$PlayerDetection
onready var CanSeeEnemys=$EnemyDetection
var run=false
var OtherEnemies
var OthersExhist=false
var actionOnHealth=true
var player
var velocity=Vector2.ZERO;



func _physics_process(delta):
	knockback=knockback.move_toward(Vector2.ZERO,200*delta)
	knockback=move_and_slide(knockback)
	OtherEnemies=CanSeeEnemys.Enemy
	if CanSeePlayer.SeePlayer() :
		if player!=null :
			if actionOnHealth==true || OtherEnemies!=null:
				var direction= (player.global_position - global_position).normalized()
				velocity=velocity.move_toward(direction*1000,5000*delta)
				move_and_slide(velocity*delta)
			elif actionOnHealth==false && OtherEnemies==null:
				var direction= (global_position-player.global_position ).normalized()
				velocity=velocity.move_toward(direction*2000,5000*delta)
				move_and_slide(velocity*delta)
	
	
func task_Idal(task):
	if health==100:
		var animation= $AnimationPlayer
		animation.play("Slime_Armor_Idal")
		task.succeed()
	else:
		task.failed()

func task_Chase_Player(task):
	var animation= $AnimationPlayer
	if CanSeePlayer.SeePlayer():
		player=CanSeePlayer.Player
		if player!=null:
			animation.play("Slime_Armor_Down")
			task.succeed()
		else:
			task.failed()

func task_Check_For_Other_BadGuys(task):
	if CanSeeEnemys.SeeEnemy():
		OtherEnemies=CanSeeEnemys.Enemy
		if OtherEnemies!=null:
			OthersExhist=true
			task.succeed()
		else:
			OthersExhist=false
			task.succeed()

func task_Run_From_Player(task):
	if OthersExhist==false && actionOnHealth==false:
		run=true
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
		health=health-10
		$AnimationPlayer.play("Slime_Armor_Hit")
		knockback=area.knockback_vector*50
	else:
		$AnimationPlayer.play("Slime_Armor_Die")
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
			"Slime_Armor_Hit":
				$AnimationPlayer.play("Slime_Armor_Down")
			"Slime_Armor_Die":
				pass
			
		
