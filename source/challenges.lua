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
SMODS.Challenge {
	key = "venezuela",
	loc_txt = {
		name = "Venezuela"
	},
	rules = {
		custom = {
			{id = 'inflation', value = 4}
		},
		modifiers = {
			{id = 'dollars', value = 20},
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


SMODS.process_loc_text(G.localization.misc.v_text, "ch_c_blorb", {
	key = "ch_c_blorb",
	name = {
		'Start with only {C:'..BalatrMod.prefix('blorbs')..'}Blorb{} suit in your deck',
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
		}
	},
	deck = {
		type = 'Challenge Deck',
		yes_suits = {[BalatrMod.prefix('B')] = true},

		-- in_pool is set to always be false in blorb suit, we have to ad them manually
		cards = get_blorbs()
	}
}