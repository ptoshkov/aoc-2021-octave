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

function res = count_points(core)
	res = (core(2)-core(1)+1)*(core(4)-core(3)+1)*(core(6)-core(5)+1);
end

function res = find_intersect(core1,core2);
	x1 = max(core1(1),core2(1));
	x2 = min(core1(2),core2(2));
	y1 = max(core1(3),core2(3));
	y2 = min(core1(4),core2(4));
	z1 = max(core1(5),core2(5));
	z2 = min(core1(6),core2(6));
	res = [x1,x2,y1,y2,z1,z2];
	if (res(2)<res(1))||(res(4)<res(3))||(res(6)<res(5))
		res = [];
	end
end

% parts 1 & 2
points1 = [];
points2 = [];
for i = 1:(size(dat)(1))
	% disp(i)
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
	intersects = [];
	for j = 1:(size(points2)(1))
		core = points2(j,:);
		tmp = find_intersect(core,[x1,x2,y1,y2,z1,z2]);
		% disp("HI")
		% disp([x1,x2,y1,y2,z1,z2])
		% disp(core)
		% disp(tmp)
		if (~(isempty(tmp)))
			if (strcmp(action,"off")&&(core(7)<0))||(strcmp(action,"on")&&(core(7)<0))
				intersects = [intersects;tmp,1];
			else
				intersects = [intersects;tmp,-1];
			end
		end
	end
	if strcmp(action,"on")
		if (~((x1<(-50))||(x2>50)(y1<(-50))||(y2>50)(z1<(-50))||(z2>50)))
			points1 = turn_on(points1,x,y,z);
		end
		points2 = [points2;x1,x2,y1,y2,z1,z2,1;intersects];
	else
		if (~((x1<(-50))||(x2>50)(y1<(-50))||(y2>50)(z1<(-50))||(z2>50)))
			points1 = turn_off(points1,x,y,z);
		end
		points2 = [points2;intersects];
	end
end
res1 = (size(points1)(1));
res2 = 0;
for i = 1:(size(points2)(1))
	cube = points2(i,:);
	if (cube(7)>0)
		res2 += count_points(cube);
	else
		res2 -= count_points(cube);
	end
end

% test
assert(res1==533863);
assert(res2==1261885414840992);
