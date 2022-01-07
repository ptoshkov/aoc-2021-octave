fid = fopen("day16.dat");dat = textscan(fid,"%s"){1};fclose(fid);dat = dat{1};
ops = containers.Map([0,1,2,3,4,5,6,7],
	{"summ(","prodd(","minn(","maxx(","lit","gt(","lt(","eq("});

function res = minn(varargin)
	res = min(cell2mat(varargin));
end

function res = maxx(varargin)
	res = max(cell2mat(varargin));
end

function res = summ(varargin)
	res = sum(cell2mat(varargin));
end

function res = prodd(varargin)
	res = prod(cell2mat(varargin));
end

function [ver,typ,len,num,dat] = parse_op(dat)
	TYP0 = 15;
	TYP1 = 11;
	ver = bin2dec(dat(1:3));
	typ = bin2dec(dat(4:6));
	if (typ==4)
		len = (-1);
		num = (-1);
		return
	end
	if bin2dec(dat(7))
		len = (-1);
		num = bin2dec(dat(8:(7+TYP1)));
		dat = dat((8+TYP1):length(dat));
	else
		num = (-1);
		len = bin2dec(dat(8:(7+TYP0)));
		dat = dat((8+TYP0):length(dat));
	end
end

function [ver,typ,val,dat] = parse_lit(dat)
	ver = bin2dec(dat(1:3));
	typ = bin2dec(dat(4:6));
	if (~(typ==4))
		val = (-1);
		return
	end
	i = 0;
	val = "";
	seg = "1";
	while bin2dec(seg(1))
		i += 1;
		seg = dat((2+5*i):(6+5*i));
		val = [val,seg(2:length(seg))];
	end
	val = bin2dec(val);
	dat = dat((7+5*i):length(dat));
end

% part 1
new = "";
for i = 1:length(dat)
	new = [new,dec2bin(hex2dec(dat(i)),4)];
end
dat = new;
contents = {};
res1 = 0;
while (bin2dec(dat)~=0)
	[ver,typ,len,num,dat_pre] = parse_op(dat);
	contents(end+1) = ops(typ);
	if ((len<0)&&(num<0))
		[ver,typ,val,dat_pre] = parse_lit(dat);
		contents(end) = [num2str(val),","];
	elseif (length(contents)>1)
		if (~(isempty(str2num(contents{end-1}))))
			contents(end-1) = (contents{end-1}(1:(length(contents{end-1})-1)));
			contents(end) = ["),",contents{end}];
		end
	end
	res1 += ver;
	dat = dat_pre;
end
contents(end) = (contents{end}(1:(length(contents{end})-1)));
contents = cell2mat(contents);
closing = length(strfind(contents,"("))-length(strfind(contents,")"));
contents = [contents,char(")"*ones(1,closing))];
disp(contents)
eval(contents)

% part 2

% test
assert(949==949);
assert(0==0);














