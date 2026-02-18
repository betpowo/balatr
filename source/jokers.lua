SMODS.Atlas {
    key = "jokersrealnofake",
    path = "jokers real no fake.png",
    px = 71, py = 95,
}

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------


local jokers = {
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'balatr',
		x = 8,
		rarity = 1,
		cost = 1,
		unlocked =   true,
		discovered = true,
		calculate = function(self, card, context)
			G.E_MANAGER:add_event(Event({
				delay = 0.1,
				blockable = false,
				func = function()
					G:delete_run()
					G:main_menu('splash')
					return true;
				end
			}))
			return {
				message = 'mfw'
			}
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'jokoj',
		x = 1,
		config = { extra = { chips = 80 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.chips } }
		end,
		cost = 4,
		calculate = function(self, card, context)
			if context.joker_main and BalatrMod.is_hand_palindrome(context.full_hand) then
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'reker',
		x = 2,
		config = { extra = { mult = 10 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.mult } }
		end,
		cost = 4,
		calculate = function(self, card, context)
			if context.joker_main and BalatrMod.is_hand_palindrome(context.full_hand) then
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'macaron',
		x = 3,
		pixel_size = { w = 61, h = 40 },
		config = { extra = { Xmult = 4 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.Xmult } }
		end,
		rarity = 1,
		cost = 3,
		post_setup = function(self)
			self.eternal_compat = false
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {
					Xmult_mod = card.ability.extra.Xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				}
			end
			if context.end_of_round and context.game_over == false then
				card.ability.extra.Xmult = card.ability.extra.Xmult - 1
				if card.ability.extra.Xmult <= 1 then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							card.T.r = -0.2
							card:juice_up(0.3, 0.4)
							card.states.drag.is = true
							card.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blockable = false,
								func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
									return true;
								end
							}))
							return true
						end
					}))
					return {
						message = localize('k_eaten_ex')
					}
				else
					return {
						message = localize { type = 'variable', key = 'a_xmult_minus', vars = { 1 } },
						colour = G.C.MULT
					}
				end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'gato',
		x = 4,
		config = { extra = { chips = 25 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.chips,
			} }
		end,
		cost = 2,
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_suit('Diamonds') then
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
					sound = BalatrMod.prefix('whatsapp')
				}
			end
		end,
		post_setup = function(self)
			-- compatibility with yahimod......i love yahimod
			self.pools["Cat"] = true
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'super_f',
		x = 5,
		config = { extra = { mult = 1 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.mult } }
		end,
		cost = 2,
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and context.other_card and context.other_card:get_id() == 2 then
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'fuck_you',
		x = 6,
		soul_pos = {x = 7, y = 0},
		config = { extra = { Xmult = -2 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.Xmult } }
		end,
		rarity = 2,
		cost = -6,
		post_setup = function(self)
			self.blueprint_compat = true
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {
					Xmult_mod = card.ability.extra.Xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'slothful',
		y = 1,
		config = { extra = { mult = 3 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.mult,
			} }
		end,
		cost = 3,
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_suit(BalatrMod.prefix('Blorbs')) then
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				}
			end
		end,
		in_pool = function(self, args)
			return BalatrMod.has_blorbs()
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'gambler',
		y = 1, x = 1,
		config = { extra = { xmult = 7, xmult2 = 0.7, moola = 77, moola2 = 1 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.xmult,
				card.ability.extra.xmult2,
				card.ability.extra.moola,
				card.ability.extra.moola2,
			} }
		end,
		cost = 7,
		rarity = 2,
		calculate = function(self, card, context)
			if context.joker_main then
				local a = card.ability.extra
				local sum = 0
				for _, i in ipairs(context.full_hand) do
					sum = sum + i.base.nominal
				end
				local jackpot = ((sum % 7) == 0) or tostring(sum):find('7')
				local ret = {
					xmult = jackpot and a.xmult or a.xmult2,
					dollars = jackpot and a.moola or -a.moola2
				}
				if jackpot then
					ret.func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								card_eval_status_text(card, 'extra', nil, nil, nil, {
									message = localize('k_'..BalatrMod.prefix('jackpot_ex')), colour = G.C.GOLD,
									sound = 'xchips', instant = true, pitch = 2
								})
								play_sound(BalatrMod.prefix('slots'), 1, 0.6)
								G.ROOM.jiggle = G.ROOM.jiggle + 13
								return true
							end
						}))
					end
				end
				return ret
			end
		end,
		post_setup = function(self)
			SMODS.Sound {
				key = 'slots',
				path = 'slots.ogg',
				pitch = 1
			}
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = '6_the_dollar',
		rarity = 2,
		cost = 6,
		y = 2, x = 8,
		config = { extra = { money = 6, rank = '6' } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				localize(card.ability.extra.rank, 'ranks'),
				card.ability.extra.money,
			} }
		end,
		calculate = function(self, card, context)
			if context.individual and context.other_card and context.cardarea == "unscored"
			and (not SMODS.has_no_rank(context.other_card))
			and (context.other_card.base.value == card.ability.extra.rank)
			then
				--print(localize(context.other_card.base.value, 'ranks')..' of '..localize(context.other_card.base.suit, 'suits_plural')..': '..tostring(context.cardarea))
				--print(tostring(card.ability.extra.rank)..': '..tostring(context.other_card.base.value == card.ability.extra.rank))
				return {
					p_dollars = card.ability.extra.money
				}
			end
			if context.end_of_round and context.game_over == false then
				local valid_idol_cards = {}
    			for k, v in ipairs(G.playing_cards) do
    			    if v.ability.effect ~= 'Stone Card' then
    			        if not SMODS.has_no_suit(v) and not SMODS.has_no_rank(v) then
    			            valid_idol_cards[#valid_idol_cards+1] = v
    			        end
    			    end
    			end
    			if valid_idol_cards[1] then 
    			    local idol_card = pseudorandom_element(valid_idol_cards, pseudoseed('idol'..G.GAME.round_resets.ante))
    			    card.ability.extra.rank = idol_card.base.value
    			    return {
						message = localize(card.ability.extra.rank, 'ranks')
					}
    			end
			end
		end,
		post_setup = function(self)
			SMODS.Font {
				key = 'SegoePrint',
    		    path = "segoeprb.ttf",
				TEXT_HEIGHT_SCALE = 0.57, 
        		TEXT_OFFSET = {x=0,y=-65}, 
    		}
		end,
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'gc',
		y = 1, x = 2,
		config = { extra = { chips = 0, max_cards = 5, c_c = 0, alloc = false } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.max_cards,
				card.ability.extra.chips,
				card.ability.extra.max_cards - card.ability.extra.c_c,
			} }
		end,
		rarity = 3,
		cost = 8,
		blueprint_compat = false,
		calculate = function(self, card, context)
			if context.joker_main and card.ability.extra.chips > 0 then
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				}
			end
			if context.discard and context.other_card and not context.blueprint then
				if card.ability.extra.c_c < card.ability.extra.max_cards then
					local oc = context.other_card
					local chip_mod =  oc:get_chip_bonus() + ((oc.edition and oc.edition.foil) and 50 or 0)
					card.ability.extra.chips = card.ability.extra.chips + chip_mod
					card.ability.extra.c_c = card.ability.extra.c_c + 1
					SMODS.calculate_context({remove_playing_cards = true, removed = {oc}})
					return {
						func = function()
							G.E_MANAGER:add_event(Event({
								delay = 1,
								trigger = 'before',
								func = function()
									oc:juice_up(0.3, 0.3)
                					if SMODS.shatters(oc) then oc:shatter()
									else oc:start_dissolve() end
									card_eval_status_text(card, 'extra', nil, nil, nil, {
										message = localize { type = 'variable', key = 'a_chips', vars = { chip_mod } },
										colour = G.C.CHIPS,
										instant = true
									})
									return true
								end
							}))
							if card.ability.extra.c_c == card.ability.extra.max_cards and not card.ability.extra.alloc then
								G.E_MANAGER:add_event(Event({
									trigger = 'before',
									func = function()
										card.ability.extra.alloc = true
										card_eval_status_text(card, 'extra', nil, nil, nil, {
											message = localize('k_'..BalatrMod.prefix('gc_alloc_ex')), colour = G.C.FILTER,
											sound = 'tarot2'
										})
										return true
									end
								}))
							end
						end
					}
				end
			end
			if context.end_of_round and context.game_over == false then
				card.ability.extra.c_c = 0
				card.ability.extra.alloc = false
				if G.GAME.blind and G.GAME.blind.boss then
					card.ability.extra.chips = 0
					return {
						colour = G.C.FILTER,
						message = localize('k_'..BalatrMod.prefix('gc_dumped_ex')),
					}
				end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'fetus',
		y = 1, x = 3,
		config = { extra = { chips = 1, rounds_left = 9 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.chips,
			} }
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				}
			end
			if context.setting_blind then
				card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
				if card.ability.extra.rounds_left == 1 then
					return {
						message = localize('k_'..BalatrMod.prefix('fetus_kicking')),
						colour = G.C.SUITS.Hearts,
						func = function()
							juice_card_until(card, function(card)
								return card.ability.extra and card.ability.extra.rounds_left == 1
							end, true)
							return true
						end
					}
				elseif card.ability.extra.rounds_left == 0 then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							card:juice_up(0.3, 0.3)
							return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after', delay = 0.3,
						func = function()
							card:flip()
							return true
						end
					}))
					delay(0.4)
					G.E_MANAGER:add_event(Event({
						func = function()
							card:set_ability(G.P_CENTERS['j_joker'])
							return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after', delay = 0.3,
						func = function()
							card:flip()
							return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after', delay = 0.3,
						func = function()
							play_sound('tarot2')
							card_eval_status_text(card, 'jokers', nil, nil, nil, {
								message = localize({
									type='variable',
									key = 'k_'..BalatrMod.prefix('fetus_born'),
									vars = {
										localize {type = 'name_text',
											key = card.config.center.key,
											set = card.config.center.set
										}
									}}),
								colour = G.C.SUITS.Hearts, delay = 1.4
							})
							return true
						end
					}))
				end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'bdv',
		y = 1, x = 6,
		config = { extra = { debt = 10, chance = 10, bonus = 2 } },
		loc_vars = function(self, info_queue, card)
			local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
			return { vars = { 
				card.ability.extra.debt,
				a, b,
				card.ability.extra.bonus,
			} }
		end,
		cost = 15,
		calc_dollar_bonus = function(self, card)
			if SMODS.pseudorandom_probability(card, 'bdv', 1, card.ability.extra.chance) then
				return card.ability.extra.bonus
			end
		end,
		add_to_deck = function(self, card)
			G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.debt
		end,
		remove_from_deck = function(self, card)
			G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'blank',
		text = {
			"{C:inactive}Does nothing...?"
		},
		rarity = 1,
		cost = 1,
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	
	{
		id = 'aldi',
		y = 1, x = 7,
		config = { extra = { chance = 25, min = 0, max = 23 } },
		rarity = 1,
		cost = 2,
		loc_vars = function(self, info_queue, card)
			-- just take it from misprint brah
			local r_mults = {}
            for i = card.ability.extra.min, card.ability.extra.max do
                r_mults[#r_mults+1] = tostring(i)
            end
            local loc_mult = ' '..(localize('k_mult'))..' '
            local main_start = nil
			
			if not card.debuff then main_start = {
                {n=G.UIT.T, config={text = '+',colour = G.C.MULT, scale = 0.32}},
                {n=G.UIT.O, config={colour = G.C.MULT, object = DynaText({string = r_mults, colours = {G.C.MULT}, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0})}},
                {n=G.UIT.O, config={colour = G.C.MULT, object = DynaText({string = {
                    {string = 'rand()', colour = G.C.JOKER_GREY},{string = "#@"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'D'), colour = G.C.RED},
                    loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult},
                colours = {G.C.UI.TEXT_DARK},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
            } end
			return { vars = { 
				SMODS.get_probability_vars(card, 1, card.ability.extra.chance),
			}, main_end = main_start }
		end,
		-- this is JUST so we can put "+??? mult" next to "to give"
		-- instead of putting it at the bottom. FUCK This game
		generate_ui = function(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
			local vars = _c.create_fake_card and _c.loc_vars and (_c:loc_vars({}, _c:create_fake_card()) or {})
			full_UI_table.name = localize{type = 'name', set = _c.set, key = _c.key, nodes = full_UI_table.name}
            localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, fixed_scale = 0.63, no_pop_in = true, no_shadow = true, y_offset = 0, no_spacing = true, no_bump = true, vars = (vars.vars) or {colours = {}}}
			if vars.main_end then
				local last_line = desc_nodes[#desc_nodes]
				table.insert(vars.main_end, 1, last_line[1])
				desc_nodes[#desc_nodes] = vars.main_end
			end
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				if SMODS.pseudorandom_probability(card, 'aldi', 1, card.ability.extra.chance) then
					local temp_Mult = pseudorandom('misprint', card.ability.extra.min, card.ability.extra.max)
                	return {
                	    message = localize{type='variable',key='a_mult',vars={temp_Mult}},
                	    mult_mod = temp_Mult
                	}
				else
					return {
                	    message = localize('k_nope_ex'),
                	    colour = G.C.PURPLE
                	}
				end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'atomic_bomb',
		y = 1, x = 8,
		rarity = 3,
		cost = 5,
		config = { extra = { ec = 1000, em = 1000 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.ec,
				card.ability.extra.em,
			} }
		end,
		post_setup = function(self)
			self.eternal_compat = false
			local og___love_draw = love.draw
			BalatrMod.flashbang_level = 0
			function love.draw()
				if BalatrMod.flashbang_level <= 0 then
					og___love_draw()
					return
				end
				local dt = 1 / love.timer.getFPS()
				BalatrMod.flashbang_level = math.max(0, BalatrMod.flashbang_level - (dt * 0.1))
				local w, h, mode = love.window.getMode()
				if BalatrMod.flashbang_level > 0 then
					-- fill screen with black
					-- hopefully for those pesky CRT setting users to
					-- not see those white lines after
					love.graphics.setColor(0, 0, 0, 1)
					love.graphics.rectangle("fill", 0, 0, w, h)

					-- reset sprites
					love.graphics.setColor(G.C.WHITE)
					love.graphics.setBlendMode('alpha')
				end
				og___love_draw()
				if BalatrMod.flashbang_level > 0 then
					--love.graphics.setColor(G.GAME.blind.config.blind.boss_colour)
					love.graphics.setColor(BalatrMod.flashbang_level, BalatrMod.flashbang_level, BalatrMod.flashbang_level, 1)
					love.graphics.setBlendMode("add", "premultiplied")
            		love.graphics.rectangle("fill", 0, 0, w, h)
					love.graphics.setBlendMode('alpha')
					G.ROOM.jiggle = G.ROOM.jiggle + BalatrMod.flashbang_level * dt * 99
				end
			end
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {
					e_chips = card.ability.extra.ec,
					e_mult = card.ability.extra.em,
					remove_default_message = true,
					func = function()
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								BalatrMod.flashbang_level = 2
								-- i know the sound is misleading making u believe
								-- its ^^^1000 but cmonnn theyre funnier
								play_sound('talisman_eeemult')
								play_sound('talisman_eeemult', 0.25)
								play_sound('talisman_eeechip')
								play_sound('talisman_eeechip', 0.5)
								play_sound(BalatrMod.prefix('ultra_fart'), 0.3, 5)
								play_sound('tarot1')
								card.T.r = -0.2
								card:juice_up(0.3, 0.4)
								card.states.drag.is = true
								card.children.center.pinch.x = true
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.3,
									func = function()
										G.jokers:remove_card(card)
										card:remove()
										card = nil
										return true;
									end
								}))
								return true
							end
						}))
					end
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'duke',
		rarity = 2,
		cost = 3,
		config = { extra = { x_chips = 3, active = true } },
		loc_vars = function(self, info_queue, card)
			--TODO: actually detect java
			local active = card.ability.extra.active
			return { vars = { 
				card.ability.extra.x_chips
			}, main_end = {
                {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                    {n=G.UIT.C, config={ref_table = self, align = "m", colour = active and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06}, nodes={
                        {n=G.UIT.T, config={text = ' '..localize(active and 'k_active' or 'k_inactive')..' ',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.9}},
                    }}
                }}
            } }
		end,
		calculate = function(self, card, context)
			if context.joker_main and card.ability.extra.active then
				return {
					x_chips = card.ability.extra.x_chips
				}
			end
		end

	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'admin_card',
		y = 2, x = 5,
		rarity = 2,
		cost = 3,
		config = { extra = { x_chips = 5, chance = 5, hands = 1 } },
		post_setup = function(self)
			self.eternal_compat = false
		end,
		loc_vars = function(self, info_queue, card)
			local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
			return { vars = { 
				card.ability.extra.x_chips,
				a, b,
				card.ability.extra.hands,
			} }
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				card.ability.extra.gonna_do_it = SMODS.pseudorandom_probability(card, 'among_us_in_real_life', 1, card.ability.extra.chance) and (to_big(G.GAME.chips) > to_big(0))
				if not card.ability.extra.gonna_do_it then return {
					x_chips = card.ability.extra.x_chips
				} end
			end
			if context.after then
				if card.ability.extra.gonna_do_it then
					return {
						func = function()
							G.E_MANAGER:add_event(Event({
							func = function()
								ease_background_colour{new_colour = lighten(G.C.RED, 0.2), special_colour = darken(G.C.RED, 0.1), contrast = 10}
								play_sound('chips2')
								BalatrMod.nope()
								play_sound(BalatrMod.prefix('impostor_killMusic'))
								G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.1)
								G.ROOM.jiggle = G.ROOM.jiggle + 4
								return true
							end
							}))
							G.E_MANAGER:add_event(Event({
            				    trigger = 'ease',
            				    ref_table = G.GAME, ref_value = 'chips',
            				    ease_to = to_big(G.GAME.chips) / to_big(2),
            				    delay = 1,
								blocking = false,
								func = function(t) return math.floor(t) end
            				}))
							card_eval_status_text(card, 'jokers', nil, nil, nil, {
								message = '>:)',
								colour = G.C.RED, delay = 2 * G.SETTINGS.GAMESPEED
							})
							G.E_MANAGER:add_event(Event({
							func = function()
									play_sound('tarot1')
									card.T.r = -0.2
									card:juice_up(0.3, 0.4)
									card.states.drag.is = true
									card.children.center.pinch.x = true
									ease_hands_played(card.ability.extra.hands)
									G.E_MANAGER:add_event(Event({
										trigger = 'after',
										delay = 0.3,
										func = function()
											G.jokers:remove_card(card)
											card:remove()
											card = nil
											return true;
										end
									}))
									return true
								end
							}))
						end
					}
				end
			end
		end,
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'skeleton',
		rarity = 2,
		cost = 3,
		config = { extra = { chance = 6, xmult = 3, amount = 3 } },
		loc_vars = function(self, info_queue, card)
			local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
			return { vars = { 
				a, b,
				card.ability.extra.xmult,
				card.ability.extra.amount,
			} }
		end,
		calculate = function(self, card, context)
			if context.joker_main and SMODS.pseudorandom_probability(card, 'raaahhh', 1, card.ability.extra.chance) then
				return {
					remove_default_message = true,
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = 'before',
							delay = 0.2 * G.SETTINGS.GAMESPEED,
							blocking = true,
							func = function()
								play_sound(BalatrMod.prefix('raaar'), 1, 0.7)
								return true
							end
						}))
						for i = 1, card.ability.extra.amount do
							local amount = card.ability.extra.xmult
							local tracked = mult
							mult = mod_mult(mult * amount)
							G.E_MANAGER:add_event(Event({
								trigger = 'before',
								-- we do this stupid calculation for Consistency with the original sfx
								delay = 0.6 * G.SETTINGS.GAMESPEED * (G.SETTINGS.GAMESPEED / G.SPEEDFACTOR),
								blocking = true,
								func = function()
									for i = 1, 4 do
										play_sound('timpani', 0.9 + (math.random() * 0.1))
									end
									play_sound('gong', 11.4 / 12, 0.15)
									tracked = tracked * amount
									update_hand_text({delay = 0, immediate = true}, {mult = tracked})
									card_eval_status_text(card, 'x_mult', amount, 1, 'up', {instant = true})
									--print('BROTHER')
									return true
								end
							}))
						end
					end
				}
			end
		end

	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'bunny',
		y = 2, x = 6,
		rarity = 3,
		cost = 5,
		-- colors are functions Solely because of gradients. i want them to be animated
		available_ops = {
			["+"] = {
				key = 'chips',
				sound = 'chips1',
				weight = 2, -- TODO: make this work
				bg = function() return G.C.CLEAR end,
				col = function() return G.C.CHIPS end
			},
			["X"] = {
				key = 'x_chips',
				sound = 'xchips',
				weight = 2,
				bg = function() return G.C.CHIPS end,
				col = function() return G.C.WHITE end,
			},
			["^"] = {
				key = 'e_chips',
				sound = 'talisman_echip',
				bg = function() return G.ARGS.LOC_COLOURS[BalatrMod.prefix('e_chips')] end,
				col = function() return G.C.WHITE end,
			},
			["^^"] = {
				key = 'ee_chips',
				sound = 'talisman_eechip',
				bg = function() return G.ARGS.LOC_COLOURS[BalatrMod.prefix('e_chips')] end,
				col = function() return G.C.EDITION end,
			},
			["^^^"] = {
				key = 'eee_chips',
				sound = 'talisman_eeechip',
				weight = 0.5,
				bg = function() return G.C.DARK_EDITION end,
				col = function() return G.ARGS.LOC_COLOURS[BalatrMod.prefix('e_chips')] end,
			}
		},
		config = { extra = { operator = "+", chips = 3 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.operator,
				card.ability.extra.chips,
				colours = {
					self.available_ops[card.ability.extra.operator].col(),
					self.available_ops[card.ability.extra.operator].bg()
				}
			} }
		end,
		set_sprites = function(self, card, front)
			if not card.config.center.discovered and not card.bypass_discovery_center then
				return
			end
			card.children.front = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[BalatrMod.prefix('jokersrealnofake')], {x = 7, y = 2})
			card.children.front.states.hover = card.states.hover
			card.children.front.states.click = card.states.click
			card.children.front.states.drag = card.states.drag
			card.children.front.states.collide.can = false
			card.children.front:set_role({major = card, role_type = 'Glued', draw_major = card})
		end,
		draw = function(self, card, layer)
			if card.children.front then
				-- bounce to bpm
				local bounce = math.abs(math.sin(((BalatrMod.music_time or 0) * ((150 * 0.7) / 60)) * math.pi))
				bounce = 1 - math.pow(1 - bounce, 5 / 3)
				local bounce_offset = bounce * (-4.5 / (G.TILE_H * 2))
				local pixel = 1 / (G.TILE_H * 2)
				card.children.front.VT.y = card.children.center.VT.y + (math.floor(bounce_offset / pixel) * pixel)
			end
		end,
		post_setup = function(self, this)
			self.available_ops = this.available_ops
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {
					[self.available_ops[card.ability.extra.operator].key] = card.ability.extra.chips,
				}
			end
			if context.end_of_round and context.game_over == false then
				return {
					func = function()
						G.E_MANAGER:add_event(Event {
							func = function()
								local ops = {}
								for k, v in pairs(self.available_ops) do
									table.insert(ops, k)
								end
								card.ability.extra.operator = pseudorandom_element(ops, 'bouncing_bunny')
								card_eval_status_text(card, 'jokers', nil, nil, nil, {
									message = card.ability.extra.operator..tostring(card.ability.extra.chips),
									colour = G.C.DARK_EDITION, sound = self.available_ops[card.ability.extra.operator].sound,
									volume = 0.4, pitch = 1.7
								})
								return true
							end
						})
					end
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'jimbius',
		x = 9,
		config = { extra = { mult = 999, Xmult = 66, blood_fury = 0, ndmt = 0, hands_fury = 666, ndmt_whirl = 666, whirlpool = false, __whirlpool_message = false } },
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue+1] = G.P_CENTERS['e_'..BalatrMod.prefix('demonic')]
			return { vars = {
				card.ability.extra.mult,
				card.ability.extra.Xmult,
				card.ability.extra.blood_fury,
				card.ability.extra.ndmt,
				card.ability.extra.hands_fury,
				card.ability.extra.ndmt_whirl,
				localize(card.ability.extra.whirlpool and 'k_active' or 'k_inactive'),
				colours = {
					HEX('990033'),
					card.ability.extra.whirlpool and G.C.GREEN or G.C.RED
				}
			} }
		end,
		cost = 6,
		rarity = 3,
		-- ok MAYYYBE i shouldnt be doing this on draw????
		draw = function(self, card, layer)
			if (not card.children.particles) and card.ability.extra.__whirlpool_message then
				card.children.particles = Particles(0, 0, 0,0, {
    			    timer = 0.03,
    			    scale = 0.4,
    			    speed = 3,
    			    lifespan = 1,
    			    attach = card,
    			    colours = {G.C.RED, G.C.ORANGE, G.C.BLACK},
    			    fill = true
    			})
    			card.children.particles.static_rotation = true
    			card.children.particles:set_role {
    			    role_type = 'Minor',
    			    xy_bond = 'Weak',
    			    r_bond = 'Strong',
    			    major = card,
    			}
			end
		end,
		calculate = function(self, card, context)
			local x = card.ability.extra -- not writing all that
			if context.joker_main then
				x.blood_fury = x.blood_fury + 1
				if x.blood_fury < x.hands_fury then
					return {
						message = "+1",
						colour = HEX('990033'),
					}
				else
					x.ndmt = x.ndmt + 64
					if x.ndmt < x.ndmt_whirl then
						return {
							mult_mod = x.mult,
							func = function()
								card_eval_status_text(card, 'jokers', nil, nil, nil, {
									message = localize { type = 'variable', key = 'a_mult', vars = { x.mult } },
									colour = G.C.MULT,
								})
								card_eval_status_text(card, 'jokers', nil, nil, nil, {
									message = '+64 NDMT',
									colour = HEX('990033'),
								})
							end
						}
					end
					return {
						Xmult_mod = x.Xmult,
						message = localize { type = 'variable', key = 'a_xmult', vars = { x.Xmult } }
					}
				end
			end
			if context.after and x.ndmt >= x.ndmt_whirl then
				if not x.whirlpool then
					x.whirlpool = true
					return {
						func = function()
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								blockable = true,
								delay = 1,
								func = function()
									BalatrMod.nope()
									card:juice_up()
									ease_background_colour{new_colour = G.C.BLACK, contrast = 0}
									return true
								end
							}))
							for i = 1, 6 do
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									blockable = true,
									delay = 0.75,
									func = function()
										-- "pitch cannot be negative" sybau
										G.PITCH_MOD = math.max(0, G.PITCH_MOD - (0.05 * i))
										card:flip()
										play_sound('cardSlide2', 0.5 + ((i - 1) * 0.15), i * 0.25)
										return true
									end
								}))
							end
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								blockable = true,
								func = function()
									card.ability.extra.__whirlpool_message = true
									card:juice_up(1, 3)
									G.PITCH_MOD = 0
									G.ROOM.jiggle = G.ROOM.jiggle + 6
									BalatrMod.flashbang_level = 0.5
									play_sound('talisman_emult')
									ease_background_colour{new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 6}
									if not G.SETTINGS.reduced_motion then
										G.ARGS.spin.amount = 6
									end
									local destroyed_cards = {}
									for k, v in pairs(G.hand.cards) do
										destroyed_cards[#destroyed_cards + 1] = v
										v:juice_up(0.3, 0.3)
                						if SMODS.shatters(v) then
                						    v:shatter()
                						else
                						    v:start_dissolve()
                						end
									end
									if destroyed_cards[1] then
										SMODS.calculate_context({remove_playing_cards = true, removed = destroyed_cards})
									end
									return true
								end
							}))
							card_eval_status_text(card, 'jokers', nil, 1, nil, {
								message = localize('k_'..BalatrMod.prefix('whirlpool_active')),
								colour = G.C.SUITS['Hearts'],
								delay = 2,
								sound = BalatrMod.prefix("demonic"),
								volume = 5
							})
						end
					}
				end
			end
			if context.hand_drawn and card.ability.extra.whirlpool then -- during a blind
				return {
					func = function()
						for k, v in pairs(context.hand_drawn) do
							if not (v.edition and v.edition[BalatrMod.prefix('demonic')]) then
								v:set_edition('e_'..BalatrMod.prefix('demonic'))
							end
						end
					end
				}
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'idk',
		y = 1, x = 4,
		soul_pos = {x = 5, y = 1},
		rarity = 4,
		cost = 10,
		unlocked = false,
		config = { extra = { bonuses = {
			['perma_bonus'] = 'BLUE',
			['perma_mult'] = 'RED',
			['perma_x_chips'] = 'BLUE',
			['perma_x_mult'] = 'RED',
			['perma_h_chips'] = 'BLUE',
			['perma_h_mult'] = 'RED',
			['perma_h_x_chips'] = 'BLUE',
			['perma_h_x_mult'] = 'RED',
			['perma_p_dollars'] = 'GOLD',
			['perma_h_dollars'] = 'GOLD',
			['perma_repetitions'] = 'FILTER',
		} } },
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play then
				local keys = {}
				for k, _ in pairs(card.ability.extra.bonuses) do
					table.insert(keys, k)
				end

				local oc = context.other_card
				if oc and not oc.debuff then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.6,
						blocking = true,
						func = function()
							local chosen = pseudorandom_element(keys, 'idkrandombonus')
							oc.ability[chosen] = oc.ability[chosen] or (chosen:find('x_') and 1 or 0)
							oc.ability[chosen] = oc.ability[chosen] + 1
							card:juice_up(0.3, 0.3)
							oc:juice_up()
							--TODO: actually make these show up (implement them)
							--betty from the future here, its better to just do builtin stickers instead
							oc:add_sticker(BalatrMod.prefix('idk'), true)
							card_eval_status_text(card, 'extra', nil, nil, nil, {
								message = localize('k_upgrade_ex'), colour = G.C[card.ability.extra.bonuses[chosen]],
								sound = 'tarot2', instant = true
							})
							return true
						end
					}))
				end
        	end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'c_',
		y = 2, x = 1,
		soul_pos = {x = 2, y = 2},
		rarity = 4,
		cost = 10,
		unlocked = false,
		config = { },
		--[[
			"why joker, and not voucher??"
			with the currently implemented legendary jokers as of writing (idk, :tiny:),
			iv enoticed they both break the game requiring you to keep them
			so i wanted to do another one. lmao
		]]
		calculate = function(self, card, context)
			if (context.open_booster or context.ending_booster) and G[BalatrMod.prefix('discard_pack')] then
				G[BalatrMod.prefix('discard_pack')]:remove()
				G[BalatrMod.prefix('discard_pack')] = nil
			end
			if context.other_drawn and not G[BalatrMod.prefix('discard_pack')] then
				local text_scale = 0.45
    			local button_height = 1.3
				local butt = {n=G.UIT.C, config={id = 'discard_button',align = "tm", padding = 0.3, r = 0.1, minw = 2.5, minh = button_height, hover = true, colour = G.C.RED, button = BalatrMod.prefix('discard_cards_in_pack'), shadow = true, func = BalatrMod.prefix('can_discard_in_pack')}, nodes={
    			  {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
    			      {n=G.UIT.O, id='reroll_text', config = {
							object = DynaText({
								string = localize('k_reroll'),
								silent = true,
								scale = text_scale,
								colours = {G.C.UI.TEXT_LIGHT},
								float = true
							}),
						focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}
    			  }},
    			  {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
    			      {n=G.UIT.T, config={ref_table = SMODS.hand_limit_strings, ref_value = 'discard', scale = text_scale * 0.65, colour = G.C.UI.TEXT_LIGHT}}
    			  }},
    			}}
				G[BalatrMod.prefix('discard_pack')] = UIBox {
					definition = butt,
					config = {
        				align = 'tr',
						offset = {x = 0.9, y = -3},
        				major = G.hand
					}
				}
        	end
		end,
		post_setup = function(self)
			G.FUNCS[BalatrMod.prefix('can_discard_in_pack')] = function(e)
				if BalatrMod.__reroll_helper_var or G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 or #G.hand.highlighted > math.max(G.GAME.starting_params.discard_limit, 0) then 
					e.config.colour = G.C.UI.BACKGROUND_INACTIVE
					e.config.button = nil
				else
					e.config.colour = SMODS.Gradients[BalatrMod.prefix('rainbow')] -- why cant i use G.C :sob:
					e.config.button = BalatrMod.prefix('discard_cards_in_pack')
				end
			end
			G.FUNCS[BalatrMod.prefix('discard_cards_in_pack')] = function(e, hook)
				if not BalatrMod.__reroll_helper_var then
					BalatrMod.__reroll_helper_var = true
				else return end
				local prev_state = G.STATE
				
				stop_use()
    			G.CONTROLLER.interrupt.focus = true
    			G.CONTROLLER:save_cardarea_focus('hand')

    			for k, v in ipairs(G.playing_cards) do
    			    v.ability.forced_selection = nil
    			end
			
    			if G.CONTROLLER.focused.target and G.CONTROLLER.focused.target.area == G.hand then G.card_area_focus_reset = {area = G.hand, rank = G.CONTROLLER.focused.target.rank} end
    			local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
    			if highlighted_count > 0 then 
    			    table.sort(G.hand.highlighted, function(a,b) return a.T.x < b.T.x end)
    			    for i=1, highlighted_count do
    			    	draw_card(G.hand, G.deck, i*100/highlighted_count, 'down', false, G.hand.highlighted[i])
					end
					delay(0.3) -- this is why i cant use the same loop for the bottom one
					for i=1, highlighted_count do
						G.E_MANAGER:add_event(Event({
            			    func = function()
								draw_card(G.deck, G.hand, i*100/highlighted_count, 'up', true, G.deck.cards[#G.deck.cards - i])
            			        return true
            			    end
            			}))
    			    end
    			end

				if not hook then
            		if G.GAME.modifiers.discard_cost then
            		    ease_dollars(-G.GAME.modifiers.discard_cost)
            		end
					--G.STATE = G.STATES[BalatrMod.prefix('DRAW_TO_HAND_FROM_BOOSTER')]
            		G.E_MANAGER:add_event(Event({
            		    trigger = 'immediate',
            		    func = function()
            		        G.STATE = prev_state
							BalatrMod.__reroll_helper_var = nil
            		        return true
            		    end
            		}))
        		end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'tiny',
		y = 1, x = 9,
		soul_pos = {x = 0, y = 2},
		rarity = 4,
		cost = 10,
		unlocked = false,
		config = { extra = { cards = 1 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.cards
			} }
		end,
		add_to_deck = function(_, card, from_debuff)
			SMODS.change_play_limit(1); SMODS.change_discard_limit(1);
		end,
		remove_from_deck = function(_, card, from_debuff)
			SMODS.change_play_limit(-1); SMODS.change_discard_limit(-1);
		end,
	},

	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'paradise',
		y = 2, x = 3,
		soul_pos = {x = 4, y = 2},
		rarity = 4,
		cost = 17,
		unlocked = false,
		config = { extra = { chance = 17, rounds = 3, rounds_left = 3, joker = nil } },
		loc_vars = function(self, info_queue, card)
			local center = G.P_CENTERS[card.ability.extra.joker]
			local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
			return { vars = { 
				a, b,
				card.ability.extra.rounds_left
			}, main_end = {
                {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                    {n=G.UIT.C, config={ref_table = self, align = "m", colour = center and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06}, nodes={
                        {n=G.UIT.T, config={text = ' '..(center and localize{type = 'name_text', key = center.key, set = center.set} or localize('k_none'))..' ',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.9}},
                    }}
                }}
            } }
		end,
		calculate = function(self, card, context)
			if not card.ability.extra.joker then
				if context.after then
					if SMODS.pseudorandom_probability(card, 'betty be like: "im going to finish oc lore!!!" no you wont bitch 😂😂 Procrastination is coming', 1, card.ability.extra.chance) then
						-- should i check for clones? i dont think it matters
						local deletable_jokers = {}
        				for k, v in pairs(G.jokers.cards) do
        				    if not SMODS.is_eternal(v)
							and v.config.center.key ~= card.config.center.key -- do not delete itself
							then deletable_jokers[#deletable_jokers + 1] = v end
        				end
						local chosen_joker = pseudorandom_element(deletable_jokers, pseudoseed('erase_this_joker_from_reality_pls'))

						if not chosen_joker then
							return
						end

						local is_eternal = SMODS.is_eternal(chosen_joker)

						if not is_eternal then
							card_eval_status_text(chosen_joker, 'extra', nil, nil, nil, {
								message = localize('k_'..BalatrMod.prefix('purged_ex')),
								colour = G.C.BLACK,
								sound = 'cancel', delay = 2
							})
							G.E_MANAGER:add_event(Event({
								trigger = "before",
								delay = 1.0,
								blocking = true,
								func = function()
									local key = chosen_joker.config.center.key
									G.GAME.banned_keys[key] = true
									card.ability.extra.joker = key

									play_sound('negative', 0.96)
									play_sound('crumple'..math.floor(1 + (math.random() * 5)), 1, 2)
									play_sound('crumple'..math.floor(1 + (math.random() * 5)), 0.7, 2)
									play_sound('tarot2', 1.4)
									chosen_joker.states.drag.can = false
									chosen_joker.area:remove_card(chosen_joker)
									chosen_joker.T.y = chosen_joker.T.y + 4
									return true
								end
							}))

							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 2.0,
								blocking = false,
								func = function()
									chosen_joker:remove()
									return true 
								end
							}))
						else
							card_eval_status_text(chosen_joker, 'extra', nil, nil, nil, {
								message = localize('k_nope_ex'),
								colour = SMODS.Gradients[BalatrMod.prefix('rainbow')],
								sound = 'tarot2'
							})
						end
					end
        		end
			else
				if context.setting_blind then
					card.ability.extra.rounds_left = math.max(0, card.ability.extra.rounds_left - 1)
					if card.ability.extra.rounds_left > 0 then
						return {
							message = tostring(card.ability.extra.rounds_left)
						}
					end

					if G.jokers.config.card_count >= G.jokers.config.card_limits.total_slots then
						return {
							message = localize('k_no_space_ex')
						}
					end

					G.GAME.banned_keys[card.ability.extra.joker] = nil
					local replica = SMODS.create_card {key = card.ability.extra.joker, edition = 'e_'..BalatrMod.prefix('replica')}
					replica:add_to_deck()
            		G.jokers:emplace(replica)

					card.ability.extra.rounds_left = card.ability.extra.rounds
					card.ability.extra.joker = nil
					return {
						message = tostring(card.ability.extra.rounds_left),
						func = function()
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								blocking = false,
								func = function()
									G.PITCH_MOD = math.max(0, G.PITCH_MOD - 0.1717)
									card_eval_status_text(replica, 'extra', nil, nil, nil, {
										message = localize('k_copied_ex'), colour = G.C.BLACK,
									})
									return true 
								end
							}))
						end
					}
				end
			end
		end
	},

	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
}
--[[
return {
	n = G.UIT.O,
	config = {
		object = DynaText({
			string = arr,
			pop_in_rate = 9999999,
			silent = true,
			random_element = true,
			pop_delay = 0.1,
			scale = 0.4,
			min_cycle_time = 0,
		}),
	},
}
]]
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
local joker_extra_vars = {
	'blueprint_compat', 'eternal_compat', 'perishable_compat',
	'pixel_size', 'soul_pos', 'calc_dollar_bonus', 'in_pool',
	'update', 'draw', 'set_sprites', 'set_ability', 'add_to_deck',
	'remove_from_deck', 'load', 'check_for_unlock', 'set_badges',
	'set_card_type_badge', 'generate_ui'
}
for k, i in ipairs(jokers) do
	local j = {
		key = i.id or k,
		atlas = i.atlas or 'jokersrealnofake',
		pos = {x = i.x or 0, y = i.y or 0},
		cost = i.cost or 1,
		rarity = i.rarity or 1,
		loc_txt = {
			
			text = i.text or {"..."}
		},
		loc_vars = i.loc_vars or function(self, info_queue, card)
			return {}
		end,
		config = i.config,
		unlocked = i.unlocked or true,
    	discovered = i.discovered or false,
		pools = i.pools or {},

		-- unsafe (?) params
		calculate = i.calculate
	}
	for _, k in ipairs(joker_extra_vars) do
		if i[k] then
			j[k] = i[k]
		end
	end
	if i.post_setup ~= nil then
		i.post_setup(j, i)
	end
	SMODS.Joker(j)
end