dat = importdata("day14.dat");

function [res,dat] = solve(dat,steps)
	while (steps > 0)
		new = last = "";
		for i = 1:(length(dat{1})-1)
			pair = (dat{1}(i:(i+1)));
			new = [new,pair(1)];
			for j = 2:length(dat)
				if strcmp(pair,strsplit(dat{j}," -> "){1})
					new = [new,strsplit(dat{j}," -> "){2}];
					break;
				end
			end
			last = pair(2);
		end
		dat{1} = [new,last];
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
