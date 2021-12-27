dat = importdata("day8.dat");
SEGS = containers.Map(
	[1,4,7,8,0,2,3,5,6,9],
	[2,4,3,7,6,5,5,5,6,6]);

function line = splitline(line,side)
	line = strsplit(char(strsplit(char(line),"|")(side))," ");
	line = line(~(cellfun("isempty",line)));
end

function [res,idx] = containedin(src,dst,num)
	src_pre = [cell2mat(src(1));cell2mat(src(2))];
	if (length(src) > 2)
		src_pre = [src_pre;cell2mat(src(3))];
	end
	res = (src_pre < 0);
	for i = 1:length(dst)
		res = (res | (src_pre==dst(i)));
	end
	res = sum(transpose(res));
	idx = [1:length(src)](res==num);
	res = src(res==num);
end

% parts 1 & 2
res1 = res2 = 0;
for i = 1:length(dat)
	VALS = containers.Map([0:9],cell(1,10));
	left = splitline(dat(i),1);
	right = splitline(dat(i),2);
	for j = 1:length(SEGS)
		num = cell2mat(keys(SEGS)(j));
		VALS(num) = left(cellfun("length",left) == SEGS(num));
	end
	[VALS(3),idx] = containedin(VALS(3),cell2mat(VALS(1)),SEGS(1));
	VALS(2) = [(VALS(2))(1,1:(idx-1)),(VALS(2))(1,(idx+1):length(VALS(2)))];
	VALS(5) = VALS(2);
	[VALS(9),idx] = containedin(VALS(9),cell2mat(VALS(4)),SEGS(4));
	VALS(0) = [(VALS(0))(1,1:(idx-1)),(VALS(0))(1,(idx+1):length(VALS(0)))];
	VALS(6) = VALS(0);
	[VALS(5),idx] = containedin(VALS(5),cell2mat(VALS(9)),SEGS(5));
	VALS(2) = [(VALS(2))(1,1:(idx-1)),(VALS(2))(1,(idx+1):length(VALS(2)))];
	[VALS(0),idx] = containedin(VALS(0),cell2mat(VALS(1)),SEGS(1));
	VALS(6) = [(VALS(6))(1,1:(idx-1)),(VALS(6))(1,(idx+1):length(VALS(6)))];
	right = cellfun("sort",right,"UniformOutput",false);
	for j = 0:(length(VALS)-1)
		VALS(j) = cellfun("sort",VALS(j),"UniformOutput",false);
	end
	VALS = containers.Map(cell2mat(values(VALS)),cell2mat(keys(VALS)));
	for j = 1:length(right)
		right(j) = num2str(VALS(char(right(j))));
	end
	res1 += sum(cell2mat(strfind(right,num2str(1))));
	res1 += sum(cell2mat(strfind(right,num2str(4))));
	res1 += sum(cell2mat(strfind(right,num2str(7))));
	res1 += sum(cell2mat(strfind(right,num2str(8))));
	res2 += str2num(cell2mat(right));
end

% test
assert(res1==369);
assert(res2==1031553);
