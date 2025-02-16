package main

import rl "vendor:raylib"

vec2 :: [2]i32

main :: proc() {
	screen_width: i32 = 1200
	screen_height: i32 = 900

	ground_height: i32 = 30
	player_size: i32 = 30

	gravity_force: i32 = 5

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

		rl.DrawRectangle(player_pos.x, player_pos.y, player_size, player_size, rl.WHITE)

		if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
			player_pos.y -= 35
		}

		if player_pos.y + player_size < screen_height - ground_height {
			player_pos.y += gravity_force
		}
	}
}

get_rect_center :: proc(x, y, width, height: i32) -> vec2 {
	return vec2{x + width / 2, y + height / 2}
}
