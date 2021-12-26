fid = fopen("day5.dat");
line = fgetl(fid);
dat = [];
while (line >= 0)
	line = strrep(line," -> ",",");
	dat = [dat;(str2num(line)+1)];
	line = fgetl(fid);
end
fclose(fid);

function res = find_intersect(dat,gryd,no_diag)
	for i = 1:(size(dat)(1))
		line = dat(i,:);
		row = linspace(line(1),line(3),(abs(line(1)-line(3))+1));
		col = linspace(line(2),line(4),(abs(line(2)-line(4))+1));
		if ((line(1)~=line(3)) && (line(2)~=line(4)) && no_diag)
			continue;
		elseif ((line(1)~=line(3)) && (line(2)~=line(4)))
			for j = 1:length(row)
				gryd(row(j),col(j)) += 1;
			end
		else
			gryd(row,col) += 1;
		end
	end
	res = sum(sum(gryd>1));
end

% part 1
GRYD = 1000;
res1 = find_intersect(dat,zeros(GRYD),true);

% part 2
res2 = find_intersect(dat,zeros(GRYD),false);

%test
assert(res1==6564);
assert(res2==19172);
