fid = fopen("day11.dat");dat = textscan(fid,"%s"){1};fclose(fid);
dat = cellfun("num2cell",dat,"UniformOutput",false);
dat = cellfun("str2num",cell2mat(dat));

% part 1
HEIGHT = (size(dat)(2));
steps = 100;
res1 = 0;
while (steps > 0)
	dat += 1;
	[row,col] = find(dat>=10);
	while (length(row)>0)
		for i = 1:length(row)
			adj = [row(i)-1,col(i)-1;row(i),col(i)-1;row(i)+1,col(i)-1];
			adj = [adj;row(i)-1,col(i);row(i)+1,col(i);];
			adj = [adj;row(i)-1,col(i)+1;row(i),col(i)+1;row(i)+1,col(i)+1];
			adj = adj(all(transpose((adj>0)&(adj<=10))),:);
			for j = 1:length(adj)
				dat(adj(j,1),adj(j,2)) += 1;
			end
			dat(row(i),col(i)) = (-inf);
		end
		[row,col] = find(dat>=10);
	end
	res1 += length(find(dat<0));
	dat(dat<0) = 0;
	steps -= 1;
end
% part 2

% test
assert(res1==1642);
assert(0==0);
