SMODS.Atlas {
    key = 'stickers',
    path = 'stickers.png',
    px = 71, py = 95,
}

SMODS.Sticker {
    key = 'idk',
    atlas = 'stickers',
    pos = {x = 0, y = 0},
    default_compat = true, -- even though youll never actually get it on everything
    rate = 0.0,
    badge_colour = HEX('739b96'),
    loc_txt = {
        label = 'Powered-up',
        name = 'Powered-up',
        text = {
            'Card has a {C:'..BalatrMod.prefix('rainbow')..'}perma-bonus{}',
            'applied by {C:attention}IDK{}',
            '{s:0.8,C:inactive}(Sticker does nothing on its own)'
        }
    }
}