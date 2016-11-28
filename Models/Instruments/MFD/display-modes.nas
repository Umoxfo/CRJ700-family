var displays = {
	captain: "instrumentation/efis",
	first_officer: "instrumentation/efis[1]",
};

var symbols = {
	centered:     "inputs/nd-centered",
	display_mode: "mfd/display-mode",
	terrain:      "inputs/terr",
	traffic:      "inputs/tfc",
	weather:      "inputs/wxr",
};

var displayModes = {
	# default
	def: func(path) {
		var tmp = [symbols.centered, symbols.traffic, symbols.terrain, symbols.weather];
		foreach(s; tmp) {
			setprop(path, s, 0);
		}
	},
	COMPASS: func(path) {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "APP");
	},
	NAVAID: func(path) {
		setprop(path, symbols.display_mode, "VOR");
	},
	TCAS: func(path) {
		setprop(path, symbols.display_mode, "VOR");
		setprop(path, symbols.traffic, 1);
	},
	MAP: func(path) {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "MAP");
		setprop(path, symbols.terrain, 1);
	},
	PLAN: func(path) {
		setprop(path, symbols.centered, 1);
		setprop(path, symbols.display_mode, "PLAN");
	},
	WEATHER: func(path) {
		setprop(path, symbols.display_mode, "VOR");
		setprop(path, symbols.weather, 1);
	},
};

var setDisplayMode = func(outputDisp) {
	var path = displays[outputDisp];

	displayModes.def(path);
	displayModes[getprop(path, "mfd/page")](path);
};

func() {
	foreach (var hash; displays) {
		displayModes.COMPASS(hash.path);
	};
};
