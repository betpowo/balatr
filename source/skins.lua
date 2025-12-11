local FUCK = {'King', 'Queen', 'Jack'}
local poop = {
    ['en-us'] = 'Betopia'
}

for _, i in ipairs({'Spades', 'Hearts', 'Clubs', 'Diamonds'}) do
    local first = i:sub(1, 1)
    SMODS.Atlas {
        key = 'collab_BTP_'..first,
        path = 'collabs/collab_BTP_'..first..'.png',
        px = 71, py = 95,
    }
    SMODS.DeckSkin {
        key = 'collab_BTP_'..first,
        suit = i,
        palettes = {
            {
                key = 'lc',
                ranks = FUCK,
                atlas = BalatrMod.prefix('collab_BTP_'..first),
                pos_style = 'collab'
            }
        },
        loc_txt = poop
    }
end