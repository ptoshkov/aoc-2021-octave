dat = importdata("day1.dat");
FIRST = dat(1);
LAST = dat(length(dat));
prev = [FIRST;dat];
curr = [dat;LAST];
res = sum(curr>prev);

% test
assert(res==1466);
