villagers.colors = {

	body = {
		hot = { "#eb9678:128", "#ebaa78:128","#ebc178:128" }, -- pinkish, peach-ish, yellow-ish
		cold = { "#eb9678:64", "#ffd2af:64","#ffd091:64" }, -- pinkish, peach-ish, yellow-ish but more pale
		normal = { "#eb9678:128", "#ebaa78:128","#ebc178:128" }, -- pinkish, peach-ish, yellow-ish
		native = { "#800000:128", "#c02000:128","#c04000:128" }, -- dark red, reddish brown, brown tan
		desert = { "#804000:128", "#5f2705:128","#46280c:128" }, -- brown, dark reddish brown, dark brown
	},
	
	hair = {
		
		hot = { -- brown, dark brown, black
			young = { "#000000:128^[colorize:#804000:128", "#000000:192^[colorize:#804000:64", "#000000:192" }, 
			adult = { "#000000:128^[colorize:#804000:128", "#000000:192^[colorize:#804000:64", "#000000:192" }, 
			old = { "#000000:64^[colorize:#804000:64", "#000000:64" }, 
		},
		cold = { -- blonde, orange, brown
			young = { "#fff000:128", "#000000:128^[colorize:#ff4900:128", "#000000:128^[colorize:#804000:128" }, 
			adult = { "#fff000:128", "#000000:128^[colorize:#ff4900:128", "#000000:128^[colorize:#804000:128" },
			old = { "#fff000:64", "#ff4900:64", "#804000:64" },
		},
		normal = { 
			young = { 
				"#fff000:128", "#000000:128^[colorize:#ff4900:128", "#000000:128^[colorize:#804000:128", -- blonde, orange, brown
				"#000000:192^[colorize:#804000:64", "#000000:192" -- dark brown, black
			}, 
			adult = { 
				"#fff000:128", "#000000:128^[colorize:#ff4900:128", "#000000:128^[colorize:#804000:128", -- blonde, orange, brown
				"#000000:192^[colorize:#804000:64", "#000000:192" -- dark brown, black
			}, 
			old = { 
				"#fff000:64", "#ff4900:64", "#804000:64", -- graying blonde, orange, brown
				"#000000:64^[colorize:#804000:64", "#000000:64" -- graying dark brown and black
			},
		},
		native = {
			young = { "#000000:192^[colorize:#804000:64", "#000000:192" }, -- dark brown and black
			adult = { "#000000:192^[colorize:#804000:64", "#000000:192" }, -- dark brown and black
			old = { "#000000:64^[colorize:#804000:64", "#000000:64" } -- graying dark brown and black
		},
		desert = {
			young = { "#000000:192" }, -- black
			adult = { "#000000:192" }, -- black
			old = { "#000000:64" }, -- graying black
		}
	},
	
	eyes = { 
		hot = { "#000000:256", "#402000:256", "#402000:256" }, -- black and brown
		cold = { "#402000:256", "#000055:256", "#000055:256", "#005500:256" }, -- brown, blue, green
		normal = { "#000000:256", "#402000:256", "#402000:256", "#000055:256", "#005500:256" }, -- black, brown, blue, green
		native = { "#000000:256" }, -- black
		desert = { "#000000:256" } -- black
	},
	
	footwear = { -- 75% for brown, dark reddish brown, dark brown
		"#804000:128", "#5f2705:128","#46280c:128", 
		"#804000:128", "#5f2705:128","#46280c:128",
		"#804000:128", "#5f2705:128","#46280c:128",
		"#5c0000:128", "#004000:128" -- dark red and dark green
	}, 
	
	dress = { -- only desert regions do males wear dress, so other regions have 'blank' colorization layer
	
		hot = {
			male = { "#000000:0" },
			female = { "#000000:0" }
		},
		cold = {
			male = { "#000000:0" },
			-- dark brown, light brown, dark red, dark green, dark purple
			female = { "#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128" }
		},
		normal = {
			male = { "#000000:0" },
			-- brown, red, green, blue, yellow, purple
			female = { "#402000:128", "#c00000:128","#005c00:128","#000080:128","#c0c000:128","#800080:128", }
		},
		native = {
			male = { "#000000:0" },
			-- dark brown, light brown, dark red, dark green, dark purple
			female = { "#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128" }
		},
		desert = { -- light tan colors: brown, tan, yellow, and white
			male = { "#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128" },
			female = {
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128", 
				"#5c0000:128", "#5c0000:128" -- off reddish hue
			}
		}
	
	},
	
	lower = {
		hot = {
			male = { "#5f2705:128", "#ff8040:128", "#ffb579:64" }, -- darkest brown, dark brown, light brown
			-- brown, tan, light brown, red, green, purple
			female = { "#804000:128", "#ff8040:128", "#ffb57a:128", "#800000:128", "#004000:128", "#400040:128" }
		},
		cold = {
			male = { "#000000:0", "#46280c:128", "#5f2705:128" }, -- Black, darkest brown, dark brown
			-- dark brown, brown, red, green, purple
			female = {"#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128" }
		},
		normal = {
			male = { "#46280c:128", "#5f2705:128", "#ff8040:128" }, -- darkest brown, dark brown, light brown
			female = {
				"#46280c:128", "#5f2705:128", "#ff8040:128", -- darkest brown, dark brown, light brown
				"#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128"
				-- dark brown, light brown, dark red, dark green, dark purple
			}
		},
		native = {
			-- dark brown, light brown, dark red, dark green, dark purple
			male = { "#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128" }, 
			-- dark brown, light brown, dark red, dark green, dark purple
			female = { "#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128" }
		},
		desert = {
			-- light tan colors: reddish, brown, yellow, and white
			male = { "#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128" }, 
			female = {
				-- light tan colors: reddish, brown, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128",
				"#5c0000:128", "#5c0000:128" -- off reddish hue
			}
		}
	},
	
	upper = {
		hot = {
			male = { -- light tan colors: reddish, brown, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128"
			},
			female = { -- light tan colors: reddish, brown, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128", 
				"#5c0000:128", "#5c0000:128" -- off reddish hue
			},
		},
		cold = {
			male = { "#46280c:128", "#5f2705:128", "#ff8040:128" }, -- darkest brown, dark brown, light brown
			-- dark brown, brown, red, green, purple
			female = {"#46280c:128", "#804000:128", "#800000:128", "#004000:128", "#400040:128" }
		},
		normal = {
			male = { 
				-- light tan colors: reddish, brown, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128",
				"#5c0000:128", "#5c0000:128" -- off reddish hue
			}, -- darkest brown, dark brown, light brown
			female = {
				-- light tan colors: reddish, brown, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128",
				"#5c0000:128", "#5c0000:128", -- off reddish hue
				"#402000:128", "#c00000:128","#005c00:128","#000080:128","#c0c000:128","#800080:128"
				-- brown, red, green, blue, yellow, purple
			}
		},
		native = {
			male = { -- light tan colors: brown, tan, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128", 
				"#5c0000:128" -- off reddish hue
			}, 
			female = { -- light tan colors: brown, tan, yellow, and white
				
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128", 
				"#5c0000:128", "#5c0000:128" -- off reddish hue
			}
		},
		desert = {
			-- light tan colors: reddish, brown, yellow, and white
			male = { "#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128" }, 
			female = {
				-- light tan colors: reddish, brown, yellow, and white
				"#3d1500:128", "#804000:128", "#c8a53a:128", "#ffffff:128",
				"#5c0000:128", "#5c0000:128" -- off reddish hue
			}
		}
	},
	
	jackets = { "#804000:64", "#402000:64",  "#201000:64", "#000000:64" },
	
}