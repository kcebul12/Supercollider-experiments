// super simple FM, using all SinOsc's for simplicity and tradition's sake

{SinOsc.ar(SinOsc.ar(MouseY.kr(1,8000)).range(MouseX.kr(1,2000)))}.play;

(
{SinOsc.ar(
	SinOsc.ar(XLine.kr(1,2000,4)).range(20,2000) *
	EnvGen.kr(Env.perc(0.1,4,0.2))
)}.play;
)


// super simple Vibrato

(
{SinOsc.ar(
	SinOsc.ar([20,40]).range(400,800)) * // lower values to attain true Vibrato
	EnvGen.kr(Env.linen(0.1,4,4,0.3),doneAction: 2)
}.play;
)

s.meter;

// more super simple FM, 2 Operator (1 mod, 1 carrier)

(
{SinOsc.ar(
	SinOsc.ar({exprand(200,2000)}!2). // random Mod Frequency
	range(400,{exprand(400,8000)}!2)) * // random Mod Index
    EnvGen.kr(Env.perc(0.01,1.5,0.5),doneAction: 2) // Carrier Envelope
}.play;
)

(
{SinOsc.ar(
	SinOsc.ar
	(SinOsc.ar(exprand(20,2000).round(100)!2). // random Mod Frequency
		range(100,exprand(7000,8000).round(100)!2)).
	range(1000,16000).round(100)) * // random Mod Index
    EnvGen.kr(Env.perc(0.01,1.5,0.5),doneAction: 2) // Carrier Envelope
}.play;
)

exprand(200,2000).round(200)!2



