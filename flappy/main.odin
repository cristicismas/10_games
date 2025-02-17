package main

import "base:intrinsics"
import "core:fmt"
import rl "vendor:raylib"

vec2 :: [2]i32

main :: proc() {
	screen_width: i32 = 1200
	screen_height: i32 = 900

	ground_height: i32 = 30
	player_size: i32 = 30

	gravity_force: i32 = 3
	max_jump_velocity: f32 = 45
	up_velocity: f32 = 0
	is_jumping := false

	rl.InitWindow(screen_width, screen_height, "Flappy!")
	defer rl.CloseWindow()

	rl.SetTargetFPS(60)

	screen_center := get_rect_center(0, 0, screen_width, screen_height)
	player_pos := screen_center

	for (!rl.WindowShouldClose()) {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.BLACK)

		rl.DrawRectangle(0, screen_height - ground_height, screen_width, ground_height, rl.WHITE)

		rl.DrawRectangle(player_pos.x - 300, player_pos.y, player_size, player_size, rl.WHITE)

		if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
			is_jumping = true
		}

		// TODO: jump cooldown
		if is_jumping {
			if up_velocity < max_jump_velocity {
				up_velocity += max_jump_velocity / 5
				player_pos.y -= cast(i32)up_velocity
			} else {
				is_jumping = false
				up_velocity = 0
			}
		}

		if player_pos.y + player_size < screen_height - ground_height {
			player_pos.y += gravity_force
		}
	}
}

get_rect_center :: proc(x, y, width, height: i32) -> vec2 {
	return vec2{x + width / 2, y + height / 2}
}

lerp :: proc(start: f32, end: f32, t: f32) -> f32 {
	return start * (1 - t) + end * t
}
