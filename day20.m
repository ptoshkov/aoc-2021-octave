dat = importdata("day20.dat");
dat = strrep(dat,"#","1");
dat = strrep(dat,".","0");
keys = dat{1};
map = "";
for i = 2:(size(dat)(1))
	map = [map;dat{i}];
end
keys = double(keys)-48;
map = double(map)-48;

function output = pad_matrix(input,padding)
	HEIGHT = size(input)(1);
	output = padding*ones(1,HEIGHT);
	output = [output;input;output];
	output = [padding*ones(HEIGHT+2,1),output,padding*ones(HEIGHT+2,1)];
end

% parts 1 & 2
res1 = 0;
for i = 1:50
	padding = (keys(1)*(~(keys(end)))*(rem(i,2)==0));
	disp(i)
	tic
	map = pad_matrix(map,padding);
	new = 0*ones(size(map));
	pad = pad_matrix(map,padding);
	for j = 1:length(map(:))
		[row,col] = ind2sub(size(map),j);
		row += 1; col += 1;
		key = [pad(row-1,col-1),pad(row-1,col),pad(row-1,col+1),pad(row,col-1),pad(row,col),pad(row,col+1),pad(row+1,col-1),pad(row+1,col),pad(row+1,col+1)];
		key = (bin2dec(num2str(key))+1);
		new(j) = keys(key);
	end
	map = new;
	if (i==2)
		res1 = sum(map(:));
	end
	toc
end
res2 = sum(map(:));

% test
assert(res1==5400);
assert(res2==18989);
