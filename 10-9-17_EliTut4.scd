b = Buffer.read(s,"C:/Users/kevin/Desktop/SC stuff/Loscil_sound.wav");

c = Buffer.read(s, "C:/Users/kevin/Desktop/Pipe em full a meth.wav");

c.play;

b.play;

[b,c].do({ arg buf; buf.play});

(
SynthDef.new(\play, {
	arg buf=2, rate=1, t_trig=1, spos=0, loop=0,da=2;
	var sig;
	sig = PlayBuf.ar(2, buf, rate, t_trig, spos, loop,doneAction:da);
	Out.ar(0,sig);
}).add;
)

~loscil = Synth.new(\play);

~loscil.set(\loop, 1, \rate, 1, \spos, exprand(0.01,1));

~loscil.free;