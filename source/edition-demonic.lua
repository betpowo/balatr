BalatrMod.demonic_on_screen = false

SMODS.Shader({key = 'demonic', path = 'demonic.fs'})

SMODS.Sound {
    key =  "music_evil_balatro", 
    path = "music_evil_balatro.ogg",
    volume = 0.7,
    select_music_track = function()
		-- die
        return BalatrMod.demonic_on_screen
	end,
}
SMODS.Edition {
	key = "demonic",
	order = 2,
	weight = 0.6,
	shader = "demonic",
	in_shop = true,
	extra_cost = 16,
    apply_to_float = true,
    discovered = true,
	config = {
		chips = 666,
		x_chips = 666,
		e_chips = 666,
		mult = 666,
		x_mult = 666,
		e_mult = 666,
	},
	sound = {
		sound = BalatrMod.prefix("demonic"),
		per = 1,
		vol = 5,
	},

	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	loc_vars = function(self, info_queue)
		return { vars = {
			self.config.chips  ,
			self.config.x_chips,
			self.config.e_chips,
			self.config.mult   ,
			self.config.x_mult ,
			self.config.e_mult ,
		} }
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
				-- its only a func so we can use the awesome sound....
				chip_mod   = self.config.chips ,
				Xchip_mod  = self.config.x_chips,
				Echip_mod  = self.config.e_chips,
				mult_mod   = self.config.mult ,
				Xmult_mod  = self.config.x_mult,
				Emult_mod  = self.config.e_mult,
				func = function()
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						blockable = true,
						func = function()
							G.ROOM.jiggle = G.ROOM.jiggle + 6
							return true
						end
					}))
					card_eval_status_text(card, 'jokers', nil, 1, nil, {
						message = '?!?!?!?!',
						colour = G.C.EDITION, edition = true,
						delay = 2,
						sound = BalatrMod.prefix("demonic"),
						volume = 5
					})
				end
			}
		end
	end,
}
local function in_area(c)
	return c.area == G.hand or c.area == G.play or c.area == G.jokers or c.area == G.consumeables or c.area == G.pack_cards
end
local __love_draw = love.draw
function love.draw()
	BalatrMod.demonic_on_screen = false
	__love_draw()
end
local __Card_draw = Card.draw
function Card.draw(self, layer)
	local is_demonic = self.edition and self.edition.key == 'e_'..BalatrMod.prefix('demonic') and (self.area and self.area.T.y < G.TILE_H * 1.3) and self.sprite_facing == 'front'
	local changeX = (math.random() - 0.5) * 1.75
	local changeY = (math.random() - 0.5) * 1.75
	if is_demonic then
		self.VT.x = self.VT.x + changeX
		self.VT.y = self.VT.y + changeY
	end
	__Card_draw(self, layer)
	if is_demonic then
		self.VT.x = self.VT.x - changeX
		self.VT.y = self.VT.y - changeY
		BalatrMod.demonic_on_screen = true
	end
end

