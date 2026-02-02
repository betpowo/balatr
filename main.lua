--print('oh my god bruh')

BalatrMod = {
	obj = SMODS.current_mod,
	prefix = function (a)
		return BalatrMod.obj.prefix..'_'..a
	end,
	is_hand_palindrome = function(cards)
		if #cards < 5 then return false end
		local is_rev = true
		for i = 1, #cards do
			-- print('card1: '..cards[i]:get_id()..' | card2: '..cards[#cards - i + 1]:get_id())
	        if cards[i]:get_id() ~= cards[#cards - i + 1]:get_id() then
				is_rev = false
				break
			end
	    end
		return is_rev
	end,
	generate_glow = function(tbl)
		local function effect(t, v)
			return {
				t[1] + v, t[2] + v, t[3] + v, t[4]
			}
		end
		return {tbl, effect(tbl, 0.3), tbl, effect(tbl, -0.3)}
	end,
	has_blorbs = function()
		local res = false
		if not G.playing_cards then return false end
		for _, i in pairs(G.playing_cards) do
			res = i.base.suit == BalatrMod.prefix('Blorbs')
			if res then break end
		end
		return G.playing_cards and res
	end,
	-- nope sfx
	nope = function()
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
            play_sound('tarot2', 0.76, 0.4);return true end}))
        play_sound('tarot2', 1, 0.4)
	end,
	pitch_nudge = 1,
}

-- Emult is already added by talisman, so have this so prevent doing Emult ourselves if thats the case
-- also if this was kept true, many other talisman modifiers like ee_mult wouldnt work lmfao
-- + dealing with the increased score cap would be pain so lets not worry about it
BalatrMod.talisman = next(SMODS.find_mod("Talisman"))

-----------------------------------------------------------------

SMODS.Atlas {
    key = "balatro",
    path = "balatr.png",
    px = 333, py = 216,
    prefix_config = { key = false },
}

SMODS.Sound {
    key =  "splash_buildup", 
    path = "splash_buildup.ogg",
	prefix_config = { key = false },
}

SMODS.Gradient {
	key = 'e_chips',
	cycle = 2,
	interpolation = 'linear',
	colours = BalatrMod.generate_glow(G.C.UI_CHIPS)
}
SMODS.Gradient {
	key = 'e_mult',
	cycle = 2,
	interpolation = 'linear',
	colours = BalatrMod.generate_glow(G.C.UI_MULT)
}
SMODS.Gradient {
	key = 'rainbow',
	cycle = 5,
	interpolation = 'linear',
	colours = {G.C.RED,G.C.FILTER,G.C.GREEN,G.C.BLUE,HEX('9300de'),HEX('e83389')}
}

-- why is this not documented???
SMODS.DynaTextEffect {
	key = 'shake',
	func = function(obj, index, letter)
		letter.offset.x = (math.random() - 0.5) * 5
		letter.offset.y = (math.random() - 0.5) * 5
		letter.r = 8 * (math.random() - 0.5) / 90
	end
}

local files = NFS.getDirectoryItems((SMODS.current_mod.path).."source")
for _, file in ipairs(files) do
	local f, err = SMODS.load_file("source/"..file)
	if err then
		error(err) 
	end
	f()
end

SMODS.Sound:register_global()

SMODS.Atlas {
	key = "modicon",
	path = "modicon.png",
	px = 32,
	py = 32
}

local crochet = (150 * 0.7) / 60
local numerator = 7 -- 7/4
local og___Game_update = Game.update
function Game:update(dt)
	og___Game_update(self, dt)
	if BalatrMod.music_time then
		BalatrMod.music_time = BalatrMod.music_time + (dt * G.PITCH_MOD)
		--print(math.fmod(BalatrMod.music_time, crochet))
	end
	local c = love.thread.getChannel("i_hate_love2d"):pop()
	if c then
		BalatrMod.music_time = c
	end
end