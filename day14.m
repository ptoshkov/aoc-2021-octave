dat = importdata("day14.dat");

function res = solve(dat,steps)
	% >>> OPTIMIZATION >>>
	lut = containers.Map;
	for i = 2:length(dat)
		lut(strsplit(dat{i}," -> "){1}) = strsplit(dat{i}," -> "){2};
	end
	pairs = {};
	occurs = [];
	for i = 1:(length(dat{1})-1)
		pair = (dat{1}(i:(i+1)));
		if sum(strcmp(pairs,pair))
			occurs(strcmp(pairs,pair)) += 1;
		else
			pairs = [pairs;pair];
			occurs = [occurs;1];
		end
	end
	letters = {dat{1}(length(dat{1}))};
	% <<< OPTIMIZATION <<<
	while (steps > 0)
		instances = [1;zeros(length(letters)-1,1)];
		new_pairs = {};
		new_occurs = [];
		for i = 1:length(pairs)
			if isKey(lut,pairs{i})
				pairs{i} = [pairs{i}(1),lut(pairs{i}),pairs{i}(2)];
			end
			for j = 1:(length(pairs{i})-1)
				if sum(strcmp(letters,pairs{i}(j)))
					instances(strcmp(letters,pairs{i}(j))) += occurs(i);
				else
					letters = [letters;pairs{i}(j)];
					instances = [instances;occurs(i)];
				end
			end
			if (length(pairs{i})>2)
				new = pairs{i}(2:length(pairs{i}));
				%new_pairs = [new_pairs;new];
				%new_occurs = [new_occurs;1];
				if sum(strcmp(new_pairs,new))
					new_occurs(strcmp(new_pairs,new)) += occurs(i);
				else
					new_pairs = [new_pairs;new];
					new_occurs = [new_occurs;occurs(i)];
				end
				pairs{i} = pairs{i}(1:(length(pairs{i})-1));
			end
		end
		pairs = [pairs;new_pairs];
		occurs = [occurs;new_occurs];
		steps -= 1;
	end
	res = (max(instances)-min(instances));
end

% parts 1 & 2
res1 = solve(dat,10);
res2 = solve(dat,40);

% test
assert(res1==3009);
assert(res2==3459822539451);
