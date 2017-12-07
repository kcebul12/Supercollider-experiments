(
SynthDef.new(\if,{
	arg choose = 0;
	var sig;
	sig = Select.ar(
		choose,
		[
			SinOsc.ar(500!2),
			Saw.ar([60.61]!2)
	]);

	sig = sig * 0.1;
	Out.ar(0,sig);
}).add;
)

~synth = Synth.new(\if,[\choose, 0]);
~synth.set(\choose, 1)

b = Buffer.read(s,"/Users/kevincebulski/Dirt/samples/dtk/Kick_01.wav",);

b.free;

b.duration;
b.numFrames;
b.numChannels;
b.sampleRate;
s.sampleRate;

b.bufnum;

b = Buffer.read(s,"/Users/kevincebulski/Dirt/samples/bel/0_poly.wav");

b.bufnum;

b.play;

PlayBuf

(
SynthDef.new(\play, {
	arg buf=0, rate=1,t_trig=1, spos=0,loop=0,out=0;
	var sig;
	sig = PlayBuf.ar(2,buf,rate,t_trig,spos,loop,doneAction:0);
	Out.ar(0,sig);
}).add;
)

x = Synth.new(\play,[\loop,1]);

x.set(\loop,0,\rate,-1);
x.free;

c = Buffer.read(s,"/Users/kevincebulski/Dirt/samples/pads/0_1.wav");

c.bufnum;
c.play;

(
SynthDef.new(\play3, {
	arg buf=0, rate = 1, amp = 0.2;
	var sig,phs;
	phs = LFSaw.ar(BufDur.ir(buf).reciprocal * rate ).range(0,s.sampleRate * 2);
	sig = BufRd.ar(2,buf,phs);
	sig = sig * amp;
	Out.ar(0,sig);
}).add;
)

Synth.new(\play3,[\buf, c.bufnum, \rate, 2]);

b.bufnum;
c.duration;


c.bufnum;
s.boot;

s.meter;

StageLimiter.activate;



