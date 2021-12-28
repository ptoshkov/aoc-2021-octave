fid = fopen("day9.dat");dat = textscan(fid,"%s"){1};fclose(fid);
dat = cellfun("num2cell",dat,"UniformOutput",false);
dat = cellfun("str2num",cell2mat(dat));

% part 1
HEIGHT = (size(dat)(1));
WIDTH = (size(dat)(2));
down  = [inf*ones(1,WIDTH);dat(1:(HEIGHT-1),:)];
up    = [dat(2:HEIGHT,:);inf*ones(1,WIDTH)];
left  = [dat(:,2:WIDTH),inf*ones(HEIGHT,1)];
right = [inf*ones(HEIGHT,1),dat(:,1:(WIDTH-1))];
match = ((dat<down)&(dat<up)&(dat<left)&(dat<right));
idx = find(match);
mins = dat(idx);
res1 = sum(mins+1);

% part 2
res2 = [];
for i = 1:length(mins)
	temp = zeros(HEIGHT,WIDTH);
	temp(idx(i)) = true;
	vals = [(mins(i)+1):8];
	for j = 1:length(vals)
		down  = [zeros(1,WIDTH);temp(1:(HEIGHT-1),:)];
		up    = [temp(2:HEIGHT,:);zeros(1,WIDTH)];
		left  = [temp(:,2:WIDTH),zeros(HEIGHT,1)];
		right = [zeros(HEIGHT,1),temp(:,1:(WIDTH-1))];
		match = (dat==vals(j));
		match = (match&(down|up|left|right));
		temp |= match;
	end
	res2 = [res2,sum(sum(temp))];
end
res2 = (sort(res2))((length(res2)-2):length(res2));
res2 = prod(res2);

% test
assert(res1==631);
assert(res2==821560);
