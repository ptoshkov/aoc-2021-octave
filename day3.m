dat = importdata("day3.dat");

function [res,bits] = find_mostcommon(dat,pos)
	THRESHOLD = (length(dat)/2);
	bits = bitget(dat,pos);
	res = (sum(bits) >= THRESHOLD);
end

% part 1
dat = num2str(dat);
dat = bin2dec(dat);
BITLEN = 12;
gamma =        num2str(find_mostcommon(dat,BITLEN   )(1)) ;
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 1)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 2)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 3)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 4)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 5)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 6)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 7)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 8)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN- 9)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN-10)(1))];
gamma = [gamma,num2str(find_mostcommon(dat,BITLEN-11)(1))];
gamma = bin2dec(gamma);
epsilon = bitcmp(gamma,BITLEN);
res1 = (gamma*epsilon);

% part 2
pos = BITLEN;
oxygen = dat;
while (length(oxygen) > 1)
	[mostcommon,bits] = find_mostcommon(oxygen,pos);
	matches = (bits==mostcommon);
	oxygen = nonzeros(oxygen.*matches);
	pos -= 1;
end

pos = BITLEN;
CO2 = dat;
while (length(CO2) > 1)
	[mostcommon,bits] = find_mostcommon(CO2,pos);
	matches = (bits==(~(mostcommon)));
	CO2 = nonzeros(CO2.*matches);
	pos -= 1;
end

res2 = (oxygen*CO2);

%test
assert(res1==4174964);
assert(res2==4474944);
