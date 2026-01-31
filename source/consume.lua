SMODS.Atlas {
    key =  "consumables",
    path = "consumables.png",
    px = 71, py = 95,
}

SMODS.ConsumableType {
    key = 'BalatrEdible',
	primary_colour = HEX('6eb49f'),
    secondary_colour = HEX('eeb162'),
    loc_txt = {
		name = 'Consumable',
		label = 'Consumable'
	},
	default = 'c_'..BalatrMod.prefix('food_apple'),
    collection_rows = {4, 4},
	select_card = "consumeables",
	select_button_text = "b_select",
	shop_rate = 0.0
}

SMODS.UndiscoveredSprite{
    key = 'BalatrEdible',
    atlas = 'consumables',
    pos = { x = 0, y = 1 }
}

BalatrMod.food_dissolve_step = function(self, card)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.2,
		func = function()
			if not card.dissolve then card.dissolve = 0 end
			card.dissolve_colours = {G.C.FILTER}
			card.ability.extra.__uses = card.ability.extra.__uses - 1
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					card.dissolve = 1 - (card.ability.extra.__uses / (self.config.extra.__uses or 3))
					card:juice_up(1, 0.5)
					return true
				end
			}))
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize {
					key='a_remaining',type='variable',vars={card.ability.extra.__uses}
				},
				colour = G.C.FILTER, sound = 'tarot1'
			})
			delay(0.2)
			return true
		end
	}))
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- THEY ARE EDIBLE CARDS BY DEFAULT!!!!! REMEMBER
local items = {
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'reciprocal',
		y = 2, x = 4, 
		set = 'Spectral',
		name = 'Reciprocal',
		text = {
			"{C:dark_edition}Negative{} Jokers become normal,",
			"and {C:attention}vice-versa{}"
		},
		config = { },
		cost = 4,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue+1] = G.P_CENTERS.e_negative
			return {}
		end,
		can_use = function(self, card)
			return G.jokers and #G.jokers.cards > 0
		end,
		use = function(self, card, area)
			for k, v in pairs(G.jokers.cards) do
				if v.edition and v.edition.negative then
					v:set_edition(nil)
				else
					v:set_edition('e_negative')
				end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'outcast',
		y = 2, x = 4, 
		set = 'Spectral',
		name = 'Outcast',
		text = {
			"Applies {C:dark_edition}Negative{} to",
			"{C:attention}#1#{} selected playing card,",
			"{C:red}Halves{} your money"
		},
		config = {max_highlighted = 1},
		cost = 4,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue+1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
			return {vars = {
				self.config.max_highlighted
			}}
		end,
		use = function(self, card, area)
			for k, v in pairs(G.hand.highlighted) do
				v:set_edition('e_negative')
			end
			-- hermit
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
        		    play_sound('timpani')
        		    card:juice_up(0.3, 0.5)
        		    ease_dollars(to_big(math.floor(to_big(G.GAME.dollars) / to_big(-2))), true)
        		    return true
				end 
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand:unhighlight_all()
        		    return true
				end 
			}))
        	delay(0.6)
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'nebula',
		y = 2, x = 2,
		set = 'Tarot',
		name = 'Nebula',
		text = {
			"Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {C:"..BalatrMod.prefix('blorbs').."}Blorbs{}",
		},
		config = {suit_conv = BalatrMod.prefix('Blorbs'), max_highlighted = 3},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					self.config.max_highlighted
				}
			}
		end,
		in_pool = function(self, args)
			return BalatrMod.has_blorbs()
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'towel',
		y = 2, x = 2,
		set = 'Tarot',
		name = 'The Towel',
		text = {
			"Adds a random {C:attention}enhancement{}",
			"to {C:attention}#1#{} selected cards"
		},
		config = {max_highlighted = 2},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					self.config.max_highlighted
				}
			}
		end,
		use = function(self, card, area)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
        		    play_sound('tarot1')
        		    card:juice_up(0.3, 0.5)
        		    return true
				end
			}))

			-- ts pmo

        	for i = 1, #G.hand.highlighted do
        	    local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        	    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        	end

			for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.hand.highlighted[i]:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})]);
						return true
					end
				}))
            end 

        	for i = 1, #G.hand.highlighted do
        	    local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        	    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        	end
        	delay(0.2)
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
}

local edible_consumables = {
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_apple',
		y = 1, x = 1,
		name = 'Apple',
		text = {
			"Adds {C:chips}+#1#{} Chips to",
			"{C:attention}#2#{} selected card"
		},
		config = {max_highlighted = 1, extra = {inc = 3, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					self.config.max_highlighted
				}
			}
		end,
		
		use = function(self, card, area)
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local c = G.hand.highlighted[i]
						c.ability.perma_bonus = c.ability.perma_bonus or 0
						c.ability.perma_bonus = c.ability.perma_bonus + card.ability.extra.inc
						card_eval_status_text(c, 'extra', nil, nil, nil, {
							message = localize{ type = 'variable', key = 'a_chips', vars = { c.ability.perma_bonus } },
							colour = G.C.CHIPS, sound = 'tarot2'
						})
						return true
					end
				}))
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_orange',
		y = 1, x = 2,
		name = 'Orange',
		text = {
			"Adds {C:mult}+#1#{} Mult to",
			"{C:attention}#2#{} selected card"
		},
		config = {max_highlighted = 1, extra = {inc = 1, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					self.config.max_highlighted
				}
			}
		end,
		
		use = function(self, card, area)
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local c = G.hand.highlighted[i]
						c.ability.perma_mult = c.ability.perma_mult or 0
						c.ability.perma_mult = c.ability.perma_mult + card.ability.extra.inc
						card_eval_status_text(c, 'extra', nil, nil, nil, {
							message = localize{ type = 'variable', key = 'a_mult', vars = { c.ability.perma_mult } },
							colour = G.C.MULT, sound = 'tarot2'
						})
						return true
					end
				}))
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_lemon',
		y = 1, x = 3,
		name = 'Lemon',
		text = {
			"Adds {X:chips,C:white}X#1#{} Chips to",
			"{C:attention}#2#{} selected card"
		},
		config = {max_highlighted = 1, extra = {inc = 0.1, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					self.config.max_highlighted
				}
			}
		end,
		
		use = function(self, card, area)
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local c = G.hand.highlighted[i]
						c.ability.perma_x_chips = c.ability.perma_x_chips or 1
						c.ability.perma_x_chips = c.ability.perma_x_chips + card.ability.extra.inc
						card_eval_status_text(c, 'extra', nil, nil, nil, {
							message = localize{ type = 'variable', key = 'a_xchips', vars = { 1 + c.ability.perma_x_chips } },
							colour = G.C.CHIPS, sound = 'tarot2'
						})
						return true
					end
				}))
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_lime',
		y = 1, x = 4,
		name = 'Lime',
		text = {
			"Adds {X:mult,C:white}X#1#{} Mult to",
			"{C:attention}#2#{} selected card"
		},
		config = {max_highlighted = 1, extra = {inc = 0.1, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					self.config.max_highlighted
				}
			}
		end,
		
		use = function(self, card, area)
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local c = G.hand.highlighted[i]
						c.ability.perma_x_mult = c.ability.perma_x_mult or 1
						c.ability.perma_x_mult = c.ability.perma_x_mult + card.ability.extra.inc
						card_eval_status_text(c, 'extra', nil, nil, nil, {
							message = localize{ type = 'variable', key = 'a_xmult', vars = { 1 + c.ability.perma_x_mult } },
							colour = G.C.MULT, sound = 'tarot2'
						})
						return true
					end
				}))
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_choco_ball',
		y = 1, x = 5,
		name = 'Chocolate Ball',
		text = {
			"Adds {C:money}$#1#{} on scoring to",
			"{C:attention}#2#{} selected card"
		},
		config = {max_highlighted = 1, extra = {inc = 1, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					self.config.max_highlighted
				}
			}
		end,
		
		use = function(self, card, area)
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local c = G.hand.highlighted[i]
						c.ability.perma_p_dollars = c.ability.perma_p_dollars or 1
						c.ability.perma_p_dollars = c.ability.perma_p_dollars + card.ability.extra.inc
						card_eval_status_text(c, 'extra', nil, nil, nil, {
							message = '$'..tostring(c.ability.perma_p_dollars),
							colour = G.C.GOLD, sound = 'tarot2'
						})
						return true
					end
				}))
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_chip',
		y = 1, x = 6,
		name = 'Potato Chip',
		text = {
			"Adds {C:"..BalatrMod.prefix('rainbow').."}+#1#{} to",
			"current {C:attention}round{} score"
		},
		config = {extra = {inc = 3, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc
				}
			}
		end,
		can_use = function(self, card)
			return G.STATE == G.STATES.SELECTING_HAND
		end,
		
		use = function(self, card, area)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.GAME.chips = G.GAME.chips + to_big(card.ability.extra.inc)
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.1)
					card_eval_status_text(card, 'extra', nil, nil, nil, {
						message = '+'..card.ability.extra.inc,
						colour = SMODS.Gradients[BalatrMod.prefix('rainbow')], sound = 'tarot2',
						instant = true
					})
					return true
				end
			}))
			-- pain and agony
			
			G.E_MANAGER:add_event(Event({
				delay = 0.2,
				func = function()
					BalatrMod.food_dissolve_step(self, card)
					if to_big(G.GAME.chips) < to_big(G.GAME.blind.chips) then
						return true
					end
        			G.STATE = G.STATES.HAND_PLAYED
        			G.STATE_COMPLETE = true
					BalatrMod.fix_this_fucking_shitty_game = true
        			end_round()
					return true
				end
			}))
		end,
		post_setup = function(self)
			local og___Game_update_draw_to_hand = Game.update_draw_to_hand
			function Game:update_draw_to_hand(dt)
				if BalatrMod.fix_this_fucking_shitty_game then
					if not G.STATE_COMPLETE then
						G.STATE = G.STATES.NEW_ROUND
						G.STATE_COMPLETE = true
						BalatrMod.fix_this_fucking_shitty_game = nil
					end
				else
					og___Game_update_draw_to_hand(self, dt)
				end
			end
		end,
		auto_step = false
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_pear',
		y = 2,
		name = 'Pear',
		text = {
			"Adds {X:mult,C:white}X#1#{} {C:attention}held{} Mult to",
			"{C:attention}#2#{} selected card"
		},
		config = {max_highlighted = 1, extra = {inc = 0.25, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					self.config.max_highlighted
				}
			}
		end,
		
		use = function(self, card, area)
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local c = G.hand.highlighted[i]
						c.ability.perma_h_x_mult = c.ability.perma_h_x_mult or 1
						c.ability.perma_h_x_mult = c.ability.perma_h_x_mult + card.ability.extra.inc
						card_eval_status_text(c, 'extra', nil, nil, nil, {
							message = localize{ type = 'variable', key = 'a_xmult', vars = { 1 + c.ability.perma_h_x_mult } },
							colour = G.C.MULT, sound = 'tarot2'
						})
						return true
					end
				}))
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'food_empanada',
		y = 1, x = 6,
		name = 'Empanada',
		text = {
			"Adds {C:attention}+#1#{} {C:chips}Chips{} or {C:mult}Mult{} to",
			"{C:attention}#2#{} random cards in hand",
		},
		config = {extra = {inc = 5, cards = 3, __uses = 3}},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.inc,
					card.ability.extra.cards
				}
			}
		end,
		can_use = function(self, card)
			return G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK
			or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK
			or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
		end,
		use = function(self, card, area)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					for i = 1, card.ability.extra.cards do
						G.E_MANAGER:add_event(Event({
							trigger = 'before',
							delay = 0.2,
							func = function()
								local s = false
								while not s do
									local c = pseudorandom_element(G.hand.cards, 'balatr_empanada')
									if not c.highlighted then
										G.hand:add_to_highlighted(c)
										s = true
									end
								end
								return true
							end
						}))
					end
					delay(0.3)
					G.E_MANAGER:add_event(Event({
						func = function()
							for k, c in ipairs(G.hand.highlighted) do
								G.E_MANAGER:add_event(Event({
									trigger = 'before',
									func = function()
										local chosen = pseudorandom_element({'perma_bonus', 'perma_mult'}, 'empanadas')
										c.ability[chosen] = c.ability[chosen] or 0
										c.ability[chosen] = c.ability[chosen] + card.ability.extra.inc
										card_eval_status_text(c, 'extra', nil, nil, nil, {
											message = localize{ type = 'variable', key = 'a_chips', vars = { c.ability[chosen] } },
											colour = G.C.CHIPS, sound = 'tarot2'
										})
										return true
									end
								}))
							end
							return true
						end
					}))
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()
					G.hand:unhighlight_all()
					return true
				end
			}))
		end
	},
}

-- automate some stuff for edibles
for k, v in ipairs(edible_consumables) do
	v.keep_on_use = function(self, card)
		return card.ability.extra.__uses > 1
	end
	-- not gonna bother with not v.auto_step, nil also acts as false
	if v.auto_step ~= false then
		local og_use = v.use
		v.use = function(self, card, area)
			og_use(self, card, area)
			BalatrMod.food_dissolve_step(self, card)
		end
	end
	v.set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge(localize{
			key='a_remaining',type='variable',vars={card.ability.extra.__uses}
		}, SMODS.Gradients[BalatrMod.prefix('rainbow')], G.C.WHITE, 1)
 	end
	table.insert(items, v)
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
local item_extra_vars = {
	'soul_pos', 'cost', 'sell_cost', 'can_use', 'check_for_unlock',
	'keep_on_use', 'add_to_deck', 'remove_from_deck', 'update', 'set_sprites', 'draw',
	'in_pool', 'set_badges', 'load', 'generate_ui'
}
for k, i in ipairs(items) do
	local j = {
		key = i.id or k,
		set = i.set or 'BalatrEdible',
		object_type = "Consumable",
		atlas = i.atlas or 'consumables',
		pos = {x = i.x or 0, y = i.y or 0},
		cost = i.cost or 3,
		loc_txt = {
			name = i.name or i.id,
			text = i.text or {"..."}
		},
		loc_vars = i.loc_vars or function(self, info_queue, card)
			return {}
		end,
		config = i.config or {},
		unlocked = i.unlocked or true,
    	discovered = i.discovered or false,

		-- unsafe (?) params
		use = i.use
	}
	for _, k in ipairs(item_extra_vars) do
		if i[k] then
			j[k] = i[k]
		end
	end
	if i.post_setup ~= nil then
		i.post_setup(j)
	end
	SMODS.Consumable(j)
end