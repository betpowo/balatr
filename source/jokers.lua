SMODS.Atlas {
    key = "jokersrealnofake",
    path = "jokers real no fake.png",
    px = 71, py = 95,
}

SMODS.Sound {
	key = 'whatsapp',
	path = 'whatsapp.ogg',
	pitch = 1
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
			"if played hand",
			"can be {C:attention}flipped{}",
			"{C:inactive}(e.g. [4, 3, 2, 3, 4])"
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
			"if played hand",
			"can be {C:attention}flipped{}",
			"{C:inactive}(e.g. [4, 3, 2, 3, 4])"
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
			"{C:mult}+#1#{} Mult",
			"for every {C:attention}2{} played",
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
				delay = 3,
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
		cost = 4,
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
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_suit(BalatrMod.prefix('Blorbs')) then
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				}
			end
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
			"{X:mult,C:white}X#1#{} Mult on a {C:attention}certain condition,",
			"{X:mult,C:white}X#2#{} Mult otherwise",
		},
		config = { extra = { x_mult = 7, x_mult2 = 0.7 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.x_mult,
				card.ability.extra.x_mult2,
			} }
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {
					Xmult_mod = card.ability.extra.x_mult,
					message = localize { type = 'variable', key = 'a_Xmult', vars = { card.ability.extra.x_mult } },
				}
			end
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
			"{C:inactive}(Currently {}{C:chips}+#2#{}{C:inactive} Chips){}"
		},
		config = { extra = { chips = 0, max_cards = 5, c_c = 0 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { 
				card.ability.extra.max_cards,
				card.ability.extra.chips,
				card.ability.extra.c_c,

			} }
		end,
		rarity = 2,
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

					--print(oc.config.card_key)
					--print(chip_mod)

					SMODS.destroy_cards(oc)
            	    
					card.ability.extra.chips = card.ability.extra.chips + chip_mod
					card.ability.extra.c_c = card.ability.extra.c_c + 1

					return {
						colour = G.C.UI_CHIPS,
						message = localize { type = 'variable', key = 'a_chips', vars = { chip_mod } },
					}
				end
			end
			if context.destroying_card and not context.blueprint and not SMODS.is_eternal(context.destroying_card, card) then
    		    return {
    		        remove = true
    		    }
    		end
			if context.end_of_round then
				card.ability.extra.c_c = 0
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
		config = { extra = { chips = 1 } },
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
		end
	},
	{
		id = 'idk',
		y = 1, x = 4,
		name = 'IDK',
		text = {
			"Copies the ability of",
		},
		rarity = 3,
		-- __extr because Some Jokers use "extra" a a number value
		config = { __extra = {jokers = {}, joker_names = {}, consecutive_triggers_this_frame = 0, chosen_joker = 'Joker' } },
		loc_vars = function(self, info_queue, card)
			return {
				main_end = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = card.ability.__extra.joker_names,
								pop_in_rate = 9999999,
								silent = true,
								random_element = true,
								pop_delay = 0.25,
								scale = 0.32,
								min_cycle_time = 0,
								colours = {G.C.FILTER},
								text_effect = BalatrMod.prefix('shake')
							}),
						}
					}
				}
			}
		end,
		draw = function(self, card, layer)
			love.graphics.print(card.ability.__extra.chosen_joker or self.config.__extra.chosen_joker,
			card.T.x * (G.WINDOWTRANS.real_window_w / G.WINDOWTRANS.w), (card.T.y + 2.45) * (G.WINDOWTRANS.real_window_h / G.WINDOWTRANS.h), 0, 1, 1)
		end,
		-- i pray this works
		update = function(self, card, dt)
			if not card.ability.__extra then
				card.ability.__extra = self.config.__extra
			end
			-- this cant be real
			if not G.GAME.pseudorandom['idkcopy'] then
				pseudorandom_element({1, 2, 3}, 'idkcopy')
			end

			if card.ability.__extra.joker_names and #card.ability.__extra.joker_names < 1 then
				for k, v in pairs(G.P_CENTERS) do
					-- only copy base jokers, for reasons
					if k:sub(1, 2) == 'j_' and v.mod == nil then
						table.insert(card.ability.__extra.joker_names, (v.loc_txt or v).name or k:sub(3))
						table.insert(card.ability.__extra.jokers, k)
					end
				end
			end			
			card.ability.__extra.consecutive_triggers_this_frame = 0
		end,
		calculate = function(self, card, context)
			local long = 'consecutive_triggers_this_frame'
			card.ability.__extra[long] = card.ability.__extra[long] + 1
			if card.ability.__extra[long] > 1 then return nil, true end
			local og = card.ability.name
			-- indices should be identical to the name table
			local new, index = pseudorandom_element(card.ability.__extra.joker_names, 'idkcopy')
			local ret, did_smth = nil, false
			-- WHY IS IT NIL UNTILI HOVER THE CARD ????????
			if new then
				--print(new)
				for k, v in pairs(card.ability) do
					if k ~= '__extra' and k ~= 'extra' and k ~= 'set' and k ~= 'name'
					and k ~= 'extra_slots_used' and k ~= 'h_size' and k ~= 'd_size' --[[??????]] then
						card.ability[k] = nil
					end
				end
				for k, v in pairs(G.P_CENTERS[card.ability.__extra.jokers[index]].config or {}) do
					--print(new..' | '..k..' : '..tostring(v))
					if type(v) == 'number' then
						-- sum weird scaling stuff
						if (k == 'extra') then card.ability.extra = 0 end
						card.ability[k] = (card.ability[k] or 0) + v
						
					else
						card.ability[k] = v
					end
				end
				
				card.ability.name = new
				card.ability.__extra.chosen_joker = new
				-- vanilla joker stuff will not run if calculate is a function
				local og_calculate = self.calculate
				self.calculate = nil
				ret, did_smth = card:calculate_joker(context)
				self.calculate = og_calculate
				card.ability.name = og
				if ret or did_smth then print('ayo') end
				card:juice_up()
			end
			return ret or {}, did_smth
		end
	},
		---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'bdv',
		y = 1, x = 5,
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
		id = 'aldi',
		y = 1, x = 6,
		name = 'Aldi',
		text = {
			"{C:green}#1# in #2#{} chance",
		},
		config = { extra = { chance = 25, min = 0, max = 23 } },
		rarity = 2,
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
			if context.joker_main and pseudorandom('aldi') < (G.GAME.probabilities.normal / card.ability.extra.chance) then
				local temp_Mult = pseudorandom('misprint', card.ability.extra.min, card.ability.extra.max)
                return {
                    message = localize{type='variable',key='a_mult',vars={temp_Mult}},
                    mult_mod = temp_Mult
                }
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