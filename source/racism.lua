SMODS.PokerHand {
    key = 'racism',
    loc_txt = {
        name = "Racism",
        description = {"A Three of a Kind made of Kings"}
    },
    chips = 80, mult = 4,
    l_chips = 10, l_mult = 1,
    example = {
        { 'D_A', false },
        { 'S_K', true },
        { 'H_K', true },
        { 'C_K', true },
        { 'D_6', false },
    },
    evaluate = function(parts, hand)
        if next(parts._3) then
            local _strush = SMODS.merge_lists(parts._3)
            local royal = true
            for j = 1, #_strush do
                local rank = SMODS.Ranks[_strush[j].base.value]
                royal = royal and (rank.key == 'King')
            end
            if royal then return {_strush} end
        end
    end
}