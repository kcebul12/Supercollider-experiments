//fill signal with linear ramp form -1 to 1
(
~sig = Signal.newClear(513);

~sig.waveFill({
	arg x, y, i;
	i.linlin(0,512,-1,1);
},0,1)
)

~sig.plot;

~w = ~sig.asWavetableNoWrap;
~w.plot;

//Waveshaping with Identity transfer function created above.  What we hear is actually the index to the wavetable.

//First create a buffer to store our Wavetable (~w) into

~b = Buffer.loadCollection(s,~w);

(
{
	var sig, index;
	index = SinOsc.ar(500);
	sig = Shaper.ar(~b.bufnum, index);
	sig = sig *0.4!2;
}.play
)

//Using an Envelope to create a wavetable

//Create Env
(
~sig = Env.new(
	{rrand(-1.0,1.0)}!11,
	{rrand(0.01,2.0)}!10,
	{rrand(-5.0,5.0)}!10
);
)
~sig.plot;
~sig.class;//It's now an Env Class

//Create a Signal from the Envelope we created

~sig = ~sig.asSignal(513);//make sure you use a n^2+1 #
~sig.class;// It's now a Signal that can be loaded into a WTable

~w = ~sig.asWavetableNoWrap;//Now a WaveTable
~w.class;// still a Signal, but can now be loaded into a Table
~w.size;//notice now it's 1024, original ~sig size is now doubled

~b = Buffer.loadCollection(s,~w);
~b.plot;//Wavetable now loaded into a buffer to be used by Shaper Ugen

(
{
	var sig, index;
	index = [Pulse.ar(56,Dust.kr(MouseX.kr(0.2,1))),SinOsc.ar(55)];
	sig = Shaper.ar(~b.bufnum, index);
	sig = LeakDC.ar(sig) *0.1;//Removes DC Offset(optional)
}.play
)

(
{
	var sig, index,env;
	index = Pulse.ar([160,320],0.5,LFTri.ar(5).range(0.5,0.8));
	env = EnvGen.kr(Env.perc(0.01,0.2),Dust.kr(2),doneAction: 0);
	sig = Shaper.ar(~b.bufnum, index) * env;
	sig = LeakDC.ar(sig) *0.1;//Removes DC Offset(optional)
}.play
)

//Make it more fun???

(
{
	var sig, index;
	index = [Pulse.ar(56,MouseY.kr(0,1),MouseX.kr(0.01,1)),SinOsc.ar(55,MouseY.kr(2pi,pi),MouseX.kr(0.01,1))];
	sig = Shaper.ar(~b.bufnum, index);
	sig = LeakDC.ar(sig) *0.1;//Removes DC Offset(optional)
}.play
)

(
{
	var sig, index;
	index = Pulse.ar([440,441],MouseY.kr(0.05,0.99),MouseX.kr(0.01,1));
	sig = Shaper.ar(~b.bufnum, index);
	sig = LeakDC.ar(sig) *0.1;//Removes DC Offset(optional)
}.play
)

//Creating a Sinusoidal wavetable

~sig2 = Signal.newClear(513);

(
~sig2.waveFill({
	arg x, y, i;
	sin(x);
},0, 2pi)
)

~sig2.plot;// Sine wave for Table
~sig2.class;// Already a Signal, no need to convert

~w2 = ~sig2.asWavetableNoWrap;//Now ready to be loaded to WTable

~b2 = Buffer.loadCollection(s,~w2);// load buffer

(
{
	var sig, index;
	index = SinOsc.ar(100,0,SinOsc.kr(1 ).range(0.3,0.9));
	sig = Shaper.ar(~b2.bufnum, index);
	3.do{sig = Shaper.ar(~b2.bufnum,sig)};//indexing with orig sig
	sig = LeakDC.ar(sig!2) *0.1;//Removes DC Offset(optional)
}.play
)





