//Reverb aux effects bus coded pre-fader


(
s.newBusAllocators;
~reverbBus = Bus.audio(s,2);
SynthDef.new(\tone,{
	arg freq = 1000, out=0, auxout=0,amp=0.5,auxamp=0;
	var sig, env;

	sig = SinOsc.ar(freq);
	env = EnvGen.kr(
		Env.new([0,1,0],[0.001,0.1],[1,-1]),
		LFSaw.kr(0.5));

	sig = sig * env * 0.4!2;
	Out.ar(out,sig * amp);
	Out.ar(auxout,sig*auxamp);
}).add;

(
SynthDef.new(\reverb,{
	arg in=0, out=0;
	var sig;

	sig = In.ar(in,2);
	sig = (GVerb.ar(sig,200,25)) * 0.5;
	Out.ar(out,sig);
}).add;)
)

(
s.freeAll;
~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);

Synth.new(\reverb,[\in,~reverbBus,\out,0],~fxGrp
);
)

(
Synth.new(\tone, [
	\freq, exprand(200,1000),
	\out,0,
	\auxout, ~reverbBus,
	\auxamp,0,

], ~sourceGrp
);
)

~sourceGrp.set(\auxamp,0.4);
~sourceGrp.set(\amp,0);

~sourceGrp.freeAll;

s.plotTree;
s.meter;
s.options.numOutputBusChannels;

~reverbBus = Bus.audio(s,1);
~reverbBus.index;
~reverbBus;

s.quit;