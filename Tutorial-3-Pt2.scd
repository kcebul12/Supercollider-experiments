//At it's core, sounds like a simple Tampura drone like synth but as layers are added it becomes a more complex drone texture

(
SynthDef.new(\tanpura,
	{
		arg amp=0.5, gate=1, out =0, freq = 100, nfreq=2,
		atk=0.01, rel=4;
		var sig, env, temp;

		sig = 0;
		env = EnvGen.ar(Env.asr(atk, 1, rel),
			gate,
			doneAction:2);

	16.do({
		arg i;
		temp = SinOsc.ar((i+1)*freq,0,amp);
		temp = temp * LFNoise2.kr(nfreq).exprange(0.05,1);
		sig = sig + temp;

	});

	sig = sig * env;
	Out.ar(out,sig!2);
}).add;
)

~voice1 = Synth.new(\tanpura, [\amp, 0.1]);
~voice2 = Synth.new(\tanpura, [\freq, 200, \amp, 0.1]);
~voice3 = Synth.new(\tanpura, [\freq, 300, \amp, 0.1]);

~voice1.set(\freq, 62.5, \nfreq, 4);
~voice2.set(\freq, 125, \nfreq, 64);
~voice3.set(\freq, 31.125, \nfreq, 1);

s.scope;
s.meter;

~poly = {Synth.new(\tanpura, [\amp, 0.01])}!8;

~voice3.set(\gate, 0);

s.plotTree;

//Simple Sine Wave Osc w/ Amplitude Modulation courtesy of Beetle179

(
SynthDef.new(\sineMod,
	{
		arg freq=300, modfreq=3, amp=0.5, out = 0;
		var sig, env, mod;

		sig = SinOsc.ar(freq);
		env = EnvGen.kr(Env.perc(0.01,5),doneAction:2);
		mod = SinOsc.kr(modfreq).range(0.1,1);
		sig = sig * amp * mod * env;
		Out.ar(out,sig!2);
}).add;
)

Synth.new(\sineMod,[\freq, 60.midicps, \modfreq, 1]);

Env.perc(0.01,5).range(40,100).plot;


//Goofy laser beammmm
(
SynthDef.new(\sineMod2,
	{
		arg modfreq=12, amp=0.5, out = 0;
		var sig, env, mod,freqenv;

		freqenv = EnvGen.kr(Env.perc(0.01,1).range(40,400));
		sig = SinOsc.ar(freqenv);
		env = EnvGen.kr(Env.perc(0.01,5),doneAction:2);
		mod = SinOsc.kr(modfreq).range(0.1,1);
		sig = sig * amp * mod * env;
		Out.ar(out,sig!2);
}).add;
)

Synth.new(\sineMod2);