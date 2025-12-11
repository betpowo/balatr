SMODS.Atlas({
    key = 'stakes',
    path = 'stakes.png',
    px = 29,
    py = 29
})

SMODS.Stake({
    key = "huh",
    applied_stakes = {},
    above_stake = 'gold',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    atlas = 'stakes',
    pos = {x = 4, y = 1},
    shiny = false,

    loc_txt = {
        name = "???",
        text = {
            "idk ill figure it out"
        },
    },

    modifiers = function()
    end,
})