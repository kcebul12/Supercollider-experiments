(
~tone = {
	arg freq = 500, amp = 0.5, gate = 0;
	var sig,env;
	env = EnvGen.kr(
		Env.asr,
		gate,
		doneAction:2
	);
	sig = SinOsc.ar(freq, 0, amp);
	sig = sig * env;
	sig!2;
}
)

x = ~tone.play;
x.set(\gate,0);

x.free;

(
SynthDef.new(
	\pureTone,
	{
		arg freq = 500, amp = 0.2, gate = 1, out = 0;
		var sig,env;
		env = EnvGen.kr(
			Env.asr,
			gate,
			doneAction:2
		);
		sig = SinOsc.ar(freq, 0, amp)!2;
		sig = sig * env;
		Out.ar(out,sig);
	}
).add;
)

x = Synth.new(\pureTone);
x.set(\amp, 0.2);
x.set (\freq, 700);
x.set(\gate, 0);

Collection

a = {rrand(10,50)}!8;

a.linexp(10,50,1000,2000);

(
a = a.collect({
	arg num;
	num.linexp(10,50,1000,2000).postln;
})
)

a = {rrand(40,80)}!8;




a = {rrand(40,80)}!8;

(
~synths = a.collect({
	arg noteNum;
	Synth.new(\pureTone,
		[\freq, noteNum.midicps,\amp, 0.1,
	]);
});
)

(
~synths.do({
	arg synth;
	synth.set(\freq, rrand(20,80).midicps
)};
)
)


~synths[4].set(\gate, 0)

(
Routine.new({
	"hello".postln;
	wait(3);
	"goodbye".postln;
}).play;
)

(
Routine.new({
	~synths.do({
		arg tone;
		tone.set(\freq, rrand(60,72).midicps);
		"changed".postln;
		1.wait;
	});
}).play;
)

~synths.do({arg i; i.free;})

(
Routine.new({

	10.do({

		~synths.do({
			arg tone;
			tone.set(\freq, rrand(48,60).midicps);
	});

		1.wait;

	});
}).play;
)

~synths.do({ arg i; i.set(\gate, 0)});

(
SynthDef.new(
	\pureTone2,
	{
		arg amp = 0.2, gate = 1, out = 0;
		var sig,temp,env;

		sig = 0;
		env = EnvGen.kr(
			Env.asr,
			gate,
			doneAction:2
		);

		10.do({
			arg i;
			temp = SinOsc.ar({ExpRand.new(200,2000)}!2, 0, amp);
			sig = sig + temp;
		});

		sig = sig * env;
		Out.ar(out,sig);
	}
).add;
)

Synth.new(\pureTone2, [\amp, 0.05]);













