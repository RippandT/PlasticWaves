extends AnimationPlayer

func play_animation(delay: float, animation_name: String, play_backwards: bool):
    if delay > 0:
        await get_tree().create_timer(delay).timeout
    
    play(animation_name, -1, 1 - int(play_backwards), play_backwards)