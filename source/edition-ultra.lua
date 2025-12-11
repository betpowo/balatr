local MIN_MULT = 1e255

SMODS.Shader({key = 'ultra', path = 'ultra.fs'})
SMODS.Sound {
	key = 'ultra',
	path = 'ultra.ogg',
	pitch = 1
}
SMODS.Edition {
	key = "ultra",
	order = 69,
    loc_txt = {
        name =  "Ultra",
        label = "Ultra",
        text = {
            "{X:"..BalatrMod.prefix('e_mult')..",C:white}^#1#{} Mult"
        }
    },
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
			-- no point
			if BalatrMod.talisman then
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
			-- ????
			return {
				func = function()
					if (mult == math.huge) then
						mult = mod_mult(MIN_MULT)
						hand_chips = mod_chips(1)
						card_eval_status_text(card, 'jokers', nil, percent, nil, {
							message = 'Nope!',
							colour = G.C.RED,
							sound = 'cancel',
							volume = 5
						})
					else
						mult = mod_mult(math.min(MIN_MULT, math.pow(mult, self.config.e_mult)))
						card_eval_status_text(card, 'jokers', nil, percent, nil, {
							message = '^'..self.config.e_mult..' Mult',
							colour = G.C.EDITION, edition = true,
							sound = BalatrMod.prefix("ultra"),
							volume = 5
						})
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7
					end
				end,
			}
		end
	end,
}