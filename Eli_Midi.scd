//Initialize MIDI
MIDIClient.init;

//Display available MIDI Endpoints
MIDIClient.destinations;

//Create MIDI Outs
(
m = MIDIOut.new(0);
~synthino = MIDIOut.new(1);
)

//adjust latency
(
m.latency = 0.02;
~synthino.latency = 0.02;
)

~synthino.noteOn(3,60,50);
~synthino.noteOff(3,60,100);

(
Routine({
	{
		[60,64,67,70,74].pyramid.do{
			arg nn;
			m.noteOn(0,nn,50);
			0.125.wait;
			m.noteOff(0,nn,0);
		};
	}.loop;
}).play;
)

(
r = Routine({
	{
		[60,64,67,70,74].pyramid.do{
		arg nn;
		~synthino.noteOn(1,nn,120);
		0.125.wait;
		~synthino.noteOff(1,nn,0);
	};
}.loop;
}).play;
)

(
r = Routine({
	{
		[48,64,67,70,74].pyramid.do{
			arg nn;
			m.noteOn(0,nn,50);
			0.0625.wait;
			m.noteOff(0,nn,0);
		};
	}.loop;
}).play;
)

r.stop;

{(0..127).do{arg n; ~synthino.noteOff(1,n,0)}};


~synthino.allNotesOff(1);
(
CmdPeriod.add({(0..127).do{arg n; m.noteOff(0,n)}});
CmdPeriod.add(~synthino.allNotesOff(0));
CmdPeriod.add(~synthino.allNotesOff(1));
CmdPeriod.add(~synthino.allNotesOff(2));
CmdPeriod.add(~synthino.allNotesOff(3));
)


a = [1,2,3,4]

a.collect{a = a.rotate; a.postln};

(
a = [60,63,67].pyramid;
r = Routine({
	{
		a.do{
			arg nn;
			~synthino.noteOn(0,nn,120);
			exprand(0.1,0.5).wait;
			~synthino.noteOff(0,nn,0);
			0.1.wait;
			~synthino.noteOn(1,nn,120);
			exprand(0.1,0.5).wait;
			~synthino.noteOff(1,nn,0);

			//a = a.rotate;
		};
		a = a.rotate;
		//{
		//a.collect{a = a.rotate;
		//}};
	}.loop;
}).play;
)

r.stop;

(
a = [60,63,65,66,67,70];
r = Routine({
	{
		a.do{
			arg nn;
			m.noteOn(0,nn,120);
			exprand(0.1,0.3).wait;
			//0.5.wait;
			m.noteOff(0,nn,0);
			//a = a.rotate;
		};
		if (0.5.coin, {a = a.reverse}, {a = a.invert(60)});
		a.postln;
		//{
		//a.collect{a = a.rotate;
		//}};
	}.loop;
}).play;
)

[60,63,67].invert(60)

if (0.5.coin, "true", "poop")

a


(
Pbind(
	\type, \midi,
	\midiout, m,
	\midicmd, \noteOn,
	\midinote, 60,
	\amp, 100/127,
	\sustain, 0,
).play;
)

