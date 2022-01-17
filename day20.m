SAMPLE = 1;
dat = importdata("day20.dat");
dat = strrep(dat,"#","1");
dat = strrep(dat,".","0");
keys = "";
map = "";
if (SAMPLE)
	for i = 1:7
		keys = [keys,dat{i}];
	end
	for i = 8:12
		map = [map;dat{i}];
	end
end
keys = double(keys)-48;
map = double(map)-48;

% part 1
HEIGHT = size(map)(1);
PADDING = 10;
pad = zeros(HEIGHT+2*PADDING);
pad(PADDING+1:HEIGHT+PADDING,PADDING+1:HEIGHT+PADDING) = map;
map = pad;
HEIGHT = size(pad)(1);
pad = zeros(HEIGHT+2);
pad(2:HEIGHT+1,2:HEIGHT+1) = map;
for i = 1:length(map(:))
	i_pad = i+HEIGHT+1;
	key = transpose([
		pad(i_pad-HEIGHT-1),
		pad(i_pad-HEIGHT),
		pad(i_pad-HEIGHT+1),
		pad(i_pad-1),
		pad(i_pad),
		pad(i_pad+1),
		pad(i_pad+HEIGHT-1),
		pad(i_pad+HEIGHT),
		pad(i_pad+HEIGHT+1)]);
	idx = bin2dec(num2str(key))+1;
	map(i) = keys(idx);
end
res1 = 0;

% part 2
res2 = 0;

% test
assert(res1==0);
assert(res2==0);
