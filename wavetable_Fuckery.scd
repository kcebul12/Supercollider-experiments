b = Buffer.read(s,"C:/Users/kevin/Desktop/tada.wav");
c = Buffer.read(s, "C:/Users/kevin/Desktop/Pipe em full a meth.wav");

x = {BufRd.ar(1, c.bufnum,Phasor.ar(0,BufRateScale.kr(c) * 1,0,BufFrames.kr(c) - 1))}.play;

{SinOsc.ar(120,3pi/2).range(0,1)}.plot;

(
SynthDef.new(\playbuf,{
	arg rate = 1, spos = 0, out = 0, loop = 0, da = 2, buf = 0;
	var sig;

	sig = PlayBuf.ar(1,buf,BufRateScale.kr(buf)*rate,1,spos,loop,da);
	Out.ar(out,sig!2);

}).add;
)


Synth(\playbuf, [\buf,c.bufnum, \rate, -1, \spos, c.numFrames - 2, \da, 2])

(
SynthDef.new(\bufread,{
	arg freq = 1, spos = 0, out = 0, loop = 0, buf = 0, rel = 1, curve = -4, amp = 2;
	var sig, ptr, pos, env;
	pos = BufDur.kr(buf) * spos * 44100;
	ptr = Phasor.ar(0,BufRateScale.kr(buf)*freq,pos,BufFrames.kr(buf)-1);
	env = EnvGen.kr(Env.perc(0.01,rel,1,curve), doneAction: 2);
	sig = BufRd.ar(1, buf, ptr);
	sig = sig * env * amp * 4;
	Out.ar(out,sig!2);

}).add;
)

Synth(\bufread,[\buf,b.bufnum,\freq, 2000, \spos, 0.9])

(
Pdef(\brp,
	Pbind(
	\instrument, \bufread,
	\dur, 1/8,
	\amp, Pseq([Pseq([1],1),Pseq([0.2]!7,1)],inf),
	\deqree, Prand((Scale.dorian),inf),
	\octave, 4,
	\harmonic, 1,//Pwhite(1,8,inf),
	\buf, b.bufnum,
	\spos, Pwhite(0,0.99,inf),
	\rel, Pwhite(0.1,0.4,inf),
	\curve, Pexprand(-8,-1,inf),
)).play;
)