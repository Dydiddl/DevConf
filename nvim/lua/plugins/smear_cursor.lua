return {
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			-- Smear cursor when switching buffers or windows.
			smear_between_buffers = true,

			-- Smear cursor when moving within line or to neighbor lines.
			-- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
			smear_between_neighbor_lines = true,

			-- Draw the smear in buffer space instead of screen space when scrolling
			scroll_buffer_space = true,

			-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
			-- Smears and particles will look a lot less blocky.
			legacy_computing_symbols_support = true,

			-- Smear cursor in insert mode.
			-- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
			smear_insert_mode = true,

			-- stiffness = 0.8,
			-- trailing_stiffness = 0.6,
			--
			-- stiffness_insert_mode = 0.7,
			-- trailing_stiffness_insert_mode = 0.7,
			--
			-- damping = 0.95,
			-- damping_insert_mode = 0.95,
			--
			-- distance_stop_animating = 0.5,

			-- -- Particle
			-- particles_enabled = true,
			--          time_interval = 6,
			--
			-- particles_per_second = 400,
			-- particles_pew_length = 10,
			--
			-- particle_max_num = 500,
			--
			-- particle_spread = 0.8,
			--
			-- particle_max_lifetime = 500,
			-- particle_lifetime_distribution_exponent = 5,
			--
			-- particle_max_initial_velocity = 15,
			-- particle_velocity_from_cursor = 0.4,
			-- particle_random_velocity = 100,
			--
			-- particle_damping = 0.15,
			-- particle_gravity = -30,
			--
			-- min_distance_emit_particles = 0,
		},
	},
}
