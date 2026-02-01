local function lerp(a, b, ratio)
	return a + ratio * (b - a)
end

SMODS.Shader({key = 'replica', path = 'replica.fs'})
SMODS.Edition {
	key = "replica",
	order = 1,
	weight = -7,
	shader = "replica",
	in_shop = false,
	extra_cost = -5,
    apply_to_float = true,
	config = { min = 0.5, max = 4 },
	sound = {
		sound = 'foil2',
		per = 0.7,
		vol = 1,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	loc_vars = function(self, info_queue, card)
		--[[
		-- it WAS going to show a random number like misprint
		-- but SOMEONEEEE (localthunk) decided "oh yea lets make main_start
		-- and main_end" NOT work on tooltips(where we usually see the edition definition)
		-- !!!!!!!! aah. hahah Hahahah very Funny. I'm going to find you localthunk /j
			local r_mults = {}
    		for i = 1, 17 do
    		    r_mults[#r_mults+1] = tostring(math.floor(lerp(self.config.min, self.config.max, pseudorandom('replica_infobox')) * math.pow(10, 6)) / math.pow(10, 6))
    		end
    		local loc_mult = ' Chips '
    		local main_start = {
				{n=G.UIT.C, config={align = "m", colour = G.C.CHIPS, r = 0.05, padding = 0.03, res = 0.15}, nodes={
    		    	{n=G.UIT.T, config={text = 'X',colour = G.C.WHITE, scale = 0.32}},
    		    	{n=G.UIT.O, config={object = DynaText({string = r_mults, colours = {G.C.WHITE},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0})}},
				}},
    		    {n=G.UIT.O, config={object = DynaText({string = {
    		        {string = 'rand()', colour = G.C.JOKER_GREY},{string = "%&"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 2)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'S'), colour = G.C.BLUE},
    		        loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult},
    		    colours = {G.C.UI.TEXT_DARK},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
    		}
			return { main_start = main_start }
		]]
	end,
	calculate = function(self, card, context)
		-- yahimod
    	if (
			context.edition -- for when on jonklers
			and context.cardarea == G.jokers -- checks if should trigger
			and context.post_joker
		) or (
			context.main_scoring -- for when on playing cards
			and context.cardarea == G.play
		) then
			return {
				Xchip_mod = lerp(self.config.min, self.config.max, pseudorandom('replica_xchips'))
			}
		end

		if (context.selling_self or ((context.getting_sliced or context.joker_type_destroyed) and not card.shattered)) then
			G.GAME.banned_keys[card.config.center.key] = true

			-- remove from collection,
			-- erase joker from the timeline of events
			-- (should the run be affected??? that's prob not gonna feel good)
			card.config.center.no_collection = true

			local found = SMODS.find_card(card.config.center.key)
			if next(found) then
				for k, v in pairs(found) do
					-- Ceremonial Dagger causes stack overflow
					if not v.getting_sliced then
						v:shatter()
					end
				end
				-- trick to make the game disappear for a tiny bit
				local last_volume = G.SETTINGS.SOUND.volume
				local last_shake = G.SETTINGS.screenshake
				local last_motion = G.SETTINGS.reduced_motion
				G.E_MANAGER:add_event(Event({
    			    trigger = 'after',
    			    blockable = false,
					blocking = true,
					delay = 0.071 * G.SETTINGS.GAMESPEED,
    			    func = function()
						G.SETTINGS.SOUND.volume = 0
						G.PITCH_MOD = 0
						G.ROOM.jiggle = 1e309
						G.SETTINGS.screenshake = 100
						G.SETTINGS.reduced_motion = false
						if not last_motion then
							G.ARGS.spin.amount = 0.717
						end
						return true
					end
    			}))
				G.E_MANAGER:add_event(Event({
    			    trigger = 'after',
    			    blockable = false,
					blocking = true,
					delay = 0.7 * (G.SETTINGS.GAMESPEED + 1.25),
    			    func = function()
						G.SETTINGS.SOUND.volume = last_volume
						G.SETTINGS.screenshake = last_shake
						G.SETTINGS.reduced_motion = last_motion
						G.PITCH_MOD = 0
						G.ROOM.jiggle = 0
						return true
					end
    			}))
			end
		end
	end
}

local og___SMODS_shatters = SMODS.shatters
function SMODS.shatters(card)
	if card.edition and card.edition.key == 'e_'..BalatrMod.prefix('replica') then
		return true
	end
	return og___SMODS_shatters(card)
end