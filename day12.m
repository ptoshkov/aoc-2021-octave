fid = fopen("day12.dat");dat = textscan(fid,"%s"){1};fclose(fid);

function res = findpath(dat,pos,visited,res)
	if strcmp(pos,"end")
		res = res + 1;
		return;
	end
	for i = 1:length(dat)
		new = [dat(1:(i-1));dat((i+1):length(dat))];
		left = strsplit(dat{i},"-"){1};
		right = strsplit(dat{i},"-"){2};
		if (strcmp(pos,lower(pos))&&(~(any(strcmp(visited,pos)))))
			visited = [visited;pos];
		end
		if (strcmp(left,pos)&&(~(any(strcmp(visited,right)))))
			if strcmp(left,upper(left))
				new = [new;dat{i}];
			end
			res = findpath(new,right,visited,res);
		end
		if (strcmp(right,pos)&&(~(any(strcmp(visited,left)))))
			if strcmp(right,upper(right))
				new = [new;dat{i}];
			end
			res = findpath(new,left,visited,res);
		end
	end
end

% part 1
res1 = findpath(dat,"start",{},0);

% part2
res2 = 0;

% test
assert(res1==4773);
assert(res2==0);
