SMODS.PokerHandPart {
    key = '_6',
    func = function(hand) return get_X_same(6, hand, true) end
}

local hands = {
    {
        id = 'racism',
        name = 'Racism',
        text = {"A Three of a Kind made of Kings"},
        visible = true,
        chips = 80, mult = 4,
        l_chips = 10, l_mult = 1,
        example = {
            { 'D_A', false },
            { 'S_K', true },
            { 'H_K', true },
            { 'C_K', true },
            { 'D_6', false },
        },
        evaluate = function(parts, hand)
            if next(parts._3) then
                local _strush = SMODS.merge_lists(parts._3, parts._2)
                local royal = true
                for j = 1, #_strush do
                    local rank = SMODS.Ranks[_strush[j].base.value]
                    royal = royal and (rank.key == 'King')
                end
                if royal then return {_strush} end
            end
        end,
        planet = {
            id = 'earth2',
            name = 'Earth',
            x = 0
        }
    },
    {
        id = '3pair',
        name = 'Three Pair',
        text = {"3 pairs of cards with different ranks"},
        chips = 60, mult = 4,
        l_chips = 10, l_mult = 2,
        example = {
            { 'D_A', true },
            { 'H_A', true },
            { 'S_7', true },
            { 'D_7', true },
            { 'C_3', true },
            { 'S_3', true },
        },
        evaluate = function(parts, hand)
            if #parts._2 == 3 then
                return parts._all_pairs
            end
        end,
        planet = {
            name = '???',
            x = 1
        }
    },
    {
        id = '2x3',
        name = 'Double Triple',
        text = {"2 sets of 3 cards with the same rank"},
        chips = 100, mult = 6,
        l_chips = 20, l_mult = 3,
        example = {
            { 'S_6', true },
            { 'D_6', true },
            { 'C_6', true },
            { 'C_7', true },
            { 'S_7', true },
            { 'H_7', true },
        },
        evaluate = function(parts, hand)
            if next(parts._3) and #parts._3 == 2 then
                return {SMODS.merge_lists(parts._3)}
            end
        end,
        planet = {
            name = '???',
            x = 2
        }
    },
    {
        id = 'colony',
        name = 'Colony',
        text = {"A Four of a Kind and a Pair"},
        chips = 80, mult = 10,
        l_chips = 40, l_mult = 2,
        example = {
            { 'S_7', true },
            { 'D_7', true },
            { 'C_7', true },
            { 'H_7', true },
            { 'D_A', true },
            { 'C_A', true },
        },
        evaluate = function(parts, hand)
            if #parts._4 < 1 or #parts._2 < 2 then return {} end
            return parts._all_pairs
        end,
        planet = {
            name = '???',
            x = 3
        }
    },
    {
        id = '6oak',
        name = 'Six of a Kind',
        text = {"6 cards that share the same rank"},
        chips = 160, mult = 20,
        l_chips = 60, l_mult = 4,
        example = {
            { 'S_9', true },
            { 'S_9', true },
            { 'H_9', true },
            { 'C_9', true },
            { 'D_9', true },
            { 'D_9', true },
        },
        evaluate = function(parts, hand)
            if next(parts[BalatrMod.prefix('_6')]) then
                return {SMODS.merge_lists(parts[BalatrMod.prefix('_6')])}
            end
        end,
        planet = {
            name = '???',
            x = 4
        }
    },
    {
        id = 'flush6',
        name = 'Why',
        text = {"6 cards with the same rank and suit"},
        chips = 420, mult = 69,
        l_chips = 100, l_mult = 7,
        -- pretty sure youre gonna know about blorbs this late in the game
        example = {
            { BalatrMod.prefix('B_A'), true },
            { BalatrMod.prefix('B_A'), true },
            { BalatrMod.prefix('B_A'), true },
            { BalatrMod.prefix('B_A'), true },
            { BalatrMod.prefix('B_A'), true },
            { BalatrMod.prefix('B_A'), true },
        },
        evaluate = function(parts, hand)
            if next(parts[BalatrMod.prefix('_6')]) and next(parts._flush) then
                return {hand}
            end
        end,
        planet = {
            name = '???',
            x = 5
        }
    },
    {
        id = 'six_seven',
        name = 'No',
        text = {"What have you done."},
        chips = 60, mult = -7,
        l_chips = -7, l_mult = 0.6,
        order_offset = (60 * 7) + 6,
        example = {
            { 'H_2', false },
            { 'D_4', false },
            { 'S_6', true },
            { 'D_7', true },
            { 'C_9', false },
        },
        -- TODO: calculate
        evaluate = function(parts, hand)
            if next(hand) then
                local card_scored = {}
                local _strush = hand
                local shit = 2
                for j = 1, #_strush do
                    local rank = SMODS.Ranks[_strush[j].base.value]
                    if ((shit == 2) and (rank.key == '6')) then
                        shit = shit - 1
                        table.insert(card_scored, _strush[j])
                    end
                    if ((shit == 1) and (rank.key == '7')) then
                        shit = shit - 1
                        table.insert(card_scored, _strush[j])
                    end
                    --print(j, rank.key, shit)
                end
                --print(#card_scored)
                if #card_scored > 1 then return card_scored end
            end
        end,
        planet = {
            id = 'earth3',
            name = 'Earth',
            x = 6
        }
    },
}

local hand_extra_vars = {
    'example', 'modify_display_text',
    'above_hand', 'order_offset'
}
for _, i in ipairs(hands) do
    local h = {
        key = i.id,
        loc_txt = {
            name = i.name or i.id,
            description = i.text or {'...'}
        },
        chips = i.chips, mult = i.mult,
        l_chips = i.l_chips or 5, l_mult = i.l_mult or 1,
        evaluate = i.evaluate,
        visible = i.visible or false
    }
    for _, k in ipairs(hand_extra_vars) do
		if i[k] then
			h[k] = i[k]
		end
	end
    SMODS.PokerHand(h)
    if i.planet then
        SMODS.Consumable {
            set = 'Planet',
            key = i.planet.id or i.id,
            atlas = i.planet.atlas or 'consumables',
            pos = {x = i.planet.x or 0, y = i.planet.y or 0},
		    cost = i.planet.cost or 3,
            unlocked = true,
            loc_txt = {
                name = i.planet.name or i.planet.id or i.id,
		        text = i.planet.text or {
		        	"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
		        },
            },
            config = {hand_type = BalatrMod.prefix(i.id)},
            use = function(self, card, area, copier)
    	        SMODS.smart_level_up_hand(card, BalatrMod.prefix(i.id))
    	    end,
    	    can_use = i.planet.can_use or function(self, card)
    	        return true
		    end,
		    loc_vars = i.planet.loc_vars or function(self, info_queue, center)
		    	local levelone = G.GAME.hands[BalatrMod.prefix(i.id)].level or 1
		    	local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
		    	if levelone == 1 then
		    		planetcolourone = G.C.UI.TEXT_DARK
		    	end
		    	return {
		    		vars = {
		    			G.GAME.hands[BalatrMod.prefix(i.id)].level,
		    			i.name or i.id,
		    			G.GAME.hands[BalatrMod.prefix(i.id)].l_mult,
		    			G.GAME.hands[BalatrMod.prefix(i.id)].l_chips,
		    			colours = {
		    				(
		    					to_big(G.GAME.hands[BalatrMod.prefix(i.id)].level) == to_big(1) and G.C.UI.TEXT_DARK
		    					or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands[BalatrMod.prefix(i.id)].level))]
		    				),
		    			},
		    		},
		    	}
		    end,
        }
    end
end