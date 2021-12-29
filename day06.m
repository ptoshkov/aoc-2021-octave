dat = importdata("day06.dat");

function res = compute_population(dat,days)
	INIT = 8;
	OVERFLOW = 6;
	dat = [dat;ones(1,length(dat))];
	for i = 1:days
		dat(1,:) -= dat(2,:);
		new = sum((dat(1,:)<0).*dat(2,:));
		dat(1,dat(1,:)<0) = OVERFLOW*dat(2,dat(1,:)<0);
		if (new)
			dat = [dat,[(INIT*new);new]];
		end
	end
	res = sum(dat(2,:));
end

% part 1
res1 = compute_population(dat,80);

% part 2
res2 = compute_population(dat,256);

% test
assert(res1==353079);
