

p = Pseries(0,1,inf).asStream;
p.nextN(3);

(
SynthDef.new(\sine, {
	arg freq = 400, amp = 0.2, out = 0;
	var sig, env;

	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.perc(0.001,0.3),doneAction:2);
	sig = sig * env * amp;
	Out.ar(out,sig!2);
}).add;
)

~midinotes = Pseries(60,2,14).asStream;

(
r = Routine.new({
	14.do{
		Synth(\sine, [\freq, ~midinotes.next.midicps]);
		0.5.wait;
	};
}).play;
)

(
SynthDef.new(\sine, {
	arg freq = 400, amp = 0.2, out = 0, gate = 1;
	var sig, env;

	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.asr(0.01,1,0.01),gate,doneAction:2);
	sig = sig * env * amp;
	Out.ar(out,sig!2);
}).add;
)

(
~notes = Pxrand(Scale.major.degrees+60,inf).asStream;
~amps = Pexprand(0.01,0.5,inf).asStream;
~durs = Pwrand([0.1,2],[0.9,0.1],inf).asStream;

r = Routine.new({
	loop{
		Synth.new(\sine, [
			\freq, ~notes.next.midicps,
			\amp, ~amps.next,
		]);
		~durs.next.wait;
	}
}).play;
)

r.stop;

(
SynthDef.new(\sine, {
	arg freq = 400, amp = 0.2, out = 0, rel = 0.3, pan = 0;
	var sig, env;

	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.perc(0.01,rel),doneAction:2);
	sig = Pan2.ar(sig,pan) * env * amp;
	Out.ar(out,sig!2);
}).add;
)


Pbind

(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\midinote, Pdefn(\mn,43),
	\harmonic, Pexprand(1,30,inf).round,
	\detune, Pwhite(-4.0,4.0,inf),
	\dur, Pexprand(0.01,0.1,inf),
	\amp, 0.01,
	\rel,Pwrand([2,4,6],[1,5,9].normalizeSum,inf),
	\pan, Pwhite(-1.0,1.0,inf)
).play(quant:4);
)

Pdefn(\mn,32).quant_(16)

p.stop

VarSaw