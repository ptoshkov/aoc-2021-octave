dat = importdata("day7.dat");
dat += 1;

function res = compute_cost(dat,linear)
	res = inf;
	for i = 1:length(dat)
		if (linear)
			res_pre = sum(abs(dat-dat(i)));
		else
			res_pre = mat2cell(abs(dat-dat(i)),1,ones(1,length(dat)));
			for j = 1:length(res_pre)
				res_pre{1,j} = [1:res_pre{1,j}];
			end
			res_pre = sum(cell2mat(res_pre));
		end
		res = min(res,res_pre);
	end
end

% part 1
res1 = compute_cost(dat,true);

% part 2
res2 = compute_cost(dat,false);

% test
assert(res1==344138);
assert(res2==94862124);
