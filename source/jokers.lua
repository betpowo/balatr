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
		id = 'jokoj',
		x = 1,
		name = 'JokoJ',
		text = {
			"{C:inactive}/jo - qwuj/{}",
			"{C:chips}+#1#{} Chips",
			"if played hand is",
			"a {C:attention}palindrome{}",
			"{C:inactive}(ex: {C:attention}4 3 2 3 4{C:inactive})"
		},
		config = { extra = { chips = 250 } },
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
		text = {
			"{C:inactive}/ruh - kur/{}",
			"{C:mult}+#1#{} Mult",
			"if played hand is",
			"a {C:attention}palindrome{}",
			"{C:inactive}(ex: {C:attention}4 3 2 3 4{C:inactive})"
		},
		config = { extra = { mult = 16 } },
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
		text = {
			"mmm...macaron",
			"{X:mult,C:white}X#1#{} Mult",
            "{C:mult}-1{} at end of round",
		},
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
						message = 'Eaten!'
					}
				else
					return {
						message = '-X1 Mult!',
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
		name = 'El Gato Balatro',
		text = {
			"{C:chips}+#1#{} Chips",
			"for every {C:diamonds}Diamond{} card",
			"played, also plays a sound"
		},
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
			self.pools = { ["Cat"] = true }
			SMODS.Sound {
				key = 'whatsapp',
				path = 'whatsapp.ogg',
				pitch = 1
			}
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'super_f',
		x = 5,
		name = "SUPER F",
		text = {
			"Each played {C:attention}2{} gives",
			"{C:mult}+#1#{} Mult when scored",
		},
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
		name = 'FUCK YUO',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
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
		id = 'balatr',
		x = 8,
		name = 'Balatr',
		text = {
			"Will send you to",
			"the title screen",
		},
		rarity = 1,
		cost = 1,
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
		id = 'jimbius',
		x = 9,
		name = "{C:mult}Demonic Warrior Jimbius{}",
		text = {
			"{C:inactive}(Age: 16) (Personality: Dangerous){}",
			"Destroy all other jokers.",
			"With each played hand, increase {C:attention}Blood Fury{}.",
			"At {C:attention}666{} Blood Fury, gain {C:mult}+#1#{} Mult and a stack",
			"of {C:dark_edition}Nightmare Demon Mode Tokens{}. At {C:attention}666{}",
			"Nightmare Demon Mode Tokens {C:inactive}(NDMT){}, gain",
			"{X:mult,C:white}X#2#{} Mult and activate {C:hearts,E:1}Whirlpool of Destruction{}.",
			"{C:hearts,E:1}Whirlpool of Destruction{} deletes all cards in your",
			"hand but adds a {C:dark_edition}Demonic Energy Filter{} to all future drawn cards",
			"-----",
			"{C:inactive}Blood Fury{}: {C:attention}#3#{} | {C:dark_edition}NDMT{}: {C:attention}#4#{}"
		},
		config = { extra = { mult = 999, Xmult = 66, blood_fury = 0, ndmt = 0, hands_fury = 6, ndmt_whirl = 6, whirlpool = false } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.mult, card.ability.extra.Xmult, card.ability.extra.blood_fury, card.ability.extra.ndmt } }
		end,
		cost = 6,
		rarity = 3,
		calculate = function(self, card, context)
			if context.joker_main then
				local x = card.ability.extra -- not writing all that
				x.blood_fury = x.blood_fury + 1
				if x.blood_fury < x.hands_fury then
					return {
						message = "+1 Blood Fury!"
					}
				else
					x.ndmt = x.ndmt + 64
					if x.ndmt < x.ndmt_whirl then
						return {
							mult_mod = x.mult,
							message = localize { type = 'variable', key = 'a_mult', vars = { x.mult } } .. ' | +64 NDMT!'
						}
					end
					return {
						Xmult_mod = x.Xmult,
						message = localize { type = 'variable', key = 'a_Xmult', vars = { x.Xmult } }
					}
				end
			end
		end
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'slothful',
		y = 1,
		name = 'Slothful Joker',
		text = {
			"Played cards with",
			"{C:"..BalatrMod.prefix('blorbs').."}Blorb{} suit give",
			"{C:mult}+#1#{} Mult when scored"
		},
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
		name = 'Gambler',
		text = {
			"{X:mult,C:white}X#1#{} Mult and {C:money}$#3#",
			"on a {C:chips,E:2}certain condition,",
			"{X:mult,C:white}X#2#{} Mult and {C:red}-$#4#{} otherwise",
		},
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
									message = 'Jackpot!', colour = G.C.GOLD,
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
		id = 'gc',
		y = 1, x = 2,
		name = 'Garbage Collector',
		text = {
			"Destroys up to {C:attention}#1#{} {C:inactive}(#3#){}",
			"{C:red}discarded{} cards per round and",
			"adds their {C:chips}chips{} to this Joker",
			"{C:inactive}(Currently {}{C:chips}+#2#{}{C:inactive} Chips){}",
			"{C:inactive}(Resets after {}{C:attention}Boss{}{C:inactive} Blind){}"
		},
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
					local chip_mod =  oc.base.nominal + oc.ability.bonus + ((oc.edition and oc.edition.foil) and 50 or 0)
					--SMODS.destroy_cards(oc) -- this wont actually remove them for some reason ????
					card.ability.extra.chips = card.ability.extra.chips + chip_mod
					card.ability.extra.c_c = card.ability.extra.c_c + 1
					return {
						delay = 0.6,
						remove = true,
						message = localize { type = 'variable', key = 'a_chips', vars = { chip_mod } },
						colour = G.C.UI_CHIPS,
						func = function()
							G.E_MANAGER:add_event(Event({
								trigger = 'before',
								func = function()
									if card.ability.extra.c_c == card.ability.extra.max_cards and not card.ability.extra.alloc then
										card.ability.extra.alloc = true
										card_eval_status_text(card, 'extra', nil, nil, nil, {
											message = 'Allocated!', colour = G.C.FILTER,
											sound = 'tarot2'
										})
									end
									return true
								end
							}))
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
						message = 'Dumped!',
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
		name = 'Fetus',
		text = {
			"{C:chips}+#1#{} measly chip",
		},
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
						message = "It's kicking!",
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
							card:juice_up(0.3, 0.3)
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
		name = 'PagoMovil',
		text = {
			"Go up to {C:red}-$#1#{} in debt",
			"{C:green}#2# in #3#{} chance to earn",
			"{C:money}$#4#{} at end of round"
		},
		config = { extra = { debt = 10, chance = 10, bonus = 2 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.debt,
				G.GAME.probabilities.normal,
				card.ability.extra.chance,
				card.ability.extra.bonus,
			} }
		end,
		cost = 15,
		calculate = function(self, card, context)
		end,
		calc_dollar_bonus = function(self, card)
			if pseudorandom('bdv') < (G.GAME.probabilities.normal / card.ability.extra.chance) then
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
		name = 'Blank',
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
		name = 'Aldi',
		text = {
			"{C:green}#1# in #2#{} chance",
		},
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
            local main_start = {
				{n=G.UIT.T, config={text = 'to give ',colour = G.C.BLACK, scale = 0.32}},
                {n=G.UIT.T, config={text = '+',colour = G.C.MULT, scale = 0.32}},
                {n=G.UIT.O, config={object = DynaText({string = r_mults, colours = {G.C.RED},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0})}},
                {n=G.UIT.O, config={object = DynaText({string = {
                    {string = 'rand()', colour = G.C.JOKER_GREY},{string = "#@"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'D'), colour = G.C.RED},
                    loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult},
                colours = {G.C.UI.TEXT_DARK},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
            }
			return { vars = { 
				G.GAME.probabilities.normal,
				card.ability.extra.chance,
			}, main_end = main_start }
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				if pseudorandom('aldi') < (G.GAME.probabilities.normal / card.ability.extra.chance) then
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
		name = 'Atomic Bomb',
		text = {
			"{X:"..BalatrMod.prefix('e_chips')..",C:white}^#1#{} Chips and {X:"..BalatrMod.prefix('e_mult')..",C:white}^#2#{} Mult",
			"{C:red,E:2}self destructs{}"
		},
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
			-- TODO.: make talisman a dependency, i dont think i wanna handle exponentials myself
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
		id = 'idk',
		y = 1, x = 4,
		soul_pos = {x = 5, y = 1},
		name = 'IDK',
		text = {
			"Adds a {C:"..BalatrMod.prefix('rainbow').."}perma-bonus{}",
			"to every card scored",
		},
		rarity = 4,
		cost = 10,
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
		id = 'tiny',
		y = 1, x = 9,
		soul_pos = {x = 0, y = 2},
		name = ':tiny:',
		text = {
			"Be able to play",
			"{C:"..BalatrMod.prefix('rainbow').."}+#1#{} more card"
		},
		rarity = 4,
		cost = 10,
		config = { extra = { cards = 1 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.cards
			} }
		end,
		add_to_deck = function(_, card, from_debuff)
			-- i hate this game
			G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.extra.cards
			G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + card.ability.extra.cards
			G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit + card.ability.extra.cards
		end,
		remove_from_deck = function(_, card, from_debuff)
			G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - card.ability.extra.cards
			G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit - card.ability.extra.cards
			G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit - card.ability.extra.cards
		end,
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
			name = i.name or i.id,
			text = i.text or {"..."}
		},
		loc_vars = i.loc_vars or function(self, info_queue, card)
			return {}
		end,
		config = i.config,
		unlocked = true,
    	discovered = i.discovered or true,

		-- unsafe (?) params
		calculate = i.calculate
	}
	for _, k in ipairs(joker_extra_vars) do
		if i[k] then
			j[k] = i[k]
		end
	end
	if i.post_setup ~= nil then
		i.post_setup(j)
	end
	SMODS.Joker(j)
end