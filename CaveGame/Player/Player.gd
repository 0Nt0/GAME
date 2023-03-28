extends KinematicBody2D

var state=0
var movement=Vector2.ZERO
var input=Vector2.ZERO
var animation=null
var health=100
onready var knockbackEnemy= $AttackHitBox/HitBox
var attackvector=Vector2.LEFT

func _ready():
	animation= $AnimationPlayer
	HPTracker.SetHp(health)
	knockbackEnemy.knockback_vector=attackvector

func animationPlay(input):
	if input.x >0:
		animation.play("Walk_Right")
	elif input.x<0:
			animation.play("Walk_Left")
	elif input.y>0:
		animation.play("Walk_Down")
	elif input.y<0:
		animation.play("Walk_Up")
	elif input.x==0 && Input.is_action_just_released("ui_right"):
		animation.play("Idal_Right")
	elif input.x==0 && Input.is_action_just_released("ui_left"):
		animation.play("Idal_Left")
	elif input.y==0 && Input.is_action_just_released("ui_down"):
		animation.play("Idal_Down")
	elif input.y==0 && Input.is_action_just_released("ui_up"): 
		animation.play("Idal_Up")
	
func _physics_process(delta):
	match state:
		0:
			movement(delta);
		1:
			attacking(delta);

func movement(delta):
	input.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input.y=Input.get_action_strength("ui_down")- Input.get_action_strength("ui_up")
	if input !=Vector2.ZERO:
		knockbackEnemy.knockback_vector=input
		animationPlay(input)
		movement +=input.normalized()*900*delta
		movement=movement.limit_length(60)
	else:
		animationPlay(input)
		movement=movement.move_toward(Vector2.ZERO, 900*delta)
	
	move_and_collide(movement*delta)
	
	if Input.is_action_just_pressed("Attack"):
		state=1;
func attacking(delta):
	movement=Vector2.ZERO
	input.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input.y=Input.get_action_strength("ui_down")- Input.get_action_strength("ui_up")
	attackAnimations(input)

func attackAnimations(input):
	if $AnimationPlayer.current_animation=="Walk_Right"|| $AnimationPlayer.current_animation=="Idal_Right":
		animation.play("Attack_Right")
	elif  $AnimationPlayer.current_animation=="Walk_Left" || $AnimationPlayer.current_animation=="Idal_Left":
		animation.play("Attack_Left")
	elif $AnimationPlayer.current_animation=="Walk_Down" || $AnimationPlayer.current_animation=="Idal_Down":
		animation.play("Attack_Down")
	elif $AnimationPlayer.current_animation=="Walk_Up" || $AnimationPlayer.current_animation=="Idal_Up":
		animation.play("Attack_Up")

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Attack_Left":
			$AnimationPlayer.play("Idal_Left")
			state=0
		"Attack_Down":
			$AnimationPlayer.play("Idal_Down")
			state=0
		"Attack_Right":
			$AnimationPlayer.play("Idal_Right")
			state=0
		"Attack_Up":
			$AnimationPlayer.play("Idal_Up")
			state=0


func _on_HurtBox_area_entered(area):
	if health>0:
		health=health-5
		HPTracker.SetHp(health)
		print(health)
	else:
		queue_free()
		
	
