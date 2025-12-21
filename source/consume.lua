SMODS.Atlas {
    key =  "consumables",
    path = "consumables.png",
    px = 71, py = 95,
}

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- THEY ARE SPECTRAL CARDS BY DEFAULT!!!!! REMEMBER
local items = {
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	{
		id = 'reciprocal',
		x = 1,
		name = 'Reciprocal',
		text = {
			"{C:dark_edition,T:e_negative}Negative{} Jokers become normal,",
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
		id = 'nebula',
		x = 2,
		set = 'Tarot',
		name = 'Nebula',
		text = {
			"Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {C:"..BalatrMod.prefix('blorbs').."}Blorbs{}",
		},
		config = {suit_conv = BalatrMod.prefix('Blorbs'), max_highlighted = 3},
		cost = 3,
		loc_vars = function(self, info_queue, center)
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
		id = 'earth2',
		set = 'Planet',
		x = 3,
		name = 'Earth',
		text = {
			"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
		},
		config = {hand_type = BalatrMod.prefix('racism')},
		cost = 3,
		use = function(self, card, area, copier)
    	    SMODS.smart_level_up_hand(card, BalatrMod.prefix('racism'))
    	end,
    	can_use = function(self, card)
    	    return true
		end,
		loc_vars = function(self, info_queue, center)
			local levelone = G.GAME.hands[BalatrMod.prefix('racism')].level or 1
			local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
			if levelone == 1 then
				planetcolourone = G.C.UI.TEXT_DARK
			end
			return {
				vars = {
					G.GAME.hands[BalatrMod.prefix('racism')].level,
					'Racism',
					G.GAME.hands[BalatrMod.prefix('racism')].l_mult,
					G.GAME.hands[BalatrMod.prefix('racism')].l_chips,
					colours = {
						(
							to_big(G.GAME.hands[BalatrMod.prefix('racism')].level) == to_big(1) and G.C.UI.TEXT_DARK
							or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[BalatrMod.prefix('racism')].level))]
						),
					},
				},
			}
		end,
	},
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
}

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
		set = i.set or 'Spectral',
		object_type = "Consumable",
		atlas = i.atlas or 'consumables',
		pos = {x = i.x or 0, y = i.y or 0},
		cost = i.cost or 1,
		loc_txt = {
			name = i.name or i.id,
			text = i.text or {"..."}
		},
		loc_vars = i.loc_vars or function(self, info_queue, card)
			return {}
		end,
		config = i.config or {},
		unlocked = true,
    	discovered = i.discovered or true,

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