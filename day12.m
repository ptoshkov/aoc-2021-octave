fid = fopen("day12.dat");dat = textscan(fid,"%s"){1};fclose(fid);

function res = findpath(dat,pos,visited,res,part1)
	if strcmp(pos,"end")
		res += 1;
		return;
	end
	if (strcmp(pos,"start")||
			(strcmp(pos,lower(pos))&&
				((sum(strcmp(cellfun("lower",visited,"UniformOutput",false),visited))>1)||part1)))
		visited(end+1) = pos;
	elseif (strcmp(pos,lower(pos))&&any(strcmp(cellfun("lower",visited,"UniformOutput",false),pos))&&(~(part1)))
		visited = cellfun("lower",visited,"UniformOutput",false);
	elseif (strcmp(pos,lower(pos))&&(~(part1)))
		visited(end+1) = upper(pos);
	end
	for i = 1:length(dat)
		dst = strsplit(dat{i},"-"){1+strcmp(strsplit(dat{i},"-"){1},pos)};
		if ((strcmp(strsplit(dat{i},"-"){1},pos)||strcmp(strsplit(dat{i},"-"){2},pos))&&
			(~(any(strcmp(visited,dst)))))
			% >>> OPTIMIZATION >>>
			if (any(strcmp(visited,pos)))
				new = [dat(1:(i-1));dat((i+1):length(dat))];
			else
				new = dat;
			end
			if strcmp(pos,"start")
				new = new(cellfun("isempty",strfind(new,"start")));
			end
			% <<< OPTIMIZATION <<<
			res = findpath(new,dst,visited,res,part1);
		end
	end
end

% parts 1 & 2
res1 = findpath(dat,"start",{},0,true);
res2 = findpath(dat,"start",{},0,false);

% test
assert(res1==4773);
assert(res2==116985);
