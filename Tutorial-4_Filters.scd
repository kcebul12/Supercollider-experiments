Filters

(
x = {
	//arg cf = 1000;
	var sig, cf, rq;
	rq = MouseY.kr(0.01,1,1);
	cf = MouseX.kr(200,5000,1);
	sig = Saw.ar([60,61],0.2);
	sig = RLPF.ar(sig,cf,rq);
	sig = sig * 0.3;
}.play;
)

FreqScope.new;

Saw.ar([60,61],0.2);

(
x = {
	//arg cf = 1000;
	var sig, cf;
	cf = LFTri.kr(0.3).exprange(40,400);
	sig = Saw.ar(60,0.2);
	sig = RLPF.ar(sig,cf,(1/20));
	sig = sig * 0.3;
}.play;
)
