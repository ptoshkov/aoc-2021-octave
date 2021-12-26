dat = importdata("day3.dat");
dat = num2str(dat);
dat = bin2dec(dat);
BITLEN = 12;

function [mostcommon,bits] = find_mostcommon(dat,pos)
	THRESHOLD = (length(dat)/2);
	bits = bitget(dat,pos);
	mostcommon = (sum(bits) >= THRESHOLD);
end

function dat = find_last(dat,pos,typ)
	while (length(dat) > 1)
		[mostcommon,bits] = find_mostcommon(dat,pos);
		if strcmp(typ,"mostcommon")
			matches = (bits==mostcommon);
		else
			matches = (bits==(~(mostcommon)));
		end
		dat = nonzeros(dat.*matches);
		pos -= 1;
	end
end

% part 1
gamma = num2str(find_mostcommon(dat,BITLEN)(1));
for i = 1:(BITLEN-1)
	gamma = [gamma,num2str(find_mostcommon(dat,(BITLEN-i))(1))];
end
gamma = bin2dec(gamma);
epsilon = bitcmp(gamma,BITLEN);
res1 = (gamma*epsilon);

% part 2
oxygen = find_last(dat,BITLEN,"mostcommon");
CO2 = find_last(dat,BITLEN,"leastcommon");
res2 = (oxygen*CO2);

%test
assert(res1==4174964);
assert(res2==4474944);
