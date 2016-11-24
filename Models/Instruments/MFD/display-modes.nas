var symbols = {
	centered:     "inputs/nd-centered",
	display_mode: "mfd/display-mode",
	terrain:      "inputs/terr",
	traffic:      "inputs/tfc",
	weather:      "inputs/wxr",
};

var displayModes = {
	# default
	def: func (path) {
		var tmp = [symbols.centered, symbols.traffic, symbols.terrain, symbols.weather];
		foreach(s; tmp) {
			setprop(path, s, 0);
		}
	},
	# COMPASS
	1: func(path) {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "APP");
	},
	# NAVAIDS
	2: func(path) {
		setprop(path, symbols.display_mode, "VOR");
	},
	# TCAS
	3: func(path) {
		setprop(path, symbols.display_mode, "VOR");
		setprop(path, symbols.traffic, 1);
	},
	# MAP
	4: func(path) {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "MAP");
		setprop(path, symbols.terrain, 1);
	},
	# PLAN
	5: func (path) {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "PLAN");
	},
	# Weather
	6: func (path) {
		setprop(path, symbols.display_mode, "VOR");
		setprop(path, symbols.weather, 1);
	},
};

displayModes[1];

var setDisplayMode = func(path, index) {
	displayModes.def(path);
	displayModes[index](path);
};