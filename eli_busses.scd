Bus

s.options.numAudioBusChannels;
s.options.numInputBusChannels;
s.options.numOutputBusChannels;
s.options.numBuffers;

s.plotTree;
s.meter;

(
SynthDef.new(\blip, {
	|out, amp = 0.5, dens = 2, freq = 3, fund = 300, numHarm = 4, pfreq = 1|

	var sig,env,trig;

	sig = SinOsc.ar(LFNoise0.ar(freq).exprange(fund,fund * numHarm).round(fund));

	trig = Dust.kr(dens);
	env = EnvGen.kr(Env.perc(0.01,0.3),trig);
	sig = Pan2.ar(sig,LFSaw.kr(pfreq)) * env * amp;
	Out.ar(out,sig);

}).add;

SynthDef.new(\reverb, {
	|in, out = 0, mix = 0.5, room - 0.5, damp = 0.5|

	var sig;

	sig = In.ar(in,2);
	sig = FreeVerb.ar(sig,mix,room,damp);
	Out.ar(out,sig);


}).add;
)

~reverbBus = Bus.audio(s,2)
~reverbBus.free;

x.set(\fund, 60.midicps, \dens, 2, \pfreq, 1, \numHarm,4, \freq,3,\amp,0.6,\out, ~reverbBus)
x.free;

(
x = Synth.new(\blip, [\fund, 40.midicps, \dens, 2, \pfreq,8, \numHarm,8, \freq,3,\amp,0.3,\out, ~reverbBus],~srcGroup);

z = Synth.new(\reverb, [\in, ~reverbBus],~fxGroup);

y = Synth.new(\tanpura, [\freq, 40.midicps, \nfreq, 4, \amp, 0.03, \out, ~reverbBus],~srcGroup)
)

y.set(\mix,0.6, \room,0.9, \damp, 0.1)
z.set(\freq, 40.midicps, \amp, 0.03, \nfreq, 24)

~srcGroup = Group.new;
~fxGroup = Group.after(~srcGroup);

~srcGroup.set(\fund, 64.midicps);
y.set(\nfreq, 4)



