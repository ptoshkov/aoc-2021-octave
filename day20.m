dat = importdata("day20.dat");
dat = strrep(dat,"#","1");
dat = strrep(dat,".","0");
alg = dat{1};
map = "";
for i = 2:(size(dat)(1))
	map = [map;dat{i}];
end
alg = double(alg)-48;
map = double(map)-48;

function output = pad_matrix(input,padding)
	HEIGHT = size(input)(1);
	output = padding*ones(1,HEIGHT);
	output = [output;input;output];
	output = [padding*ones(HEIGHT+2,1),output,padding*ones(HEIGHT+2,1)];
end

% part 1
for i = 1:50

end

% part 2
res1 = 0;
res2 = 0;

% test
assert(res1==0);
assert(res2==0);
