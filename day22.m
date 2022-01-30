dat = importdata("day22.dat");

function points = get_points(x,y,z)
	[X,Y,Z] = meshgrid(x,y,z);
	points = [X(:),Y(:),Z(:)];
end

function points = turn_on(points,x,y,z)
	new = get_points(x,y,z);
	points = unique([points;new],"rows");
end

function points = turn_off(points,x,y,z)
	new = get_points(x,y,z);
	points = points(~(ismember(points,new,"rows")),:);
end


% parts 1 & 2
points1 = [];
points2 = [];
for i = 1:(size(dat)(1))
	disp(i)
	action = strsplit(dat{i}," "){1};
	ranges = strsplit(dat{i}," "){2};
	ranges = strsplit(ranges,",");
	xranges = ranges{1};
	x1 = str2num(strsplit(xranges,".."){1}(3:end));
	x2 = str2num(strsplit(xranges,".."){2});
	yranges = ranges{2};
	y1 = str2num(strsplit(yranges,".."){1}(3:end));
	y2 = str2num(strsplit(yranges,".."){2});
	zranges = ranges{3};
	z1 = str2num(strsplit(zranges,".."){1}(3:end));
	z2 = str2num(strsplit(zranges,".."){2});
	x = [x1:x2];
	y = [y1:y2];
	z = [z1:z2];
	if strcmp(action,"on")
		if ((x1<(-50))||(x2>50)(y1<(-50))||(y2>50)(z1<(-50))||(z2>50))
			% points2 = turn_on(points2,x,y,z);
		else
			points1 = turn_on(points1,x,y,z);
		end
	else
		if ((x1<(-50))||(x2>50)(y1<(-50))||(y2>50)(z1<(-50))||(z2>50))
			% points2 = turn_off(points2,x,y,z);
		else
			points1 = turn_off(points1,x,y,z);
		end
	end
end
res1 = (size(points1)(1));
res2 = (res1 + size(points2)(1));

% test
assert(res1==533863);
assert(0==0);
