print('oh my god bruh')

trace = print -- haxe muscle memory :sob:

BalatrMod = {}
BalatrMod.prefix = function (a)
	return 'balatr________'..a
end
BalatrMod.is_hand_palindrome = function(cards)
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
end

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

SMODS.Sound {
    key =  "ultra_fart", 
    path = "ultra_fart.ogg",
}

BalatrMod.generate_glow = function(tbl)
	local function effect(t, v)
		return {
			t[1] + v, t[2] + v, t[3] + v, t[4]
		}
	end
	return {tbl, effect(tbl, 0.3), tbl, effect(tbl, -0.3)}
end

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