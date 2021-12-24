dat = importdata("day3.dat");

function res = find_mostcommon(dat,pos)
	THRESHOLD = (length(dat)/2);
	bits = bitget(dat,pos);
	res = (sum(bits) >= THRESHOLD);
end

% part 1
dat = num2str(dat);
dat = bin2dec(dat);
gamma =        num2str(find_mostcommon(dat,12)) ;
gamma = [gamma,num2str(find_mostcommon(dat,11))];
gamma = [gamma,num2str(find_mostcommon(dat,10))];
gamma = [gamma,num2str(find_mostcommon(dat, 9))];
gamma = [gamma,num2str(find_mostcommon(dat, 8))];
gamma = [gamma,num2str(find_mostcommon(dat, 7))];
gamma = [gamma,num2str(find_mostcommon(dat, 6))];
gamma = [gamma,num2str(find_mostcommon(dat, 5))];
gamma = [gamma,num2str(find_mostcommon(dat, 4))];
gamma = [gamma,num2str(find_mostcommon(dat, 3))];
gamma = [gamma,num2str(find_mostcommon(dat, 2))];
gamma = [gamma,num2str(find_mostcommon(dat, 1))];
gamma = bin2dec(gamma);
epsilon = bitcmp(gamma,12);
res1 = (gamma*epsilon);

% part 2
res2 = 0;

%test
assert(res1==4174964);
assert(res2==0);
