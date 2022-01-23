fid = fopen("day15.dat");dat = textscan(fid,"%s"){1};fclose(fid);
dat = cellfun("num2cell",dat,"UniformOutput",false);
dat = cellfun("str2num",cell2mat(dat));

function res = dijkstra(dat)
	% This implementation is based on:
	% https://levelup.gitconnected.com/dijkstras-shortest-path-algorithm-in-a-grid-eb505eb3a290
	HEIGHT = length(dat);
	loc = 1;
	visited = zeros(HEIGHT,HEIGHT);
	cost = (inf+visited);
	cost(1) = 0;
	while (~(all(visited(:))))
		visited(loc) = 1;
		if (rem(loc,HEIGHT)>0)
			down = (loc+1);
			if ((cost(loc)+dat(down))<cost(down))&&(~(visited(down)))
				cost(down) = (cost(loc)+dat(down));
			end
		end
		if (rem(loc,HEIGHT)~=1)
			up = (loc-1);
			if ((cost(loc)+dat(up))<cost(up))&&(~(visited(up)))
				cost(up) = (cost(loc)+dat(up));
			end
		end
		if (ceil(loc/HEIGHT)<HEIGHT)
			right = (loc+HEIGHT);
			if ((cost(loc)+dat(right))<cost(right))&&(~(visited(right)))
				cost(right) = (cost(loc)+dat(right));
			end
		end
		if (ceil(loc/HEIGHT)>1)
			left = (loc-HEIGHT);
			if ((cost(loc)+dat(left))<cost(left))&&(~(visited(left)))
				cost(left) = (cost(loc)+dat(left));
			end
		end
		temp = cost;
		temp(visited==1) = inf;
		loc = find(temp==min(temp(:)))(1);
	end
	res = cost(end);
end
% part 1
res1 = dijkstra(dat);

% part 2
dat1 = (dat+1);dat1(dat1>9)=1;
dat2 = (dat1+1);dat2(dat2>9)=1;
dat3 = (dat2+1);dat3(dat3>9)=1;
dat4 = (dat3+1);dat4(dat4>9)=1;
dat = [dat,dat1,dat2,dat3,dat4];
dat1 = (dat+1);dat1(dat1>9)=1;
dat2 = (dat1+1);dat2(dat2>9)=1;
dat3 = (dat2+1);dat3(dat3>9)=1;
dat4 = (dat3+1);dat4(dat4>9)=1;
dat = [dat;dat1;dat2;dat3;dat4];
res2 = dijkstra(dat);

% test
assert(res1==562);
assert(res2==2874);
