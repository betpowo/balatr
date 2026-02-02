SMODS.Shader({key = 'ultra', path = 'ultra.fs'})
SMODS.Edition {
	key = "ultra",
	order = 4,
	weight = 12,
	shader = "ultra",
	in_shop = true,
	extra_cost = 7,
    apply_to_float = true,
    discovered = true,
	config = { e_mult = 2 },
	sound = {
		sound = BalatrMod.prefix("ultra"),
		per = 1,
		vol = 5,
	},

	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.e_mult } }
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
				-- its only a func so we can use the awesome sound....
				Emult_mod = self.config.e_mult,
				remove_default_message = true,
				func = function()
					card_eval_status_text(card, 'jokers', nil, percent, nil, {
						message = '^'..self.config.e_mult..' Mult',
						colour = G.C.EDITION, edition = true,
						Emult_mod = self.config.e_mult,
						sound = BalatrMod.prefix("ultra"),
						volume = 5
					})
				end
			}
		end
	end,
}