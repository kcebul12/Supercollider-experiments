(
//1. server config

s.options.memSize_(2.pow(20));
s.newBusAllocators;
//2. Create TempoClock
t = TempoClock.new;

//5. boot server
s.waitForBoot({

//Set up MIDI & Synthdefs
	Task({
		3.wait;
		d = Dictionary.new;
		d.add(\foldernames -> PathName(thisProcess.nowExecutingPath.dirname +/+ "mysamp").entries);
		for (0, d[\foldernames].size-1,
			{arg i; d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
				arg sf;
				Buffer.read(s,sf.fullPath);
			});
		)});
		//create a dictionary of MIDI CC numbers
		//Synthino CC stored in Dictionary y

		y = Dictionary.newFrom(
			[
				\attack,73,
				\decay,75,
				\sustain,79,
				\release,72,
				\wave,70,
				\plfoRate,76,
				\plfoDepth,1,
				\lfoWave,12,
				\flfoRate,13,
				\flfoDepth,91,
				\resonance,71,
				\cutoff,74,
				\detune,19,
		]);
		//Volca CC stored in Dictionary v

		v = Dictionary.newFrom(
			[
				\velocity,41,
				\modAttack,42,
				\modDecay,43,
				\carAttack,44,
				\carDecay,45,
				\lfoRate,46,
				\lfoDepth,47,
				\algo,48,
				\arpType,49,
				\arpDiv,50,
				\modWheel,1, //mod wheel for Microbrute stored here
				\brute,0, // Microbrute Channel
				\volca,1, // Volca channel
		]);

		("basicSynthDefs.scd").loadRelative;
		//loads snippets from setup folder
		//("Snippets.scd").loadRelative;
		//wait, because otherwise it won't work for some reason
		3.wait;
		//activate StageLimiter - Part of the BatLib quark
		StageLimiter.activate;
		MIDIClient.init;
		5.wait;
		"Setup done!".postln;
		10.wait;
		m = Dictionary.new;
		m[\saff] = MIDIOut.newByName("Pro40", "MIDI").latency = (0.2);
		m[\synthino] = MIDIOut.newByName("SynthinoXM", "SynthinoXM").latency = (0.2);
		"MIDI set up!".postln;
	}).start;
});
)

Server.killAll;