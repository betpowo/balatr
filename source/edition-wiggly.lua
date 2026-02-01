SMODS.Shader({key = 'wiggly', path = 'wiggly.fs'})
SMODS.Edition {
	key = "wiggly",
	order = 3,
	weight = 0.6,
	shader = "wiggly",
	in_shop = true,
	extra_cost = 8,
    apply_to_float = true,
    discovered = true,
	disable_base_shader = true,
	config = {
		add = 1.5,
	},
	sound = {
		sound = 'foil1',
		per = 1,
		vol = 5,
	},

	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	loc_vars = function(self, info_queue)
		return { vars = {
			self.config.add,
		} }
	end,
	calculate = function(self, card, context)
		-- yahimod
    	if (
			context.edition -- for when on jonklers
			and context.cardarea == G.jokers -- checks if should trigger
			and context.post_joker
		) or (
			context.main_scoring -- for when on playing cards
			and context.cardarea == G.play
		) then
			return {
				[pseudorandom_element({
					'chip_mod', 'mult_mod', 'Xchip_mod', 'Xmult_mod',
					'Echip_mod', 'Emult_mod', 'EEchip_mod', 'EEmult_mod',
					'EEEchip_mod', 'EEEmult_mod'
				}, 'wiggly')] = self.config.add
			}
		end
	end,
}