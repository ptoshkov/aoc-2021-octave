dat = importdata("day01.dat");

function res = count_increases(dat)
	% example
	% dat         131    140    136    135    155    175       
	% curr        131    140    136    135    155    175    175
	% prev        131    131    140    136    135    155    175
	% curr>prev    0      1      0      0      1      1      0 
	% res		   3
	FIRST = dat(1);
	LAST = dat(length(dat));
	prev = [FIRST;dat];
	curr = [dat;LAST];
	res = sum(curr>prev);
end

% part 1
res1 = count_increases(dat);

% part 2
WINDOW = 3;
LEN = length(dat);
dat = movmean(dat,WINDOW);
dat = dat((WINDOW-1):(LEN-1));
res2 = count_increases(dat);

% test
assert(res1==1466);
assert(res2==1491);
