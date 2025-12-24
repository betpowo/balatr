local blinds = {
	{
		id = 'evil',
		name = 'The Evil',
		boss_colour = '700000',
		text = {
			"All cards are debuffed"
		},
		recalc_debuff = function(self, card, from_blind)
			return true
		end,
		-- make it fair and square....
		mult = 0.25,
		in_pool = function(self)
			return G.GAME.round_resets.ante < 4
		end
	},
	{
		id = 'vacuum',
		name = 'The Vacuum',
		boss_colour = 'A107A8',
		text = {
			"All Blorb cards", "are debuffed"
		},
		debuff = {
			suit = BalatrMod.prefix('Blorbs')
		},
		in_pool = function(self)
			return BalatrMod.has_blorbs()
		end
	},
	{
		id = 'bird',
		name = 'That Fucking Blind That I Hate',
		boss_colour = '5F7989',
		text = {
			"Can't draw cards of", "rank 5 or lower"
		},
		-- from yahimod
		drawn_to_hand = function(self)
			if G.GAME.blind.disabled then return true end
			local any_selected = nil
			local cards_selected = {}
			G.hand.config[BalatrMod.prefix('real_high_limit')] = G.hand.config.highlighted_limit
			G.hand.config.highlighted_limit = #G.hand.cards
    	    for i = 1, #G.hand.cards do
    	        if (G.hand.cards[i].base.nominal <= 5) and not SMODS.has_enhancement(G.hand.cards[i], 'm_stone') then
    	            local _selected_card = G.hand.cards[i]
					table.insert(cards_selected, _selected_card)
    	            G.hand:add_to_highlighted(_selected_card, true)
					any_selected = true
    	        end
    	    end
			delay((G.SETTINGS.GAMESPEED * 0.75 * math.pow(#cards_selected, 0.01)))
			if any_selected then
				play_sound('card1', 1)
				G.FUNCS.discard_cards_from_highlighted(nil, true)

				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
				
				SMODS.juice_up_blind()
			end
			G.hand.config.highlighted_limit = G.hand.config[BalatrMod.prefix('real_high_limit')]
			G.hand.config[BalatrMod.prefix('real_high_limit')] = nil
			return true
    	end,
		-- Nuh uh
		debuff_hand = function(self)
			if G.GAME.blind.disabled then return false end
    	    local broke = false
    	    for i = 1, #G.play.cards do
    	        if (G.play.cards[i].base.nominal <= 5) and not SMODS.has_enhancement(G.play.cards[i], 'm_stone') then
    	            broke = true
    	        end
    	    end
    	    if broke then
    	        SMODS.juice_up_blind()
    	        return true
    	    end
    	end,
		in_pool = function(self)
			-- instant game over since every card in deck at start is 5 and lower
			return next(SMODS.find_mod("UnStable")) and G.GAME.selected_back.name ~= 'b_unstb_lowkey'
		end
	},
	{
		id = 'reunion',
		name = 'The Reunion',
		boss_colour = 'E03763',
		text = {
			"All cards in deck", "are held in hand"
		},
		config = {card_limit = 8},
		set_blind = function(self)
			self.config.card_limit = G.hand.config.card_limit
			G.hand:change_size(#G.deck.cards - G.hand.config.card_limit)
		end,
		defeat = function(self)
			G.hand:change_size(-(#G.deck.cards - self.config.card_limit))
		end
	},
	{
		id = 'green',
		name = 'The Green',
		boss_colour = 'A3E044',
		text = {
			'Enables "green mode"'
		},
		set_blind = function(self)
			BalatrMod.green = true
		end,
		defeat = function(self)
			G.GAME.blind.disabled = true
			BalatrMod.green = false
		end,
		disable = function(self)
			BalatrMod.green = false
		end,
		post_setup = function(self)
			local og___love_draw = love.draw
			BalatrMod.green = false
			
			BalatrMod.green_fill_progress = 0
			function love.draw()
				-- die "main menu" button
				if (G.GAME and G.GAME.blind and G.GAME.blind.config
				and G.GAME.blind.config.blind.name == 'bl_'..BalatrMod.prefix('green')
				and not (G.GAME.blind.disabled and G.STATE == G.STATES.ROUND_EVAL)) and not BalatrMod.green then
					BalatrMod.green = true
				end
				local dt = 1 / love.timer.getFPS()
				BalatrMod.green_fill_progress = math.max(0, math.min(1, BalatrMod.green_fill_progress + (dt * G.SETTINGS.GAMESPEED * (BalatrMod.green and 1 or -1))))
				if BalatrMod.green_fill_progress > 0 then
					-- reset
					love.graphics.setColor(G.C.WHITE)
					love.graphics.setBlendMode('alpha')
				end
				og___love_draw()
				if BalatrMod.green_fill_progress > 0 then
					local w, h, mode = love.window.getMode()
					--love.graphics.setColor(G.GAME.blind.config.blind.boss_colour)
					love.graphics.setColor(1 - BalatrMod.green_fill_progress, 1, 1 - BalatrMod.green_fill_progress, 1)
					love.graphics.setBlendMode("multiply", "premultiplied")
            		love.graphics.rectangle("fill", 0, 0, w, h)
					love.graphics.setBlendMode('alpha')
				end
			end
		end,
	},
	{
		id = 'gilbert',
		name = 'gilbert',
		boss = { showdown = true },
		boss_colour = '9CBB57',
		mult = 1,
		dollars = 8,
		text = {
			"Shuffles and flips", "cards held in hand", "after each hand played"
		},
		set_blind = function(self)
			print("It's the end.")
			G.ROOM.jiggle = G.ROOM.jiggle + 666
			G.GAME.blind.prepped = nil
		end,
		press_play = function(self)
			G.GAME.blind.prepped = true
		end,
		drawn_to_hand = function(self)
			if G.GAME.blind.disabled or not G.GAME.blind.prepped then return true end
			G.hand:unhighlight_all()
			delay(0.3 * math.pow(G.SETTINGS.GAMESPEED, 0.1))
			G.E_MANAGER:add_event(Event({ trigger = 'after', 0.6 * G.SETTINGS.GAMESPEED, func = function() 
        		for k, v in ipairs(G.hand.cards) do
					v.facing = 'front'
        		    v:flip()
        		end
        	return true end })) 
			delay(0.3)
        	if #G.hand.cards > 1 then 
        	    G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
        	        G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle('gbrt'); play_sound('cardSlide1', 0.85);return true end })) 
        	        delay(0.15 * math.pow(G.SETTINGS.GAMESPEED, 0.1))
        	        G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle('gbrt'); play_sound('cardSlide1', 1.15);return true end })) 
        	        delay(0.15 * math.pow(G.SETTINGS.GAMESPEED, 0.1))
        	        G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle('gbrt'); play_sound('cardSlide1', 1);return true end })) 
        	        delay(0.5 * math.pow(G.SETTINGS.GAMESPEED, 0.1))
        	    return true end })) 
        	end
		end
	},
}

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

local blind_funcs = {
	'set_blind', 'calculate', 'disable', 'defeat', 'drawn_to_hand', 'press_play',
	'recalc_debuff', 'debuff_hand', 'debuff_card', 'stay_flipped', 'modify_hand',
	'get_loc_debuff_text', 'loc_vars', 'collection_loc_vars', 'in_pool'
}
for k, i in ipairs(blinds) do
	local b = {
		key = i.id or k,
		atlas = 'blind_'..i.id,
		loc_txt = {
			name = i.name or '???',
			text = i.text or {'Does nothing...?'}
		},
		pos = {x = 0, y = 0},
		discovered = true,
		mult = i.mult or 2,
		boss_colour = HEX(i.boss_colour or '000000'),
		boss = i.boss or { min = 1 },
		debuff = i.debuff or {},
		dollars = i.dollars or 5
	}
	for _, j in ipairs(blind_funcs) do
		if i[j] then
			b[j] = i[j]
		end
	end
	if i.post_setup ~= nil then
		i.post_setup(b)
	end
	SMODS.Atlas {
	    key = "blind_"..(i.id),
	    path = "blinds/"..(i.id)..".png",
	    px = 34, py = 34,
		atlas_table = 'ANIMATION_ATLAS',
		frames = 21
	}
	SMODS.Blind(b)
end