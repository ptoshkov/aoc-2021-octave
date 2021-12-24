% dat     131    140    136    135    155    175           ...
% prev    xxx    131    140    136    135    155    175    ...
% curr    131    140    136    135    155    175    xxx    ...
% res      0      1      0      0      1      1      0     ...

dat = importdata("day1.dat");
FIRST = dat(1);
LAST = dat(length(dat));
prev = [FIRST;dat];
curr = [dat;LAST];
res = sum(curr>prev);

% test
assert(res==1466);
