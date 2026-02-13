SMODS.Atlas {
    key = "enhancers",
    path = "enhancers.png",
    px = 71, py = 95,
}
-- TODO: code
local mods = {
	{
		id = 'mint',
		config = {
			x_chips = 1.25
		},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.x_chips
				}
			}
		end
	},
	{
		id = 'cool',
		x = 1,
		config = {
			e_chips = 1.3
		},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.e_chips
				}
			}
		end,
		calculate = function(self, card, context)
			if context.main_scoring and context.cardarea == G.play then
				return {
					e_chips = card.ability.e_chips
				}
			end
		end,
	},
	{
		id = 'hack',
		x = 2,
		always_scores = true,
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card:get_chip_bonus() + ((card.edition and card.edition.foil) and 50 or 0)
				}
			}
		end,
		calculate = function(self, card, context)
			if context.main_scoring and context.cardarea == G.hand then
				return {
					chips = card:get_chip_bonus() + ((card.edition and card.edition.foil) and 50 or 0)
				}
			end
		end,
	},
	{
		id = 'demo',
		x = 3,
		config = {
			bonus = 80,
			uses = 15
		},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.bonus,
					card.ability.uses
				}
			}
		end,
		calculate = function(self, card, context)
			if context.after and context.cardarea == G.play then
				card.ability.uses = card.ability.uses - 1
				if card.ability.uses <= 0 then
					return {
						message = localize('k_'..BalatrMod.prefix('trial_ended')),
						remove = true
					}
				end
				return {
					message = number_format(card.ability.uses)
				}
			end
		end,
	},
	{
		id = 'swap',
		y = 1,
		calculate = function(self, card, context)
			if context.main_scoring and context.cardarea == G.play then
				return {
					message = localize('k_'..BalatrMod.prefix('swap')),
					swap = true
				}
			end
		end,
	},
	{
		id = 'concrete',
		y = 1, x = 1,
		no_rank = true, no_suit = true, replace_base_card = true, always_scores = true,
		config = {
			h_x_mult = 2,
			x_chips = 3
		},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.h_x_mult,
					card.ability.x_chips
				}
			}
		end,
		draw = function(self, card, dt)
			if card.facing == 'front'
			and card.area and (
			(card.area == G.hand)
			or (card.area == G.play)
			or (card.area == G.deck)
			or (card.area == G.discard)
			or G.STATE == G.STATES.MENU -- allow in collection
			) then
				card.role.max_vel = 0.04
				if not BalatrMod.moving_concrete then
					BalatrMod.moving_concrete = (math.abs(card.velocity.x) + math.abs(card.velocity.y)) > 0
				end
			else
				card.role.max_vel = nil
			end
		end,
		set_ability = function(self, card, initial, delay_sprites)
			card.role.max_vel = 0.04
		end,
		post_setup = function(self)
			local __love_draw = love.draw
			function love.draw()
				BalatrMod.moving_concrete = false
				__love_draw()
			end

			local __draw_card = draw_card
			function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
				if card and SMODS.get_enhancements(card)['m_'..BalatrMod.prefix('concrete')] and (to ~= G.discard) and card.facing == 'front' then
					if not delay then delay = 0.1 end
					delay = delay * 15 * G.SETTINGS.GAMESPEED
				end
				__draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
			end
			local __Card_set_ability = Card.set_ability
			function Card:set_ability(_center, _initial, _delay_sprites)
				self.role.max_vel = nil
				__Card_set_ability(self, _center, _initial, _delay_sprites)
			end
		end
	},
	{
		id = 'whatsapp',
		y = 1, x = 2,
		no_rank = true, no_suit = true, replace_base_card = true, always_scores = true,
		calculate = function(self, card, context)
			if context.main_scoring and context.cardarea == G.play then
				return {
					balance = true
				}
			end
		end,
	},
	{
		id = 'star',
		y = 1, x = 3,
		calculate = function(self, card, context)
			if context.main_scoring and context.cardarea == "unscored" then
				G.E_MANAGER:add_event(Event({
                	func = function()
                		add_tag(Tag(get_next_tag_key()))
                		play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                		play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                		return true
                	end
                }))
				return {
					message = localize('k_'..BalatrMod.prefix('tag_ex'))
				}
			end
		end,
	},
}

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

local blind_funcs = {
	'calculate', 'no_rank', 'no_suit', 'any_suit', 'always_scores',
	'replace_base_card', 'shatters', 'weight', 'loc_vars',
	'update', 'draw'
}
for k, i in ipairs(mods) do
	local b = {
		key = i.id or k,
		atlas = 'enhancers',
		loc_txt = {
			name = i.name or '???',
			text = i.text or {'Does nothing...?'}
		},
		pos = {x = i.x or 0, y = i.y or 0},
		config = i.config or {},
	}
	for _, j in ipairs(blind_funcs) do
		if i[j] then
			b[j] = i[j]
		end
	end
	if i.post_setup ~= nil then
		i.post_setup(b)
	end
	SMODS.Enhancement(b)
end