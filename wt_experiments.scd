//Attempt at a wavetable using Matrix Fourier transform

n = 513;
~sig = Matrix.withFlatArray(n,1,n.collect{ |i| sin(2pi*i/(n - 1)) + sin(6pi*i/(n - 1)) + sin(20pi*i/(n - 1))})

~sig = ~sig.flat;
~sig = ~sig.normalize;
~sig = ~sig.asSignal(513);

//Next attempt, same function as above

~sig2 = Signal.newClear(513);

~sig2.waveFill({arg x,y,i; sin(2pi*i/(x - 1))},0, 3pi)
~sig2.waveFill({arg x,y,i; y + sin(6pi*i/(x - 1))},0,3pi)
~sig2.waveFill({arg x,y,i; y + sin(20pi*i/(x - 1))},pi,3pi);

~sig2.normalize.plot;

~wt = ~sig2.asWavetableNoWrap;

~wt.plot

~b2 = Buffer.loadCollection(s,~wt);

(
{
	var sig, index;
	index = LFSaw.ar(100);
	sig = Shaper.ar(~b2.bufnum, index);
	sig = sig *0.1!2;
}.play
)

//Fail... use waveFill and other Signal methods please...

(
~sig = Signal.newClear(513);

~sig.waveFill({
	arg x, y, i;
	sin(x).cubed * i.atan2(-3);
},0,2pi)
)

~sig.plot;

~w = ~sig.asWavetableNoWrap;
~w.plot;


a = [0,1,2,3,4]

a.stutter(3)!2

b = Ppatlace([Pseq([0,1,2,3,4],inf),{rrand(10)!4}],inf);
c = b.asStream;

c.nextN(30);

d = Place([[0,2,4,5,6],{rrand(10)!4}],inf)
e = d.asStream;

e.nextN(30)