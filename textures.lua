--[[	REGIONS:
		cold - cold/snow villagers, light skinned, full covered and dark colored clothing, boots, and some wear jackets
		hot - desert villagers, light skinned, shorts and skins, light colored clothing, sandals
		normal - in between cold and hot, light skinned, combination of both cold and hot styles of clothing
		native - native/indian tribes, tanned skin, some males shirtless, sandals
		desert - desert dwelling tribes, dark skin,  some males wear dresses, full covered and light colored clothing, sandals
--]]


villagers.textures = {
		
		-----------------------------------
		-- BASE BODY STRUCTURE
		-----------------------------------
		
	-- base 'naked' body skin.
	body = {
		hot = { "body_medium_01.png" },
		cold = { "body_light_01.png" },
		normal = { "body_medium_01.png" },
		native = { "body_tan_01.png" },
		desert =  { "body_dark_01.png" }
	},

	-- vertical size of the whites of eyes, which later also determines the iris size
	eyes = {
		male = {
			young = { "eyes_whites_med.png" },
			adult = { "eyes_whites_sm.png", "eyes_whites_med.png" },
			old = { "eyes_whites_sm.png", "eyes_whites_med.png" }
		},
		
		female = {
			young = { "eyes_whites_med.png", "eyes_whites_med2.png", "eyes_whites_med2.png" }, -- more lashes
			adult = { "eyes_whites_med.png", "eyes_whites_med2.png" }, -- 50%/50%
			old = { "eyes_whites_med.png", "eyes_whites_med.png", "eyes_whites_med2.png" }, -- less lashes
		}
	},
	
	-- mouth 4 and 5 are slightly grinning, 1 - 3 are variations of horizontal lines
	mouth = {
		male = {
			young = {
				"mouth_01.png", "mouth_02.png", "mouth_03.png", "mouth_04.png", "mouth_05.png",
				"mouth_04.png", "mouth_05.png", -- <-- more chance of smiling 
			},
			adult = { 
				"mouth_01.png", "mouth_02.png", "mouth_03.png", "mouth_04.png", "mouth_05.png",
				"mouth_01.png", "mouth_02.png", "mouth_03.png" -- <-- more chance of neutral mouth
			},
			old = { "mouth_01.png", "mouth_02.png", "mouth_03.png", "mouth_04.png", "mouth_05.png" }
		},
		
		female = {
			young = {
				"mouth_01.png", "mouth_02.png", "mouth_03.png", "mouth_04.png", "mouth_05.png",
				"mouth_04.png", "mouth_05.png", -- <-- more chance of smiling 
			},
			adult = { "mouth_01.png", "mouth_02.png", "mouth_03.png", "mouth_04.png", "mouth_05.png" },
			old = { "mouth_01.png", "mouth_02.png", "mouth_03.png", "mouth_04.png", "mouth_05.png" }
		}
	},
	
	hair = {
		male = {
			young = {
				"hair_male_02.png", "hair_male_03.png", "hair_male_04.png", "hair_male_05.png", "hair_male_06.png", 
				"hair_male_07.png", "hair_male_08.png", "hair_male_09.png", "hair_male_11.png", "hair_male_13.png", 
				"hair_male_14.png", "hair_male_18.png", "hair_male_20.png", "hair_male_21.png", "hair_male_22.png"
			},
			adult = {
				"hair_male_02.png", "hair_male_03.png", "hair_male_04.png", "hair_male_05.png", "hair_male_06.png", 
				"hair_male_07.png", "hair_male_08.png", "hair_male_09.png", "hair_male_11.png", "hair_male_13.png", 
				"hair_male_14.png", "hair_male_18.png", "hair_male_20.png", "hair_male_21.png", "hair_male_22.png"
			},
			old = {
				"hair_male_old_01.png", "hair_male_old_02.png", "hair_male_old_03.png", "hair_male_old_04.png",
				"hair_male_old_05.png", "hair_male_old_06.png"
			}
			
		},
		female = {
			young = {
				"hair_female_00.png", "hair_female_02.png", "hair_female_03.png", "hair_female_04.png", "hair_female_05.png", 
				"hair_female_06.png", "hair_female_07.png", "hair_female_08.png", "hair_female_09.png", "hair_female_10.png", 
				"hair_female_11.png", "hair_female_12.png", "hair_female_13.png", "hair_female_14.png", "hair_female_15.png", 
				"hair_female_16.png", "hair_female_17.png", "hair_female_18.png", "hair_female_20.png", "hair_female_21.png", 
				"hair_female_22.png", "hair_female_23.png", "hair_female_27.png", "hair_female_28.png", "hair_female_28.png", 
				"hair_female_29.png", "hair_female_30.png", "hair_female_31.png", "hair_female_32.png"
			},
			adult = {
				"hair_female_00.png", "hair_female_02.png", "hair_female_03.png", "hair_female_04.png", "hair_female_05.png", 
				"hair_female_06.png", "hair_female_07.png", "hair_female_08.png", "hair_female_09.png", "hair_female_10.png", 
				"hair_female_11.png", "hair_female_12.png", "hair_female_13.png", "hair_female_14.png", "hair_female_15.png", 
				"hair_female_16.png", "hair_female_17.png", "hair_female_18.png", "hair_female_20.png", "hair_female_21.png", 
				"hair_female_22.png", "hair_female_23.png", "hair_female_27.png", "hair_female_28.png", "hair_female_28.png", 
				"hair_female_29.png", "hair_female_30.png", "hair_female_31.png", "hair_female_32.png"
				
			},
			old = {
				"hair_female_old_01.png", "hair_female_old_02.png", "hair_female_old_03.png", "hair_female_old_04.png",
				"hair_female_old_05.png", "hair_female_old_06.png"
			}
		}
	},

	
	-----------------------------------
	-- CLOTHING & ACCESSORIES
	-----------------------------------	
		
	-- Short and long sleeved full dresses
	-- texture of 'blank.png' means this type of villager will either not or have a chance of
	-- not wearing a full dress, thus this dress section will be skipped and villager will
	-- instead apply 'lower' and 'upper' clothing.
	dress = {
		hot = {
			male = {
				young = { "blank.png" },
				adult = { "blank.png" },
				old = { "blank.png" }
			},
			female = {
				young = { "blank.png" },
				adult = { "blank.png" },
				old = { "blank.png" }
			},
		},
		cold = {
			male = {
				young = { "blank.png" },
				adult = { "blank.png" },
				old = { "blank.png" }
			},
			female = {
				young = { "dress_longsleeves_dark_01.png" },
				adult = { "dress_longsleeves_dark_01.png" },
				old = { "dress_longsleeves_dark_01.png" }
			},
		},
		normal = {
			male = {
				young = { "blank.png" },
				adult = { "blank.png" },
				old = { "blank.png" }
			},
			female = {
				young = { "dress_shortsleeves_med2_01.png", "dress_longsleeves_med2_01.png" },
				adult = { "dress_shortsleeves_med2_01.png", "dress_longsleeves_med2_01.png" },
				old = { "dress_shortsleeves_med2_01.png", "dress_longsleeves_med2_01.png" }
			},
		},
		native = {
			male = {
				young = { "blank.png" },
				adult = { "blank.png" },
				old = { "blank.png" }
			},
			female = {
				young = { "dress_shortsleeves_dark_01.png", "dress_longsleeves_dark_01.png" },
				adult = { "dress_shortsleeves_dark_01.png", "dress_longsleeves_dark_01.png" },
				old = { "dress_shortsleeves_dark_01.png", "dress_longsleeves_dark_01.png" }
			},
		},
		desert = {
			male = {
				young = { "dress_longsleeves_med_02.png", "dress_longsleeves_med_02.png", "blank.png" },
				adult = { "dress_longsleeves_med_02.png", "dress_longsleeves_med_02.png", "blank.png" },
				old = { "dress_longsleeves_med_02.png" }
			},
			female = {
				young = { "dress_longsleeves_med_01.png", "dress_longsleeves_med_01.png", "blank.png" },
				adult = { "dress_longsleeves_med_01.png", "dress_longsleeves_med_01.png", "blank.png" },
				old = { "dress_longsleeves_med_01.png" }
			},
		}
	},
		
	-- Lower Body Clothing (pants, shorts, skirts, etc)
	lower = {
		hot = {
			male = {
				young = { -- 67% chance shorts, otherwise pants
					"shorts_dark_01.png", "shorts_dark_02.png",
					"shorts_dark_01.png", "shorts_dark_02.png",
					"pants_dark_01.png", "pants_dark_02.png"
				},
				adult = { -- 67% chance shorts, otherwise pants
					"shorts_dark_01.png", "shorts_dark_02.png",
					"shorts_dark_01.png", "shorts_dark_02.png",
					"pants_dark_01.png", "pants_dark_02.png"
				},
				old = { -- 67% chance shorts, otherwise pants
					"shorts_dark_01.png", "shorts_dark_02.png",
					"shorts_dark_01.png", "shorts_dark_02.png",
					"pants_dark_01.png", "pants_dark_02.png"
				}
			},
			female = {
				young = { -- 66% chance short skirts, otherwise shorts
					"skirt_short_dark_01.png", "skirt_short_dark_01.png",
					"skirt_short_dark_01.png", "skirt_short_dark_01.png",
					"shorts_dark_01.png", "shorts_dark_02.png"
				},
				adult = { -- 80% chance short skirts or shorts, otherwise long skirt
					"skirt_short_dark_01.png", "skirt_short_dark_01.png",
					"skirt_short_dark_01.png", "skirt_short_dark_01.png",
					"skirt_short_dark_01.png", "shorts_dark_01.png",
					"shorts_dark_01.png", "shorts_dark_02.png"
				},
				old = { -- 50% chance shorts, otherwise long skirt
					"shorts_dark_01.png", "shorts_dark_02.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png"
				}
			}
		},
		cold = {
			male = { -- 100% chance for dark colored pants
				young = { "pants_dark_01.png", "pants_dark_02.png" }, 
				adult = { "pants_dark_01.png", "pants_dark_02.png" },
				old = { "pants_dark_01.png", "pants_dark_02.png" }
			},
			female = {
				young = { -- 66% long skirt, otherwise pants
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"pants_01.png", "pants_02.png" 
				},
				adult = { -- 66% long skirt, otherwise pants
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"pants_01.png", "pants_02.png"
				},
				old = { -- 66% long skirt, otherwise pants
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"pants_01.png", "pants_02.png"
				}
			}
		},
		normal = {
			male = {-- 100% chance for pants
				young = { "pants_dark_01.png", "pants_dark_02.png" }, 
				adult = { "pants_dark_01.png", "pants_dark_02.png" },
				old = { "pants_dark_01.png", "pants_dark_02.png" }
			},
			female = {
				young = { -- 66% long skirt, otherwise short skirt
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_short_dark_01.png", "skirt_short_dark_01.png"
				},
				adult = { -- 80% skirts, otherwise pants
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_short_dark_01.png",
					"skirt_short_dark_01.png", "skirt_short_dark_01.png",
					"pants_dark_01.png", "pants_dark_02.png"
				},
				old = { -- 66% long skirt, otherwise pants
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"skirt_long_dark_01.png", "skirt_long_dark_01.png",
					"pants_dark_01.png", "pants_dark_02.png"
				}
			}
		},
		native = {
			male = {
				young = { -- 66% chance pants or shorts, otherwise skirts
					"pants_dark_01.png", "pants_dark_02.png",
					"shorts_dark_01.png", "shorts_dark_02.png",
					"skirt_long_dark_01.png", "skirt_short_dark_01.png"
				},
				adult = { -- 66% chance pants or shorts, otherwise skirts
					"pants_dark_01.png", "pants_dark_02.png",
					"shorts_dark_01.png", "shorts_dark_02.png",
					"skirt_long_dark_01.png", "skirt_short_dark_01.png"
				},
				old = { -- 66% chance pants or shorts, otherwise skirts
					"pants_dark_01.png", "pants_dark_02.png",
					"shorts_dark_01.png", "shorts_dark_02.png",
					"skirt_long_dark_01.png", "skirt_short_dark_01.png"
				}
			},
			female = {
				young = { -- 50% long skirts, otherwise short skirts
					"skirt_long_dark_01.png", "skirt_short_dark_01.png"
				},
				adult = { -- 50% long skirts, otherwise short skirts
					"skirt_long_dark_01.png", "skirt_short_dark_01.png"
				},
				old = { -- 100% long skirt
					"skirt_long_dark_01.png"
				}
			}
		},
		desert = {
			male = { -- 100% chance pants
				young = { "pants_med_01.png", "pants_med_02.png" }, 
				adult = { "pants_med_01.png", "pants_med_02.png" }, 
				old = { "pants_med_01.png", "pants_med_02.png" } 
			},
			female = { -- 100% long skirts
				young = { "skirt_long_med_01.png" }, 
				adult = { "skirt_long_med_01.png" },
				old = { "skirt_long_med_01.png" }
			}
		}
	},
	
	-- Upper Body Clothing (long, short and no sleeved shirts)
	upper = {
		hot = {
			male = {
				young = {
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_nosleeve_med_01.png", "shirt_nosleeve_med_02.png", "shirt_nosleeve_med_03.png",
					"shirt_nosleeve_med_04.png", "shirt_nosleeve_med_05.png", "blank.png",
					"blank.png", "blank.png", "blank.png", "blank.png" -- <-- 31% chance of wearing no shirt
				},
				adult = {
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_nosleeve_med_01.png", "shirt_nosleeve_med_02.png", "shirt_nosleeve_med_03.png",
					"shirt_nosleeve_med_04.png", "shirt_nosleeve_med_05.png", 
					"blank.png", "blank.png", "blank.png", -- <-- 21% chance of wearing no shirt at all
				},
				old = {
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_nosleeve_med_01.png", "shirt_nosleeve_med_02.png", "shirt_nosleeve_med_03.png",
					"shirt_nosleeve_med_04.png", "shirt_nosleeve_med_05.png"
				}
			},
			female = {
				young = {
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
				},
				adult = {
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
				},
				old = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png", 
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png", 
					"shirt_short_med_female_01.png"
				}
			}
		},
		cold = {
			male = {
				young = {
					"shirt_long_dark_01.png", "shirt_long_dark_02.png", "shirt_long_dark_03.png", 
					"shirt_long_dark_04.png", "shirt_long_dark_05.png"
				},
				adult = {
					"shirt_long_dark_01.png", "shirt_long_dark_02.png", "shirt_long_dark_03.png", 
					"shirt_long_dark_04.png", "shirt_long_dark_05.png"
				},
				old = {
					"shirt_long_dark_01.png", "shirt_long_dark_02.png", "shirt_long_dark_03.png", 
					"shirt_long_dark_04.png", "shirt_long_dark_05.png"
				}
			},
			female = {
				young = {
					"shirt_long_dark_01.png", "shirt_long_dark_02.png", "shirt_long_dark_03.png", 
					"shirt_long_dark_04.png", "shirt_long_dark_05.png", "shirt_long_dark_female_01.png", 
					"shirt_long_dark_female_01.png", "shirt_long_dark_female_01.png"
				},
				adult = {
					"shirt_long_dark_01.png", "shirt_long_dark_02.png", "shirt_long_dark_03.png", 
					"shirt_long_dark_04.png", "shirt_long_dark_05.png", "shirt_long_dark_female_01.png", 
					"shirt_long_dark_female_01.png", "shirt_long_dark_female_01.png"
				},
				old = {
					"shirt_long_dark_01.png", "shirt_long_dark_02.png", "shirt_long_dark_03.png", 
					"shirt_long_dark_04.png", "shirt_long_dark_05.png", "shirt_long_dark_female_01.png", 
					"shirt_long_dark_female_01.png", "shirt_long_dark_female_01.png"
				}
			}
		},
		normal = {
			male = {
				young = { -- 75% chance short sleeved shirt, otherwise long sleeved
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png"
				},
				adult = { -- 75% chance short sleeved shirt, otherwise long sleeved
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png"
				},
				old = { -- 67% chance short sleeved shirt, otherwise long sleeved
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png",
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png"
				}
			},
			female = {
				young = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png"
				},
				adult = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png"
				},
				old = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png"
				}
			}
		},
		native = {
			male = {
				young = { -- 69% chance not wearing any shirt at all
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_nosleeve_med_01.png", "shirt_nosleeve_med_02.png", "shirt_nosleeve_med_03.png",
					"shirt_nosleeve_med_04.png", "shirt_nosleeve_med_05.png", "blank.png",
					"blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", 
					"blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", 
					"blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png",
					"blank.png", "blank.png", "blank.png"
					
				},
				adult = { -- 56% chance not wearing any shirt at all
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_nosleeve_med_01.png", "shirt_nosleeve_med_02.png", "shirt_nosleeve_med_03.png",
					"shirt_nosleeve_med_04.png", "shirt_nosleeve_med_05.png",  
					"blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", 
					"blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png"
				},
				old = { -- 39% chance not wearing any shirt at all
					"shirt_tanktop_med_00.png", "shirt_tanktop_med_01.png", "shirt_tanktop_med_02.png", 
					"shirt_tanktop_med_03.png", "shirt_tanktop_med_04.png", "shirt_tanktop_med_05.png",
					"shirt_nosleeve_med_01.png", "shirt_nosleeve_med_02.png", "shirt_nosleeve_med_03.png",
					"shirt_nosleeve_med_04.png", "shirt_nosleeve_med_05.png",  
					"blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", "blank.png", 
				}
			},
			female = {
				young = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
				},
				adult = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
				},
				old = {
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
					"shirt_short_med_01.png", "shirt_short_med_02.png", "shirt_short_med_03.png", 
					"shirt_short_med_04.png", "shirt_short_med_05.png", "shirt_short_med_female_01.png",
					"shirt_short_med_female_01.png", "shirt_short_med_female_01.png",
				}
			}
		},
		desert = {
			male = {
				young = {
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png"
				},
				adult = {
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png"
				},
				old = {
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png"
				}
			},
			female = {
				young = {
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png", "shirt_long_med_female_01.png", 
					"shirt_long_med_female_01.png", "shirt_long_med_female_01.png"
				},
				adult = {
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png", "shirt_long_med_female_01.png", 
					"shirt_long_med_female_01.png", "shirt_long_med_female_01.png"
				},
				old = {
					"shirt_long_med_01.png", "shirt_long_med_02.png", "shirt_long_med_03.png", 
					"shirt_long_med_04.png", "shirt_long_med_05.png", "shirt_long_med_female_01.png", 
					"shirt_long_med_female_01.png", "shirt_long_med_female_01.png"
				}
			}
		}
	},
	
	-- Sandals, shoes and boots
	footwear = {
		hot = { "sandals_01.png", "sandals_02.png" },
		cold = { "boots_dark_01.png", "boots_dark_01.png", "boots_dark_01.png", "boots_dark_01.png", "shoes_01.png", "shoes_02.png" },
		normal = { "shoes_01.png", "shoes_02.png", "boots_dark_01.png", "sandals_01.png", "sandals_02.png" },
		native = { "sandals_01.png", "sandals_02.png" },
		desert = { "sandals_01.png", "sandals_02.png" }
	},
	
	-- Jackets
	jacket = {
		hot = { "blank.png" },
		cold = { "jacket_01.png", "blank.png" }, -- 50% chance to wear jacket
		normal = { "jacket_01.png", "blank.png", "blank.png", "blank.png" }, -- 25% chance to wear jacket
		native = { "blank.png" },
		desert = { "blank.png" }
	},

	-- base outfits of a certain theme that cannot be randomly pieced together
	outfit = {
		church = { -- more variations planned
			male = { "priest_01.png" },
			female = { "priest_01.png" }
		}
	},
	
	extra_layer = {
		empty = {
			male = {
				"strap_01.png", "strap_02.png", "strap_03.png", 
				"strap_04.png", "strap_05.png", "strap_06.png" 
			},
			female = {
				"strap_01.png", "strap_02.png", "strap_03.png", 
				"strap_04.png", "strap_05.png", "strap_06.png" 
			}
		},
		tower = {
			male = {
				"armor_01.png", "armor_01b.png", "armor_01c.png", "armor_02.png", 
				"armor_02b.png", "armor_02c.png", "armor_03.png", "armor_03b.png", 
				"armor_03c.png"
			},
			female = {
				"armor_fem_01.png", "armor_fem_01b.png", "armor_fem_01c.png",
				"armor_fem_01.png", "armor_fem_01b.png", "armor_fem_01c.png",
				"armor_01.png", "armor_01b.png", "armor_01c.png"
			}
		}
	},
	
	extra_head = {
		tower = {
			male = { "helmet_01.png", "helmet_02.png" },
			female = { "blank.png" }
		},
	},
	
	-- white collar for priests and other accessories (coming soon)
	extra_neck = {
		church = {
			male = { "collar_01.png" },
			female = { "blank.png" }
		}
	 },
	
	-- accessories worn in front
	extra_front = {
		church = {
			male = { "cross_01.png", "cross_01b.png", "cross_01c.png" },
			-- male = { "sash_01.png", "sash_01b.png", "sash_02.png", "sash_02b.png" },
			female = { "cross_01.png", "cross_01b.png", "cross_01c.png" }
		}
	},
	
	extra_back = {
		tower = { "sword_01.png", "sword_02.png", "sword_03.png", "sword_04.png" },
		empty = { 
			"backpack_01.png", "backpack_02.png", "backpack_03.png", 
			"backpack_04.png", "backpack_05.png", "backpack_06.png"
		}
	},
	
	extra_face = {
		male = {
			young = { "blank.png" },
			adult = { "blank.png" },
			old = { "eye_glasses_01.png", "blank.png" }
		},
		female = {
			young = { "blank.png" },
			adult = { "blank.png" },
			old = { "eye_glasses_01.png", "blank.png" }
		}
	}

}