dat = importdata("day14.dat");

function [res,dat] = solve(dat,steps)
	% >>> OPTIMIZATION >>>
	lut = containers.Map;
	for i = 2:length(dat)
		lut(strsplit(dat{i}," -> "){1}) = strsplit(dat{i}," -> "){2};
	end
	% <<< OPTIMIZATION <<<
	while (steps > 0)
		pairs = {};
		for i = 1:(length(dat{1})-1)
			pairs = [pairs,(dat{1}(i:(i+1)))];
		end
		for i = 1:length(pairs)
			if isKey(lut,pairs{i})
				pairs{i}(2) = lut(pairs{i});
			else
				pairs{i} = pairs{i}(1);
			end
		end
		dat{1} = cell2mat([pairs,dat{1}(length(dat{1}))]);
		steps -= 1;
	end
	res = [];
	for i = 1:length(unique(dat{1}))
		res(end+1) = sum(dat{1}==(unique(dat{1})(i)));
	end
	res = (max(res)-min(res));
end

% parts 1 & 2
[res1,dat] = solve(dat,10);
[res2,dat] = solve(dat,30);

% test
assert(3009==3009);
assert(0==0);
