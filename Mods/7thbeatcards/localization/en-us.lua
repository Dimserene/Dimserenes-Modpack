return {
	["descriptions"] = {
		["Back"] = {
			["b_sbc_sbg"] = {
				["name"] = "7 Beat Games Deck",
				["text"] = {
					"Ante scales 0.7 times as fast.",
					"Cards with a rank of 7 get fire or ice",
				},
			},
		},
		["Joker"] = {
			["j_sbc_test_joker"] = {
				["name"] = "Test joker",
				["text"] = {
					"Test!"
				},
			},
			["j_sbc_Chrysanthemum"] = {
				["name"] = "{C:mult}Chrysanthemum{}",
				["text"] = {
					"{C:inactive}A mage of sorts. Sells flowers at the local graveyard.",
					"{X:mult,C:white}BROKEN{C:mult} This card is unfinished and shouldn't be used.",
					"{C:inactive,s:0.7}(Character by {C:dark_edition,s:0.7}paperweightdude{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}Jogla{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}Jogla (original paperweightdude){C:inactive,s:0.7}){}",
				}
			},
			["j_sbc_skipshot"] = {
				["name"] = "Skipshot",
				["text"] = {
					"Earn {C:money}$#1#{} at end of round",
					"payout increase by {C:money}$3{} per",
					"{C:attention}skipped blind.{}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}Kin{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}Kin{C:inactive,s:0.7}){}",

				}
			},
			["j_sbc_NHH"] = {
				["name"] = "No hints here",
				["text"] = {
					"Gives between {X:mult,C:white}x1.1{} and ",
					"{X:mult,C:white}x2{} Mult randomly",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",

				},
			},
			["j_sbc_ADOFAI"] = {
				["name"] = "Fire and Ice",
				["text"] = {
					"When hand is played, alternate",
					"between {X:chips,C:white}x2{} Chips and {X:mult,C:white}x2{} Mult",
					"{C:inactive}Currently {#4#}x#1#{C:inactive} #5#{}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
				},
			},
			["j_sbc_samurai"] = {
				["name"] = "Samurai",
				["text"] = {
					"Scored 7s give {C:mult}+#1# mult",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",


				},
			},
			["j_sbc_battleworn_insomniac"] = {
				["name"] = "Battleworn Insomniac",
				["text"] = {
					"{X:mult,C:white}x#1#{} Mult every {C:attention}#4#th{} played #2#",
					"{C:inactive}#3# remaining{}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",

				},
			},
			["j_sbc_Speed_trial"] = {
				["name"] = "Speed trial",
				["text"] = {
					"Gains {X:mult,C:white}x#2#{} Mult when {C:attention}blind{} is selected",
					"Loses {X:mult,C:white}x#3#{} Mult when {C:attention}discarding{}",
					"{C:inactive}Currently {X:mult,C:white}x#1#{C:inactive} Mult{}",
					"{C:inactive,s:0.8}(Mult can't go below 1x)",


				},
			},
			["j_sbc_oneshot"] = {
				["name"] = "Oneshot",
				["text"] = {
					"Gains {X:mult,C:white}x#4#{} Mult",
					"when {C:attention}played hand{}",
					"has {C:attention}1{} card",
					"{C:inactive} (Currently {X:mult,C:white}x#3#{C:inactive} Mult){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}k_lemon{C:inactive,s:0.7}){}",
				},
			},
			["j_sbc_midspin"] = {
				["name"] = "Midspin",
				["text"] = {
					"Gains {C:mult}+#2#{} Mult every time a",
					"card with {C:attention}red seal{} is {C:attention}retriggered{}",
					"{C:inactive}(Retriggers only one time per card){}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}",
					"{C:inactive,s:0.8}\"It's called a midspin cuz you spin it in the middle of your turn\"{}",
				},
			},
			["j_sbc_spin2win"] = {
				["name"] = "Spin to Win",
				["text"] = {
					"Gains {X:mult,C:white}x#2#{} Mult when",
					"{C:attention}The Wheel of Fortune{} is used",
					"{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive} Mult){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
				},
				["mod_conv"] = {'m_glass'}
			},
			["j_sbc_practice_mode"] = {
				["name"] = "Practice mode",
				["text"] = {
					"Gains {C:chips}+#2#{} Chips per {C:attention}discarded card{}",
					"Resets when {C:attention:}boss blind{} is defeated",
					"{C:inactive} (Currently {C:chips}#3##1#{C:inactive} Chips){}",
					"{C:inactive,s:0.8}(Cannot subtract Chips){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}claltdelalt{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",

				},
			},
			["j_sbc_reduce"] = {
				["name"] = "Logun",
				["text"] = {
					"Halves blind's chip requirements",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Sprite by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",

				},
			},
		},
		["Enhanced"] = {
			["m_sbc_ice"] = {
				["name"] = "Ice",
				["text"] = {
					"Gives {C:chips}+#2#{} Chips per {C:attention}fire card{}",
					"in {C:attention}full deck{}",


				},
			},
			["m_sbc_fire"] = {
				["name"] = "Fire",
				["text"] = {
					"Gives {C:mult}+#2#{} Mult per {C:attention}ice card{}",
					"in {C:attention}full deck{}",
					"{C:mult}+#1#{} Mult",


				},
			},
		},
		["Tarot"] = {
			["c_sbc_summer"] = {
				["name"] = "The summer",
				["text"] = {
					"Enhances {C:attention}#1#{} selected",
					"cards into {C:attention}fire cards{}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
				}
			},
			["c_sbc_winter"] = {
				["name"] = "The winter",
				["text"] = {
					"Enhances {C:attention}#1#{} selected",
					"cards into {C:attention}ice cards{}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
				}
			}
		},
		["Spectral"] = {
			["c_sbc_twirl"] = {
				["name"] = "Twirl",
				["text"] = {
					"Changes the suit of each card ",
					"in the entirety of your deck.",
					"{C:inactive} (Spades > Diamonds{}",
					"{C:inactive}> Club > Hearts){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}dzar{C:inactive,s:0.7}){}",
					"{C:inactive,s:0.7}(Idea by {C:dark_edition,s:0.7}deathmodereal{C:inactive,s:0.7}){}",
				},
			},
		},
	},
	["misc"] = {
		["v_dictionary"] = {
			["a_xchips"] = {
				"X#1# Chips"
			}
		}
	}
}