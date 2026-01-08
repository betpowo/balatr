SMODS.ObjectType {
	key = "BalatrPool",
	default = BalatrMod.prefix("B_2"),
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
}

SMODS.Atlas {
    key = "suit_blorbs",
    path = "blorb.png",
    px = 71, py = 95,
}
SMODS.Atlas {
    key = "suit_blorbs-hc",
    path = "blorb-hc.png",
    px = 71, py = 95,
}

SMODS.Atlas {
    key = "boosters_balatr",
    path = "boosters-balatr.png",
    px = 71, py = 96,
}
local traced = false
SMODS.Sound {
    key =  "music_balatr_be_like", 
    path = "music_balatr_be_like.ogg",
    volume = 0.6,
    select_music_track = function()
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
            if SMODS.OPENED_BOOSTER
            and SMODS.OPENED_BOOSTER.config
            and SMODS.OPENED_BOOSTER.config.center
            and SMODS.OPENED_BOOSTER.config.center.config
            and SMODS.OPENED_BOOSTER.config.center.config.BalatrBlorb then
		        return true
            end
        end
	end,
}

SMODS.Suit {
    key = 'Blorbs',
    card_key = 'B',
	atlas = 'suit_blorbs',
	hc_atlas = 'suit_blorbs-hc',
	lc_atlas = 'suit_blorbs',
	hc_colour = '8E3CDB',
	lc_colour = 'c561ec',
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
    keep_base_colours = false,
	loc_txt = {
		singular = 'Blorb',
		plural = 'Blorbs',
	},
	pools = {['BalatrPool'] = true},
	in_pool = function(self, args)
		return BalatrMod.has_blorbs() and (args and (not args.initial_deck) or true)
	end
}

SMODS.Booster {
    key = 'booster_blorb',
    group_key = "k_balatr_booster_group",
    atlas = 'boosters_balatr', 
    pos = { x = 1, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'Blorb Zone',
        text = {
			"Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{} {C:"..BalatrMod.prefix('blorbs').."}Blorb{} cards to",
            "add to your deck",
		},
        group_name = "standard",
    },
    
    draw_hand = true,
    config = {
        extra = 6,
        choose = 1,
        BalatrBlorb = 'hi..i am here as a variable to play the blorbs music'
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 3,
    kind = "Standard",

    create_card = function(self, card, i)
        return {
            set = "Playing Card",
            suit = BalatrMod.prefix('Blorbs'),
            area = G.pack_cards,
            skip_materialize = true
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour {new_colour = HEX('6b009c'), special_colour = G.C.BLACK, contrast = 2}
    end,
    in_pool = function() return true end
}

local FUCK = {'King', 'Queen', 'Jack'}
local poop = {
    ['en-us'] = 'Betopia'
}

for _, i in ipairs({'Blorbs'}) do
    local first = i:sub(1, 1)
    SMODS.Atlas {
        key = 'collab_BTP_'..first,
        path = 'collabs/collab_BTP_'..first..'.png',
        px = 71, py = 95,
    }
    SMODS.Atlas {
        key = 'collab_BTP_'..first..'-hc',
        path = 'collabs/hc/collab_BTP_'..first..'.png',
        px = 71, py = 95,
    }
    SMODS.DeckSkin {
        key = 'collab_BTP_'..first,
        suit = BalatrMod.prefix(i),
        palettes = {
            {
                key = 'lc',
                ranks = FUCK,
                atlas = BalatrMod.prefix('collab_BTP_'..first),
                pos_style = 'collab'
            },
            {
                key = 'hc',
                ranks = FUCK,
                atlas = BalatrMod.prefix('collab_BTP_'..first..'-hc'),
                pos_style = 'collab',
                hc_default = true
            }
        },
        loc_txt = poop
    }
end