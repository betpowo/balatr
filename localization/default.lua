local localization = {
    descriptions ={
        Joker = {
            ['j_*_balatr'] = {
                name = 'Balatr',
		        text = {
		        	"Will send you to",
                    "the title screen"
		        },
            },

            ['j_*_jokoj'] = {
                name = 'JokoJ',
		        text = {
		        	"{C:inactive}/jo - qwuj/{}",
		        	"{C:chips}+#1#{} Chips",
		        	"if played hand is",
		        	"a {C:attention}palindrome{}",
		        	"{C:inactive}(ex: {C:attention}4 3 2 3 4{C:inactive})"
		        },
            },

            ['j_*_reker'] = {
                name = 'reker',
		        text = {
		        	"{C:inactive}/ruh - kur/{}",
		        	"{C:mult}+#1#{} Mult",
		        	"if played hand is",
		        	"a {C:attention}palindrome{}",
		        	"{C:inactive}(ex: {C:attention}4 3 2 3 4{C:inactive})"
		        },
            },

            ['j_*_macaron'] = {
                name = 'macaron',
		        text = {
		        	"mmm...macaron",
		        	"{X:mult,C:white}X#1#{} Mult",
                    "{C:mult}-1{} at end of round",
		        },
            },

            ['j_*_gato'] = {
                name = 'El Gato Balatro',
		        text = {
		        	"{C:chips}+#1#{} Chips",
			        "for every {C:diamonds}Diamond{} card",
			        "played, also plays a sound"
		        },
            },

            ['j_*_super_f'] = {
                name = 'SUPER F',
		        text = {
		        	"Each played {C:attention}2{} gives",
			        "{C:mult}+#1#{} Mult when scored",
		        },
            },

            ['j_*_fuck_you'] = {
                name = 'FUCK YUO',
		        text = {
		        	"{X:mult,C:white}X#1#{} Mult",
		        },
            },

            ['j_*_slothful'] = {
                name = 'Slothful Joker',
		        text = {
		        	"Played cards with",
			        "{C:"..BalatrMod.prefix('blorbs').."}Blorb{} suit give",
			        "{C:mult}+#1#{} Mult when scored"
		        },
            },

            ['j_*_gambler'] = {
                name = 'Gambler',
		        text = {
		        	"{X:mult,C:white}X#1#{} Mult and {C:money}$#3#",
			        "on a {C:chips,E:2}certain condition,",
			        "{X:mult,C:white}X#2#{} Mult and {C:red}-$#4#{} otherwise",
		        },
            },

            ['j_*_gc'] = {
                name = 'Garbage Collector',
		        text = {
		        	"Destroys up to {C:attention}#1#{} {C:inactive}(#3#){}",
			        "{C:red}discarded{} cards per round and",
			        "adds their {C:chips}Chips{} to this Joker",
			        "{C:inactive}(Currently {}{C:chips}+#2#{}{C:inactive} Chips){}",
			        "{C:inactive}(Resets after {}{C:attention}Boss{}{C:inactive} Blind){}"
		        },
            },

            ['j_*_fetus'] = {
                name = 'Fetus',
		        text = {
		        	"{C:chips}+#1#{} measly chip",
		        },
            },
            
            ['j_*_bdv'] = {
                name = 'PagoMovil',
		        text = {
		        	"Go up to {C:red}-$#1#{} in debt",
			        "{C:green}#2# in #3#{} chance to earn",
			        "{C:money}$#4#{} at end of round"
		        },
            },
            
            ['j_*_blank'] = {
                name = 'Blank',
		        text = {
		        	"{C:inactive}Does nothing...?"
		        },
            },

            ['j_*_aldi'] = {
                name = 'Aldi',
		        text = {
		        	"{C:green}#1# in #2#{} chance",
                    "to give ",
		        },
            },

            ['j_*_atomic_bomb'] = {
                name = 'Atomic Bomb',
		        text = {
		        	"{X:"..BalatrMod.prefix('e_chips')..",C:white}^#1#{} Chips and {X:"..BalatrMod.prefix('e_mult')..",C:white}^#2#{} Mult",
			        "{C:red,E:2}self destructs{}"
		        },
            },

            ['j_*_duke'] = {
                name = 'Duke',
                text = {
                    "{s:0.6,C:inactive}he's in my fucking jokers{}",
			        "{X:chips,C:white}X#1#{} Chips if",
			        "{C:attention}Java{} is installed",
			        "{s:0.8,C:inactive}(requires game restart{}",
			        "{s:0.8,C:inactive}if installing){}",
                }
            },

            ['j_*_admin_card'] = {
                name = 'Admin Card',
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
			        "{C:green}#2# in #3#{} chance to instead {C:red}half{}",
			        "your score and add {C:blue}+#4#{} hand",
			        "{C:inactive,s:0.75}(does not trigger on first hand){}",
			        "{C:red,E:2}self destructs{}",
                }
            },

            ['j_*_skeleton'] = {
                name = 'Roaring Skeleton',
                text = {
			        "{C:green}#1# in #2#{} chance to give",
			        "{C:white,X:mult}X#3#{} Mult, {C:attention}#4#{} times",
                }
            },
            
            ['j_*_bunny'] = {
                name = 'Bouncing Bunny',
                text = {
                    "{B:2,V:1}#1##2#{} Chips",
			        "{C:inactive}({}{C:"..BalatrMod.prefix('rainbow')..",E:2}Operator{} {C:inactive}changes each round){}"
                }
            },

            ['j_*_jimbius'] = {
                name = '{C:mult}Demonic Warrior Jimbius',
                text = {
                    "{C:inactive}(Age: 16) (Personality: Dangerous){}",
			        --"Destroy all other jokers.", --maybe some other time
			        "With each played hand, increase {V:1,E:"..BalatrMod.prefix('shake').."}Blood Fury{}.",
			        "At {V:1,E:"..BalatrMod.prefix('shake').."}#5#{} Blood Fury, gain {C:mult}+#1#{} Mult and a stack",
			        "of {C:"..BalatrMod.prefix('e_mult').."}Nightmare Demon Mode Tokens{}. At {C:"..BalatrMod.prefix('e_mult').."}#6#{}",
			        "Nightmare Demon Mode Tokens {C:inactive}(NDMT){}, gain",
			        "{X:mult,C:white}X#2#{} Mult and activate {C:hearts,E:1}Whirlpool of Destruction{}.",
			        "{C:hearts,E:1}Whirlpool of Destruction{} deletes all cards in your",
			        "hand but adds a {C:dark_edition}Demonic Energy Filter{} to all",
			        "future drawn cards {C:inactive}(during a Blind){}",
			        "{C:inactive}(Currently {}{V:1,E:"..BalatrMod.prefix('shake').."}#3#{}{C:inactive} Blood Fury, {C:"..BalatrMod.prefix('e_mult').."}#4#{} {C:inactive}NDMT){}",
			        "{C:inactive}(Whirlpool: {}{V:2,E:1}#7#{}{C:inactive}){}"
                }
            },
            
            ['j_*_idk'] = {
                name = 'IDK',
                text = {
                    "Adds a {C:"..BalatrMod.prefix('rainbow').."}perma-bonus{}",
			        "to every card scored",
                }
            },

            ['j_*_c_'] = {
                name = 'c_',
                text = {
                    "Be able to {C:"..BalatrMod.prefix('rainbow').."}reroll{} cards",
			        "in {C:attention}Booster{} Packs",
			        "{C:inactive}({}{C:red}Discarded{}{C:inactive} cards will be moved",
			        "{C:inactive}to {C:attention}top{}{C:inactive} of the deck and {C:"..BalatrMod.prefix('rainbow').."}new",
			        "{C:inactive}cards will be picked from the {C:attention}bottom{C:inactive})"
                }
            },

            ['j_*_tiny'] = {
                name = ':tiny:',
                text = {
                    "Be able to select",
			        "{C:"..BalatrMod.prefix('rainbow').."}+#1#{} more card"
                }
            },

            ['j_*_paradise'] = {
                name = ' ',
                text = {
                    "{C:green}#1# in #2#{} chance to",
			        "{C:"..BalatrMod.prefix('rainbow').."}purge{} a random Joker",
			        -- it was gonna do playing cards too but that feels like too much
			        "{C:inactive}(Returns in {}{C:attention}#3# {}{C:inactive}rounds){}"
                }
            },
        },
        Enhanced = {
            ['m_*_mint'] = {
				name = "Mint Card",
				text = {
					"{C:white,X:chips}X#1#{} chips"
				}
			},
            ['m_*_cool'] = {
				name = "Cool Card",
				text = {
					"{X:"..BalatrMod.prefix('e_chips')..",C:white}^#1#{} chips"
				}
			},
            ['m_*_hack'] = {
				name = "Hacked Card",
				text = {
                    "{C:purple,E:1}Always scores",
					"Gives {C:chips}+#1#{} chips",
                    "if held in hand",
				}
			},
            ['m_*_demo'] = {
				name = "Demo Card",
				text = {
					"{C:chips}+#1#{} extra chips",
                    "Destroyed after {C:attention}#2#{} uses"
				}
			},
            ['m_*_swap'] = {
				name = "Swap Card",
				text = {
					"Swaps {C:chips}Chips{} and {C:mult}Mult",
                    "{C:inactive,s:0.4}(how original...)"
				}
			},
            ['m_*_concrete'] = {
				name = "Concrete Slab",
				text = {
					"{C:white,X:mult}X#1#{} Mult",
                    "if held in hand,",
                    "otherwise, {C:white,X:chips}X#2#{} chips",
                    "no rank or suit",
				}
			},
            ['m_*_whatsapp'] = {
				name = "WhatsApp Card",
				text = {
					"{C:purple,E:1}Balances{} {C:chips}Chips{} and {C:mult}Mult",
                    "no rank or suit",
				}
			},
            ['m_*_star'] = {
				name = "Glitter Card",
				text = {
					"Give a random {C:attention}tag{} when",
                    "card does {C:attention}not{} score"
				}
			},
        },
        Tarot = {
            ['c_*_nebula'] = {
				name = "Nebula",
				text = {
					"Converts up to",
                    "{C:attention}#1#{} selected cards",
                    "to {C:"..BalatrMod.prefix('blorbs').."}Blorbs{}",
				}
			},
            ['c_*_towel'] = {
				name = "The Towel",
				text = {
					"Adds a random {C:attention}enhancement{}",
			        "to {C:attention}#1#{} selected cards"
				}
			},
        },
        Spectral = {
            ['c_*_reciprocal'] = {
				name = "Reciprocal",
				text = {
					"{C:dark_edition}Negative{} Jokers become normal,",
			        "and {C:attention}vice-versa{}"
				}
			},
            ['c_*_outcast'] = {
				name = "Outcast",
				text = {
					"Applies {C:dark_edition}Negative{} to",
			        "{C:attention}#1#{} selected playing card,",
			        "{C:red}Halves{} your money"
				}
			},
        },
        BalatrEdible = {
            ['c_*_food_apple'] = {
				name = "Apple",
				text = {
					"Adds {C:chips}+#1#{} Chips to",
			        "{C:attention}#2#{} selected card"
				}
			},
            ['c_*_food_orange'] = {
				name = "Orange",
				text = {
					"Adds {C:mult}+#1#{} Mult to",
			        "{C:attention}#2#{} selected card"
				}
			},
            ['c_*_food_lemon'] = {
				name = "Lemon",
				text = {
					"Adds {C:white,X:chips}X#1#{} Chips to",
			        "{C:attention}#2#{} selected card"
				}
			},
            ['c_*_food_lime'] = {
				name = "Lime",
				text = {
					"Adds {C:white,X:mult}X#1#{} Mult to",
			        "{C:attention}#2#{} selected card"
				}
			},
            ['c_*_food_choco_ball'] = {
				name = "Chocolate Ball",
				text = {
					"Adds {C:money}$#1#{} on scoring to",
			        "{C:attention}#2#{} selected card"
				}
			},
            ['c_*_food_chip'] = {
				name = "Potato Chip",
				text = {
					"Adds {C:"..BalatrMod.prefix('rainbow').."}+#1#{} to",
			        "current {C:attention}round{} score"
				}
			},
            ['c_*_food_pear'] = {
				name = "Pear",
				text = {
					"Adds {X:mult,C:white}X#1#{} {C:attention}held{} Mult to",
			        "{C:attention}#2#{} selected card"
				}
			},
            ['c_*_food_empanada'] = {
				name = "Empanada",
				text = {
					"Adds {C:attention}+#1#{} {C:chips}Chips{} or {C:mult}Mult{} to",
			        "{C:attention}#2#{} random cards in hand",
				}
			},
        },
        -- planets are auto-handled since they all share the same text and vars
        Edition = {
            ['e_*_ultra'] = {
				name = "Ultra",
				text = {
					"{X:"..BalatrMod.prefix('e_mult')..",C:white}^#1#{} Mult"
				}
			},
            ['e_*_demonic'] = {
				name = "Demonic Energy Filter",
				text = {
					"{C:chips}+#1#{} Chips",
			        "{X:chips,C:white}X#2#{} Chips",
			        "{X:"..BalatrMod.prefix('e_chips')..",C:white}^#3#{} Chips",
			        "{C:mult}+#4#{} Mult",
			        "{X:mult,C:white}X#5#{} Mult",
			        "{X:"..BalatrMod.prefix('e_mult')..",C:white}^#6#{} Mult",
				}
			},
            ['e_*_wiggly'] = {
				name = "Wiggly",
				text = {
					"Adds {X:"..BalatrMod.prefix('rainbow')..",C:white}?#1#{} to a random {C:"..BalatrMod.prefix('rainbow')..",E:2}operation",
                    "{C:inactive}({C:chips}+Chips{C:inactive}, {X:mult,C:white}XMult{C:inactive}, {X:"..BalatrMod.prefix('e_chips')..",C:white}^Chips{C:inactive}, etc.)"
				}
			},
            ['e_*_replica'] = {
				name = "Replica",
				text = {
					"{C:white,X:chips}X???{} chips",
			        "{C:inactive,s:0.8}(if destroyed, never comes back)"
				}
			},
        },
        Blind = {
            ['bl_*_evil'] = {
                name = 'The Evil',
                text = {
		        	"All cards are debuffed"
		        },
            },

            ['bl_*_vacuum'] = {
                name = 'The Vacuum',
                text = {
		        	"All Blorb cards", "are debuffed"
		        },
            },

            ['bl_*_reunion'] = {
                name = 'The Reunion',
                text = {
		        	"All cards in deck", "are held in hand"
		        },
            },

            ['bl_*_green'] = {
                name = 'The Green',
                text = {
		        	'Enables "green mode"'
		        },
            },

            ['bl_*_conveyor'] = {
                name = 'The Conveyor',
                text = {
		        	'Hand rotates to the left'
		        },
            },

            ['bl_*_ceiling'] = {
                name = 'The Ceiling',
                text = {
		        	'It says "gullible" on it.'
		        },
            },

            ['bl_*_gilbert'] = {
                name = 'gilbert',
                text = {
		        	"Shuffles and flips", "cards held in hand", "after each hand played"
		        },
            },
        },
        Other = {
            ['*_idk'] = {
                name = "Powered-up",
                text = {
                    'Card has a {C:'..BalatrMod.prefix('rainbow')..'}perma-bonus{}',
                    'applied by {C:attention}IDK{}',
                    '{s:0.8,C:inactive}(Sticker does nothing on its own)'
                },
            },
            ['*_booster_blorb'] = {
                name = "Blorb Zone",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:"..BalatrMod.prefix('blorbs').."}Blorb{} cards to",
                    "add to your deck",
                },
            },
        }
    },
    misc = {
        v_text = {
            ['ch_c_*_evil'] = {'Start with only a {C:dark_edition}Demonic Energy Filter{}ed 6 of {C:hearts}Hearts'},
            ['ch_c_*_rental_con'] = {'{C:green}1 in 4{} chance for consumables to be {C:attention}Rental{}'},
            ['ch_c_*_rental_con2'] = {'{C:inactive}(cannot be used immediately)'},
            ['ch_c_*_blorb'] = {'Start with {C:'..BalatrMod.prefix('blorbs')..'}Blorbs{} only {C:inactive}(i cant ban the default suits :<){}'},
            ['ch_c_scaling'] = {"Required score scales {C:attention}X#1#{} faster for each {C:attention}Ante"},
        },
        challenge_names = {
            ['c_*_evil_balatr'] = 'Evil Balatro',
            ['c_*_venezuela'] = 'Venezuela',
            ['c_*_blorb'] = 'Blorb World',
            ['c_*_suffering'] = 'Suffering From Success',
        },
        poker_hands = {
            ['*_racism'] = 'Racism',
            ['*_3pair'] = 'Three Pair',
            ['*_2x3'] = 'Double Triple',
            ['*_colony'] = 'Colony',
            ['*_6oak'] = 'Six of a Kind',
            ['*_flush_6'] = 'Why',
            ['*_no'] = 'No',
        },
        poker_hand_descriptions = {
            ['*_racism'] = {"A Three of a Kind made of Kings"},
            ['*_3pair'] = {"3 pairs of cards with different ranks"},
            ['*_2x3'] = {"2 sets of 3 cards with the same rank"},
            ['*_colony'] = {"A Four of a Kind and a Pair"},
            ['*_6oak'] = {"6 cards that share the same rank"},
            ['*_flush6'] = {"6 cards with the same rank and suit"},
            ['*_no'] = {"What have you done."},
        },
        suits_plural = {['*_Blorbs']="Blorbs",},
        suits_singular = {['*_Blorbs']="Blorb",},
        labels = {
			['*_ultra']   = 'Ultra',
			['*_demonic'] = 'Demonic',
            ['*_wiggly']  = 'Wiggly',
			['*_replica'] = 'Replica',
            ['*_idk']     = 'Powered-up',
		},

        -- NOTE FOR FUTURE BETTY
        -- "v_dictionary" is for locales with variables.
        -- just "dictionary" is for general text, no vars
        v_dictionary = {
            ['k_*_fetus_born'] = "It's a #1#!",
        },
        dictionary = {
            ['b_balatredible'] = 'Consumable',
            ['b_balatredible_cards'] = 'Consumables',

            ['k_inactive'] = 'inactive',
            ['k_*_blorb'] = 'Blorb.',

            ['k_*_swap'] = 'Swap!',
            ['k_*_trial_ended'] = 'Trial Ended!',
            ['k_*_tag_ex'] = 'Tag!',

            ['k_*_whirlpoop_active'] = 'Whirlpool Activated!',
            ['k_*_gc_alloc_ex'] = 'Allocated!', -- definitely not the correct term for "filling up all the space"
            ['k_*_gc_dumped_ex'] = 'Dumped!',
            ['k_*_fetus_kicking'] = "It's kicking!",
            ['k_*_jackpot_ex'] = 'Jackpot!',

            ['k_*_purged_ex'] = 'Purged!',
        }
    }
}











































function formatKeys(t)
    local ret = {}                                              -- we do not use the func here. the
    for k, v in pairs(t) do                                     -- func adds an extra _
        ret[(type(k) == 'string' and k:find('*')) and k:gsub('([*])', BalatrMod.obj.prefix) or k]
        = (type(v) == 'table') and formatKeys(v) or ((type(v) == 'string') and v:gsub('[°]', BalatrMod.obj.prefix) or v)
    end
    return ret
end

local bleh = formatKeys(localization)
return bleh