SMODS.Challenge {
	key = "evil_balatr",
	loc_txt = {
		name = "Evil Balatro"
	},
	button_colour = HEX('060000'),
	rules = {
		modifiers = {
			{id = 'dollars', value = 666}
		}
	},
	restriction = {
		banned_other = {
			{ id = 'bl_'..BalatrMod.prefix('evil'), type = 'blind' }
		}
	},
	deck = {
		type = 'Challenge Deck',
		cards = {
			{
				s = 'H',
				r = '6',
				d = BalatrMod.prefix('demonic')
			}
		}
	}
}
-- no lovely patch support wont stop me
G.localization.misc.v_text.ch_c_inflation[1] = G.localization.misc.v_text.ch_c_inflation[1]:gsub('$1', '$#1#')
--print(G.localization.misc.v_text.ch_c_inflation[1])
SMODS.process_loc_text(G.localization.misc.v_text, "ch_c_"..BalatrMod.prefix("rental_con"), {
	key = "ch_c_"..BalatrMod.prefix("rental_con"),
	name = {
		'{C:green}1 in 4{} chance for consumables to be {C:attention}Rental{}'
	},
}, 'name')
SMODS.process_loc_text(G.localization.misc.v_text, "ch_c_"..BalatrMod.prefix("rental_con_2"), {
	key = "ch_c_"..BalatrMod.prefix("rental_con"),
	name = {
		'{C:inactive}(cannot be used immediately)'
	},
}, 'name')
SMODS.Challenge {
	key = "venezuela",
	loc_txt = {
		name = "Venezuela"
	},
	rules = {
		custom = {
			{id = 'inflation', value = 4},
			{id = BalatrMod.prefix('rental_con')},
			{id = BalatrMod.prefix('rental_con_2')}
		},
		modifiers = {
			{id = 'dollars', value = 20},
			{id = 'consumable_slots', value = 5},
		}
	},
	jokers = {
		{ id = "j_"..BalatrMod.prefix('bdv'), eternal = true, edition = "negative" },
		{ id = "j_credit_card", eternal = true, edition = "negative" },
	},
	deck = {
		type = 'Challenge Deck',
	}
}
local __create_card = create_card
function create_card(...)
	local ret = __create_card(...)
	if G.GAME.modifiers[BalatrMod.prefix('rental_con')] and ret.ability.consumeable and pseudorandom('SAQUENME_DE_VENZUELAAA') < (G.GAME.probabilities.normal / 4) then
		ret:set_rental(true)
		ret.ability[BalatrMod.prefix('unusable')] = true
	end
	return ret
end
G.FUNCS[BalatrMod.prefix('woosh_consumable')] = function(e, mute, nosave)
    local card = e.config.ref_table
	local prev_state = G.STATE
	if card and card.ability.consumeable and card.ability[BalatrMod.prefix('unusable')] then
		card.from_area = card.area
        card.area:remove_card(card)
        card:add_to_deck()
		G.consumeables:emplace(card)
		G.GAME.pack_choices = G.GAME.pack_choices - 1
		if G.GAME.pack_choices == 0 then
			G.CONTROLLER.interrupt.focus = true
            if prev_state == G.STATES.SMODS_BOOSTER_OPENED and booster_obj.name:find('Arcana') then inc_career_stat('c_tarot_reading_used', 1) end
            if prev_state == G.STATES.SMODS_BOOSTER_OPENED and booster_obj.name:find('Celestial') then inc_career_stat('c_planetarium_used', 1) end
            G.FUNCS.end_consumeable(nil, delay_fac)
		end
	end
end


SMODS.process_loc_text(G.localization.misc.v_text, "ch_c_blorb", {
	key = "ch_c_blorb",
	name = {
		'Start with {C:'..BalatrMod.prefix('blorbs')..'}Blorbs{} only {C:inactive}(i cant ban the default suits :<){}'
	},
}, 'name')
local function get_blorbs()
	local res = {}
	for k, v in ipairs({'A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'}) do
		table.insert(res, {r = v, s = BalatrMod.prefix('B')})
		table.insert(res, {r = v, s = BalatrMod.prefix('B')})
		table.insert(res, {r = v, s = BalatrMod.prefix('B')})
		table.insert(res, {r = v, s = BalatrMod.prefix('B')})
	end
	return res
end
SMODS.Challenge {
	key = "blorb",
	button_colour = HEX('c561ec'),
	loc_txt = {
		name = "Blorb World"
	},
	rules = {
		custom = {
			{id = 'blorb'},
			{id = 'scaling', value = 2},
		},
	},
	jokers = {
	},
	restrictions = {
		banned_cards = {
			{id = 'j_smeared'},
			{id = 'j_wrathful_joker'},
			{id = 'j_lusty_joker'},
			{id = 'j_gluttenous_joker'},
			{id = 'j_greedy_joker'},
			{id = 'j_flower_pot'},
			{id = 'j_blackboard'},
			{id = 'j_arrowhead'},
			{id = 'j_bloodstone'},
			{id = 'j_onyx_agate'},
			{id = 'j_rough_gem'},
			{id = 'j_seeing_double'},
			{id = 'j_'..BalatrMod.prefix('gato')},

			{id = 'c_world'},
            {id = 'c_sun'},
            {id = 'c_moon'},
            {id = 'c_star'},
			{id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1','p_standard_normal_2','p_standard_normal_3','p_standard_normal_4','p_standard_jumbo_1','p_standard_jumbo_2','p_standard_mega_1','p_standard_mega_2',
            }},
		},
		banned_tags = {},
		banned_other = {
			{id = 'bl_goad'  , type = 'blind'},
			{id = 'bl_head'  , type = 'blind'},
			{id = 'bl_club'  , type = 'blind'},
			{id = 'bl_window', type = 'blind'},
			{id = 'bl_'..BalatrMod.prefix('vacuum'), type = 'blind'},
		}
	},
	deck = {
		type = 'Challenge Deck',
		yes_suits = {[BalatrMod.prefix('B')] = true},

		-- in_pool is set to always be false in blorb suit, we have to ad them manually
		cards = get_blorbs()
	}
}
SMODS.Challenge {
	key = "suffering",
	loc_txt = {
		name = "Suffering from Success"
	},
	rules = {
		custom = {
			{id = 'scaling', value = 10},
		},
		modifiers = {
		}
	},
	jokers = {
		{ id = "j_"..BalatrMod.prefix('idk'), eternal = true, edition = "negative" },
		{ id = "j_"..BalatrMod.prefix('idk'), eternal = true, edition = "negative" },
		{ id = "j_"..BalatrMod.prefix('idk'), eternal = true, edition = "negative" },
	},
	deck = {
		type = 'Challenge Deck',
	}
}