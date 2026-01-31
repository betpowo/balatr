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
    	        if SMODS.has_no_rank(G.hand.cards[i]) and (G.hand.cards[i].base.nominal <= 5) then
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
    	        if SMODS.has_no_rank(G.hand.cards[i]) and (G.hand.cards[i].base.nominal <= 5) then
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
			return G.GAME.selected_back.name ~= 'b_unstb_lowkey'
		end
	},
	{
		id = 'reunion',
		name = 'The Reunion',
		boss_colour = 'E03763',
		text = {
			"All cards in deck", "are held in hand"
		},
		set_blind = function(self)
			G.hand:change_size(#G.deck.cards)
		end,
		defeat = function(self)
			G.hand:change_size(-(#G.deck.cards))
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
		id = 'conveyor',
		name = 'The Conveyor',
		boss_colour = '8878B4',
		text = {
			"Hand rotates to the left"
		},
		update = function(self, blind, dt)
			local beat = ((BalatrMod.music_time or 0) * ((150 * 0.7) / 60))
			local target_value = math.floor(beat / 2)

			if self.tracked_beat ~= target_value then
				self.tracked_beat = target_value
				blind:juice_up()
				if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED then
					local first_card = G.hand.cards[1]
					table.remove(G.hand.cards, 1)
					table.insert(G.hand.cards, #G.hand.cards + 1, first_card)
					play_sound('cardSlide1', 0.8, 0.4)
				end
			end
		end,
		post_setup = function(self)
			self.tracked_beat = -1
		end
	},
	{
		id = 'ceiling',
		name = 'The Ceiling',
		boss_colour = 'A87853',
		text = {'It says "gullible" on it.'},
		update = function(self, blind, dt)
			if blind.triggered or G.STATE == G.STATES.DRAW_TO_HAND then return end

			local w, h, mode = love.window.getMode()
			local relX = G.CONTROLLER.cursor_position.x / w
			local relY = G.CONTROLLER.cursor_position.y / h

			if (relX <= 1 / 2) and (relY <= 1 / 10) then
				blind.triggered = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
				
				SMODS.juice_up_blind()
				BalatrMod.pitch_nudge = 10
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.35*G.SETTINGS.GAMESPEED,
					func = function()
						G.ROOM.jiggle = G.ROOM.jiggle + 100
						play_sound('talisman_eeemult')
						play_sound('talisman_eeemult', 0.25)
						play_sound('talisman_eeechip')
						play_sound('talisman_eeechip', 0.5)
						play_sound(BalatrMod.prefix('ultra_fart'), 1.5, 0.35)
						play_sound(BalatrMod.prefix('ultra_fart'), 1, 0.5)
						play_sound(BalatrMod.prefix('ultra_fart'), 0.5, 0.75)
                    	local destroyed_cards = {}
						for k, v in pairs(G.deck.cards) do
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
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.03*G.SETTINGS.GAMESPEED,
					func = function()
						G.ROOM.jiggle = G.ROOM.jiggle + 20
                    	local destroyed_cards = {}
						for k, v in pairs(G.hand.cards) do
							destroyed_cards[#destroyed_cards + 1] = v
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.05*G.SETTINGS.GAMESPEED,
								blocking = false,
								func = function()
									v:juice_up(0.3, 0.3)
                					if SMODS.shatters(v) then
                					    v:shatter()
                					else
                					    v:start_dissolve()
                					end
									SMODS.calculate_context({remove_playing_cards = true, removed = {v}})
									return true 
								end
							}))
						end
						return true 
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2*G.SETTINGS.GAMESPEED,
					func = function()
						G.ROOM.jiggle = G.ROOM.jiggle + 20
						local destroyed_cards = {}
						for k, v in pairs(G.consumeables.cards) do
							destroyed_cards[#destroyed_cards + 1] = v
							v:juice_up(0.3, 0.3)
							v:start_dissolve()
						end
						if destroyed_cards[1] then
							SMODS.calculate_context({remove_playing_cards = true, removed = destroyed_cards})
						end
						return true 
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.5*G.SETTINGS.GAMESPEED,
					func = function()
						G.ROOM.jiggle = G.ROOM.jiggle + 20
						for k, v in pairs(G.jokers.cards) do
							v:shatter()
						end
						return true 
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            blind.children.animatedSprite:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '-', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            blind.children.animatedSprite:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '-', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            blind.children.animatedSprite:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='-400'})
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true, -400)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
						return true 
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.5*G.SETTINGS.GAMESPEED,
					func = function()
						G.ROOM.jiggle = G.ROOM.jiggle + 20
						BalatrMod.pitch_nudge = 1
						G.GAME.blind:disable()
						end_round()
						return true 
					end
				}))
			end
		end,
		set_blind = function(self)
			self.title_window = love.window.getTitle()
			love.window.setTitle('Gullible')
		end,
		defeat = function(self)
			G.GAME.blind:disable()
		end,
		disable = function(self)
			love.window.setTitle(self.title_window)
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
	'get_loc_debuff_text', 'loc_vars', 'collection_loc_vars', 'in_pool',

	-- added by balatr
	'update'
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