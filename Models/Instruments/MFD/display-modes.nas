var path = "instrumentation/efis/";

var symbols = {
	airports:     "inputs/arpt",
	centered:     "inputs/nd-centered",
	data:         "inputs/data",
	display_mode: "mfd/display-mode",
	lh_vor_adf:   "inputs/lh_vor_adf",
	position:     "inputs/pos",
	range:        "inputs/range-nm",
	rh_vor_adf:   "inputs/rh_vor_adf",
	stations:     "inputs/sta",
	terrain:      "inputs/terr",
	traffic:      "inputs/tfc",
	waypoints:    "inputs/wpt",
	weather:      "inputs/wxr",
};

var displayModes = {
	# default
	def: func () {
		var tmp = [symbols.airports, symbols.data, symbols.lh_vor_adf, symbols.position, symbols.rh_vor_adf, symbols.stations, symbols.waypoints];
		foreach(s; tmp) {
			setprop(path, s, 1);
		}

		tmp = [symbols.centered, symbols.traffic, symbols.terrain, symbols.weather];
		foreach(s; tmp) {
			setprop(path, s, 0);
		}

		setprop(path, symbols.range, 50);
	},
	# COMPASS
	1: func() {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "APP");
	},
	# NAVAIDS
	2: func() {
		setprop(path, symbols.display_mode, "VOR");
	},
	# TCAS
	3: func() {
		setprop(path, symbols.display_mode, "VOR");
		setprop(path, symbols.traffic, 1);
	},
	# MAP
	4: func() {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "MAP");
		setprop(path, symbols.terrain, 1);
	},
	# PLAN
	5: func () {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "PLAN");
	},
	# Weather
	6: func () {
		setprop(path, symbols.display_mode, "VOR");
		setprop(path, symbols.weather, 1);
	},
};

# Initialization
displayModes.def();
displayModes[1]();

var setDisplayMode = func(index) {
	displayModes.def();
	displayModes[index]();
};