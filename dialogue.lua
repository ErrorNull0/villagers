local DEFAULT_HI = {
   "Hi!", "Hi.", 
   "Hello!", "Hello.",
   "Greetings!", "Hey.",
   "Nice to see you.",
   "How's it going.",
   "Howdy.",
   "What's up."
}

local DEFAULT_BYE = {
   "Goodbye.", 
   "Bye!", "Bye.", 
   "Good day.",
   "Later.",
   "See you later!"
}
	
local DEFAULT_MAIN = {
	"I spawned near a BUILDING_TYPE.", 
	"I am a AGE GENDER.",
	"I haven't been assigned any\n"..
	"custom dialgue yet."
}

villagers.chat = {

	-- chat spamming when chatting too fast
	spam = {
		"Say again?", "Come again?", 
		"I'm sorry?", "Sorry?", 
		"Didn't hear you?", 
		"Didn't hear?", "Wat?", 
		"Wut?",	"Huh?", "Eh?", "Hm?"
	},

	-- SMALLTALK
	smalltalk = {
	   "It's a nice day.",
	   "You look adventurous!",
	   "Good day today.",
	   "What should I eat today..",
	   "What should I do...",
	   "Like the weather today?",
	   "What brings you here?",
	   "Look - over there!\n...\nHahaha.",
	   "Hope all is well?",
	   "I smell somthing.\nIs that you?", 
	   "I hear something...",
	   "Did you see that?",
	   "Oh, it's you.",
	   "[looks over their shoulder]",
	   "[stares intently at you]",
	   "[smiles]",
	   "[whistles]",
	   "Hmm. Yep.", "Ho hum.", "Huh.",
	   "Heyo.", "Ooh!", "Umm.", "Uhh.",
	   "Heh.", "Hey..", "...", 
	   "Wat.", "Wut.",
	   "You look nice in that.",
	   
	   -- funny stuff
	   "I think I'm dying...", 
	   "Lost my train of thought...",
	   "[whispers]\nKill me.", 
	   "[whispers]\nI think I love you.", 
	   "Where am I?",
	   "Who am I?",
	   "I forgot what day\n"..
	   "it is today.",
	},
	
	-- when villager has gone through all the
	-- 'main' chat digalogue and ends the chat
	gtg = {
	   "I should go now.\nGood day!",
	   "Got to go...\nGoodbye.",
	   "Need to continue my\nday... Bye!",
	   "Well, I should break\nnow... Later!",
	   "Nice chatting with\nyou... Goodbye!",
	   "Must go now...\nHave a nice day!",
	   "I should resume my\nday... Bye!"
	},
	
	-- TRADING_CHAT
	 trade = {
		hi = {
			"Want to trade?",
			"See anything you like?",
			"What would you like?",
			"Here's what I have...",
			"Trade for what I've got?",
			"Want these for trade?",
			"Interested in these?"
		},
		
		none = {
			"Sorry, no interest in trading.",
			"Nothing to sell you, sorry.",
			"I don't have anything to sell.",
			"Trade? Not today.",
			"I have no trades today.",
			"Sorry, nothing to trade."
		},
		
		bye = {
			"Thanks for looking.",
			"Come back again!",
			"Trade again later!",
			"I might have more later.",
			"Come again next time."
		}
	},

	-- WALK_CHAT
	walk = { 
		"Oh hi! I was just about\n"..
		"to walk onward!", 
		"Hello! Was just about to\n"..
		"walk around a bit.", 
		"Oh! I was about to go.\n"..
		"How's it going?"
	},
	
	walking = {
		"Pardon me..",
		"Excuse me..",
		"Going through..",
		"Make way.. sorry..",
		"Sorry, just walking..",
		"On my way..",
		"Moving onward..",
		"Pardon, moving through..",
		"Walking through.. pardon.."
	},
	
	walkback = {
		"Going the other way..",
		"Turning back..",
		"Other way.."
	},
	
	busy = {
		"Pardon me..",
		"Excuse me.",
		"Ah, pardon..",
		"Oh, excuse me..",
		"Pardon..",
	},

	-- DIG_CHAT
	dig = { 
		cotton = {
			"Oh! Just picking cotton.\n"..
			"I didn't notice you. Hello!",
			"Just harvesting cotton.\n"..
			"How are you?",
			"Oh! I was just harvesting\n"..
			"this cotton here.",
			"Cotton is ready. Time\n"..
			"to harvest!"
		},
		wheat = {
			"Oh! Just picking wheat.\n"..
			"I didn't notice you. Hello!",
			"Just harvesting wheat.\n"..
			"How's it going?",
			"Oh hi! I was harvesting\n"..
			"this wheat over here.",
			"The wheat is ready. Time\n"..
			"to harvest!"
		},
		grass = {
			"Oh! Just removing some grass.\n"..
			"I didn't notice you. Hello!",
			"Oh hello. Grass is getting\n"..
			"too long over here.",
			"Just trimming this grass.\n"..
			"Hello there!",
			"Oh hi! Just gathering some\n"..
			"of this grass."
		},
		flower = {
			"Oh! Just picking flowers.\n"..
			"I didn't notice you. Hello!",
			"Oh hello! I'm gonna pick\n"..
			"some flowers.",
			"Just gathering a flower\n"..
			"or two. How are you?",
			"Oh hi! Just about to pick\n"..
			"the flowers there."
		},
		snow = {
			"Oh! Just digging up snow.\n"..
			"I didn't notice you. Hello!",
			"Snow all over the place!",
			"Too bad snow doesn't\n"..
			"dig itself away.",
			"I can barely walk with\n"..
			"all this snow everywhere!",
			"You like digging up snow?\n"..
			"Yea, I don't either!",
			"Snow, snow, snow...",
			"Yay! More snow.\n"..
			"[grumbles]",
			"Plenty of snowballs with\n"..
			"all this snow!"
		}
	},

	allmende = { 
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I'm VILLAGER_NAME.", 
			"The space around here is\n"..
			"the allmende.",
			"This is the common area for\n"..
			"us who live here.",
			"You are free to use this\n"..
			"area for your purposes.",
			"Please be courteous to others\n"..
			"who also wish to use this\n"..
			"shared space."
		}
	}, 
	
	bakery = { 
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"VILLAGER_NAME is my name.", 
			"I love baking!",
			"Yep, that is my bakery.",
			"The fresh smell of baked bread\n"..
			"in the morning is the best!",
			"I have warm, delicious bread if\n"..
			"you want to trade for some.",
			"I will glady take any extra\n"..
			"wheat off your hands!",
			"Try to steal my fresh bread\n"..
			"and my roller will be flying...",
		}, 
	},
	
	bench =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	chateau = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	church = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			"Yes, that is the church.",
			"How is your heart and your\n"..
			"spirit today?",
			"Are you happy, my child?",
			"I can give you a blessing.",
			"Do you pray?",
			"Offerings are most welcome!",
			"[nods and smiles]",
			"Follow your path.",
			"Tomorrow is always a new day.",
			"Find your inner peace.",
			"Nothing is impossible."
		}
	}, 
	
	deco = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"Hello, I'm VILLAGER_NAME.", 
			"I'm just waiting around by\n"..
			"the lamp post.",
			"Do you see a lamp post?\n"..
			"No? Then I might be at the\n"..
			"park. Hmm.",
			"This is a nice park!\n"..
			"...or lamp post. Hehehe.",
			"Have you heard of this person\n"..
			"named Sokomine?",
			"Sokomine says I should be near\n"..
			"a park... or a lamp post.",
			"Hmm. A statue of me here at\n"..
			"this park would be amazing!",
			"There should be a sign with\n"..
			"the name of our village here.",
			"I should plant a beautiful\n"..
			"flower garden right here!"
		}
	}, 
	
	empty =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.",
			"Hello. I'm just a visitor here.",
			"Do you know of other interesting\n"..
			"villages to visit?",
			"Smaller villages do not have\n"..
			"paved roads.",
			"You seem like a taveller.",
			"This seems like a nice place.",
			"Do I have something to trade?\n"..
			"Maybe. Maybe not.",
			"A sleeping mat and a torch\n"..
			"are all you need to travel!",
			"Just resting a bit here in\n"..
			"this village.",
			"Some villages have fountains.",
			"Some villages have a guard tower.",
			"I only travel during the daytime.",
			"I have nowhere else interesting\n"..
			"to go at the moment.",
			"Oh I'm just standing around..\n"..
			"enjoying the day.",
			"I'm just traveling through."
		}
	}, 
		
	farm_full =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I'm VILLAGER_NAME.", 
			"Like my big farm?",
			"Want to trade for something\n"..
			"from my fields?",
			"Perhaps I'll start farming\n"..
			"some animals on day.",
			"Sheep like to eat weeds.."..
			"Maybe I should raise sheep.",
			"I wonder if cows are easier\n"..
			"to farm compared to pigs.",
			"Bacon is delicious!",
		}
	}, 
	
	farm_tiny = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			"I have a small farm.",
			"Chickens keep eating my seeds.",
			"Want to trade for something\n"..
			"from my garden?",
			"One day I want to tend a\n"..
			"larger garden.",
			"Weeds... so many weeds.",
			"Maybe farming animals is easier.",
			"What's your favorite vegatable?",
		}
	}, 
	
	field = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			"I work in the field.",
			"I enjoy working outdoors.",
			"I hope the weather is kind\n"..
			"to my crops this year.",
			"Would you like to trade for\n"..
			"some of what I've grown?",
			"It can be hard work tending\n"..
			"this field.",
			"Birds can be so beautiful..\n"..
			"but not in my field!",
			"Dig, dig, dig...",
			"Prune, prune, prune...",
			"I might need more water...",
		}
	},  
	
	forge = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I'm VILLAGER_NAME.", 
			
			"Yup, that is my forge.",
			
			"Protect yourself with my\n"..
			"weapons and armor.",
			
			"I sometimes have other\n"..
			"equipment if you like..",
			
			"If you have the required metals,\n"..
			"I can sell weapons you need.",
		}
	}, 
	
	fountain = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			
			"That is the fountain there.",
			
			"I like hanging around\n"..
			"all kinds of fountains.",
			
			"Fountains are so neat.",
			
			"On a hot day, I just want\n"..
			"to jump in!",
			
			"People like throwing coins\n"..
			"in the fountain.",
			
			"I can trade different coins\n"..
			"if you want.",
			
			"Birds like the fountain too!",
			
			"You shouldn't drink the water.",
			
			"Someone once put a\n"..
			"fish in there!",
			
			"Make a wish!"
		}
	}, 
	
	horsestable = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	house = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			
			"Yep, it's my house.",
			
			"My place is not so big.",
			
			"I like my house.",
			
			"Have you heard of this\n"..
			"thing called carpet?",
			
			"Time for more furniture!",
			
			"I have a creaky door.",
			
			"Mossy walls seem nice.",
			
			"I need another window.",
			
			"Do you have wooden floors?",
			
			"Strangers keep entering\n"..
			"and exiting my home.",
			
			"Hmm.. I dunno about torches\n"..
			"inside the house.",
			
			"My roof doesn't seem so\n"..
			"rain resistant.",
			
			"Yea.. my home is a bit\n"..
			"empty for now.",
			
			"I can't lock my doors."
		}
	}, 
	
	hut = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			"That's my hut.",
			"The space is tiny, but\n"..
			"I don't mind it.",
			"The place is not too bad.",
			"At least I don't worry about\n"..
			"furnature because none will fit!",
			
			"I smacked my face on\n"..
			"the door once.",
			
			"I do enjoy the smell of\n"..
			"natural wood in my hut.",
			
			"If my move my hut under a tree,\n"..
			"perhaps I won't even need a roof!",
			
			"My home doesn't get robbed\n"..
			"since there's nothing to take!",
			
			"A friend was brave and\n"..
			"posted a torch in their hut\n"..
			"and it burned down pretty quick.",
			
			"I wonder if my hut has termites.",
			
			"Hmm.. I might as well just\n"..
			"remove my door.",
			
			"I'd invite you to lunch in my\n"..
			"cozy home, but I don't think\n"..
			"we can both fit. [shrugs]"
		}
	}, 
	
	inn =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	library = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			
			"That is the library.",
			
			"Interested in buying a new book?",
			
			"I sell empty books that can be\n"..
			"useful to you as a journal!",
			
			"You can find books on many topics.",
			
			"The more you know, the better\n"..
			"prepared you will be out there.",
		}
	}, 

	lumberjack = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	mill = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			"Yep, that's my flour mill.",
			"The bakers rely on my mill\n"..
			"for their flour.",
			"The mill mostly works on it's\n"..
			"own, but if a something needs\n"..
			"repair, it can be a nightmare!",
			"You need flour? I'll gladly\n"..
			"trade with you...",
			"I can take some of your wheat\n"..
			"if you want to trade for it.",
			"At times small insects would\n"..
			"get ground up with the flour.\n"..
			"It's all protein anyway!"
		}, 
	}, 
	
	pasture = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	pit = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I am VILLAGER_NAME.", 
			"I work in that pit.",
			"What I do is gather clay\n"..
			"from the ground",
			"I may have some extra material\n"..
			"that I can trade with you...",
			"I'm sure you can craft many\n"..
			"useful things from clay!\n"..
			"Or maybe not? [shrugs]",
			"Someone once said that some\n"..
			"clay tastes like play-doh.\n"..
			"What is this 'play-doh'?"
		}
	}, 
	
	sawmill = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	school = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	secular = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"Call me VILLAGER_NAME.",
			"Welcome to our village!",
			"I trust you are having\n"..
			"a nice time here?",
			"Have you noticed the different\n"..
			"buildings in each village?",
			"Visited a library before? You\n"..
			"can learn many things there.",
			"Did you know larger villages\n"..
			"will have a village square?",
			"It seems you are the\n"..
			"the quiet type?"
		}
	}, 
	
	shed =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	shop = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I'm VILLAGER_NAME.", 
			
			"That is my shop, welcome!", 
			
			"I have tools, equipment, and\n"..
			"food for your travels!",
			
			"Sometimes I have healing\n"..
			"items too.",
			
			"Be sure to take a raft or boat\n"..
			"with you to make exploring the\n"..
			"open waters much easier.",
			
			"You will need an axe to take\n"..
			"down trees.",
			
			"Axes will always chop down\n"..
			"wooden materials faster.",
			
			"Use a shovel to dig dirt, sand,\n"..
			"gravel and other ground stuff.",
			
			"You can use your hand to dig\n"..
			"up dirt, but a shovel will make\n"..
			"it much easier!",
			
			"You'll need a pickaxe to dig\n"..
			"stone and rock.",
			
			"Don't forget to bring\n"..
			"food with you!",
			
			"Be sure to keep your belongings\n"..
			"safe with a locked chest!"
		}
	}, 
	
	spawn = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN	
		},
	
	tavern = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			
			"The tavern is not yet open.",
			
			"An assortment of drinks will\n"..
			"surely be available soon!",
			
			"I plan to have good food\n"..
			"served in the tavern too!",
			
			"Many villagers can't wait\n"..
			"for the tavern to open.",
			
			"The tavern will be the"..
			"site of the town!",
			
			"I will be welcoming food and\n"..
			"drink suggestions.",
			
			"I need to find some nice\n"..
			"hostesses for my tavern.",
		}
	}, 
	
	tent = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	},  
	
	tower =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I'm VILLAGER_NAME.", 
			
			"Yes, that is a guard tower!",
			
			"I patrol this area.",
			
			"Do you know how to\n"..
			"use a bow?",
			
			"Have a look at my armor!"
		}
	}, 
	
	townhall =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	},
	
	trader = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"VILLAGER_NAME is my name.", 
			"Yep, I'm a clay trader!",
			"If you want some clay, I\n"..
			"can trade you for some.",
			"I gather clay from the pit\n"..
			"workers and provid to those\n"..
			"who can use it.",
			"Clay is fairly commonly found\n"..
			"in the earth actually.",
		}
	}, 
	
	village_square = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	wagon = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"My name is VILLAGER_NAME.", 
			
			"Like my wagon?",
			
			"I love exploring the vast\n"..
			"open wilderness.",
			
			"You can travel anywhere\n"..
			"with a wagon!",
			
			"A wagon is great!\n"..
			"But, the wheels need\n"..
			"constant repair.",
			
			"I use my wagon to make\n"..
			"deliveries too.",
			
			"When the night is nice and\n"..
			"clear I like to lay in the\n"..
			"wagon and look to the stars!",
			
			"A compass is very useful when\n"..
			"travelling long distances."
		}
	}, 
	
	well = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = {
			"I'm VILLAGER_NAME.", 
			"Yea.. that is the well.",
			"It's great we have a well here.",
			"Don't fall in there!",
			"The well is the main source\n"..
			"of clean water for the village.",
			"There is a tale of a girl who\n"..
			"fell in a well and died after\n"..
			"7 days and now haunts the living!",
			"Anyone is welcome to the well\n"..
			"water. You just need a bucket!"
		}
		
	},
	
	castle =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	park = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	cementry =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	lamp =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	hotel =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	pub =	{
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
 	stable = {
		greetings = DEFAULT_HI,
		goodbyes = DEFAULT_BYE,
		mainchat = DEFAULT_MAIN
	}, 
	
	gamefacts = {
		"There are wolves in the forests.\n"..
		"If you leave them alone they\n"..
		"will not hurt you.",
		
		"If you have raw meats like\n"..
		"rabbit or mutton, you might be\n"..
		"able to tame a wolf!",
		
		"Many of the dangerous creatures\n"..
		"hunt only at night - except\n"..
		"for creepers.",
		
		"The snowlands have less creatures\n"..
		"that hunt you. But that also\n"..
		"means you have less food to hunt.",
		
		"There are creatures called a\n"..
		"Yeti that live in the snow.",
		
		"Want to know an interesting thing\n"..
		"about Yetis? They like potatoes!",
		
		"The snow can be a peaceful place.\n"..
		"But watch out for Yetis!",
		
		"Yetis like the peace a quiet too.\n"..
		"They only like to roam about at\n"..
		"night when the sun is not high.",
		
		"Mese is hard to find. But watch\n"..
		"out for the Mese monster!",
		
		"Skeleton key default left-click\n"..
		"action is to create a key for\n"..
		"the locked object.",

		"right-click for opening\n"..
		"stuff with keys.",

		"one gold ingot makes\n"..
		"a skeleton key.",

		"The owner of locked things\n"..
		"never needs to use keys\n"..
		"for own things.",

		"You need steel ingots\n"..
		"to make carts.",

		"To make a cart, you do\n"..
		"a 'U' shape like boat with\n"..
		"steel ingots!",
		 
		"Carts will only move on rails.",

		"You need to be 'sneaky' to\n"..
		"pickup a mine cart.",

		"You can drop items in a\n"..
		"minecart to transport items!",

		"Powered rails can automatically\n"..
		"accellerate moving carts.",

		"Sese crytsal fragments is\n"..
		"the important ingredient to\n"..
		"make powered rails.",

		"You can make a skeleton key\n"..
		"from a gold ingot.",

		"If you want to share a\n"..
		"locked item with a friend,\n"..
		"just give them a key.",

		"Use a skeleton key on a locked\n"..
		"item and it will turn into a\n"..
		"key that you can share!",

		"If you remove a locked item,\n"..
		"then any keys you shared for it\n"..
		"will no longer work.",

		"You can smelt any key back into\n"..
		"a gold ingot - it's like magic!",

		"Did you know common bushes grow\n"..
		"in grasslands, decidious\n"..
		"forests and snowy places?",

		"Acacia bushes grow in"..
		"savannahs.",

		"Bush leaves defy gravity -\n"..
		"they never fall if you greak\n"..
		"off their stems!",

		"Did you know a bush stem can be\n"..
		"crafted into 1 wooden plank?",

		"Corals live in warm, shallow\n"..
		"oceans - maybe near deserts or\n"..
		"savannahs. Not sure!",

		"You can harvest coral skeletons\n"..
		"from the orage and brown coral.",

		"If coral is expose to air,\n"..
		"they will die and turn into\n"..
		"skeleton coral.",

		"You need pickaxes to\n"..
		"dig up coral!",

		"You can use flint and steel\n"..
		"on a coal block to create a\n"..
		"permanent flame.",

		"If you have TNT, don't get too\n"..
		"close to any torches or to\n"..
		"flint and steel.. boom!",

		"Moss like to glow on anything\n"..
		"that is cobblestone when there\n"..
		"is water near it.",

		"If you pour water into lava\n"..
		"you can sometimes get obsidian!",

		"Snow blocks and ice will cool\n"..
		"down lava and if it's just\n"..
		"right it will make obsidian.",
		
		"Did you know you can find many\n"..
		"beautiful coral in the sea?",
		
		"Many colorful plants grow at\n"..
		"the bottom of the seas.",
		
		"Have you ever seen a jellyfish\n"..
		"in the ocean?",
		
		"Sea kelp can grow very long!",
		
		"Did you know sea kelp can grow\n"..
		"up to 20 meters longs?",
		
		"You can find kelp deep\n"..
		"in the oceans!",
		
		"Some travelers told me that they\n"..
		"saw old sunkin ships and under\n"..
		"water boats on the sea bed.",
		
		"I heard you can find treasure\n"..
		"in the ships and boats that sank\n"..
		"to the bottom of the sea.",
		
		"No one sells lumps like iron\n"..
		"copper, tin, or gold. You have\n"..
		"to dig them up yourself.",
		
		"Look for village leaders who\n"..
		"will trade an ingot for some"..
		"resources they need!",
		
		"People cannot hear you if\n"..
		"you chat too fast!",

		"Keep the creepers at a distance\n"..
		"with a bow.",
		
		"Ever since the creepers started\n"..
		"to appear, I'm afraid to be in\n"..
		"the forests where they can hide.",
		
		"I heard creepers don't\n"..
		"like the snow.",
		
		"Attacking a creeper is easy since\n"..
		"they don't have arms. But, run\n"..
		"before their deathly explosion!",
		
		"Creapers only appear during the\n"..
		"day. It's like they want to blow\n"..
		"you up in broad daylight.",
		
		"Watch out for zombies! They\n"..
		"like to hide near places with\n"..
		"lots of cover.",
		
		"Zombies like to hide near trees,\n"..
		"bushes, and tall grass.",
		
		"Zombies come out mostly after\n"..
		"sunset and hide then when\n"..
		"twilight arrives.",
		
		"Be careful at night while\n"..
		"exploring the forests and\n"..
		"tall brush. It's zombies!",
		
		"I saw some zombies wearing\n"..
		"steel armor!",
		
		"If you ever encounter a zombie\n"..
		"wearing armor, you need a\n"..
		"strong sword and good armor too!",
		
		"There are ghostly mages that\n"..
		"like to wander the forests\n"..
		"and dungeons at night.",
		
		"Mages hate firelight and so\n"..
		"will steal any nearby torches.\n"..
		"They're definitely spooky!",
		
		"The Mese monster's shards\n"..
		"fly so fast.",
		
		"The way to defeat a Mese monster\n"..
		"is to dart up close, strike,\n"..
		"then dart away from each shard.",
		
		"Did you know Mese monsters live\n"..
		"in stone caves and dungeons?",
		
		"Mese monsters only come out\n"..
		"after the sun sets.",
		
		"Have you hunted slimes before?\n"..
		"You can find them in jungles\n"..
		"and near tall grass and bushes.",
		
		"Green slimes are more common\n"..
		"in forests and jungles.",
		
		"At night the big slimes\n"..
		"roam about!",
		
		"Green slimes can be found\n"..
		"hiding near tall grass.",
		
		"Green slimes also like humid\n"..
		"places like jungles.",
		
		"Only the tiny green slimes\n"..
		"appear during the day.",
		
		"The huge slimes appear only\n"..
		"at night. Watch out for them!",
		
		"Did you know you can get\n"..
		"gelatin from green slimes?",
		
		"Tiny slimes are not that\n"..
		"difficult to kill, but you\n"..
		"usually get less gelatin.",
		
		"The medium and giant slimes\n"..
		"have gelatin every time, but\n"..
		"be careful not to get hurt!",
		
		"Have you heard about a huge\n"..
		"headless monster with no skin?",
		
		"There is a headless, skinless\n"..
		"monster where all its flesh\n"..
		"is exposed. Scary!",
		
		"The headless monster has\n"..
		"muscles and tendons that\n"..
		"squishes around as it walks!",
		
		"There's an tale about an evil\n"..
		"tree that uproots itself every\n"..
		"night to find little children!",
		
		"I heard there are skeletons\n"..
		"in the abandoned dungeons.\n"..
		"hope they don't dome up here!",
		
		"I love the beaches and open\n"..
		"seas. There's so much to\n"..
		"explore out there!",
		
		"Swimming across a lake can be\n"..
		"a good shortcut. Just don't\n"..
		"get eaten by a shark!",
		
		"If you plan to explore the open\n"..
		"seas, be sure to use a raft.",
		
		"Sharks are usually seen near\n"..
		"sea plant life and also roaming\n"..
		"about sunken shipwrecks!",
		
		"Tin is not used in making many\n"..
		"tools. But, you need tin with\n"..
		"copper to make bronze."
	},

}
