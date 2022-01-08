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
	contents(end+1) = [length(dat)-length(dat_pre),typ,len,num];
	if ((len<0)&&(num<0))
		[ver,typ,val,dat_pre] = parse_lit(dat);
		contents(end) = [length(dat)-length(dat_pre),val];
	end
	res1 += ver;
	dat = dat_pre;
end

% part 2
while (length(contents)>1)
	for i = 1:length(contents)
		if (length(contents{i})<3)
			continue
		end
		simple = true;
		syze = contents{i}(1);
		expr = ops(contents{i}(2));
		if (contents{i}(3)>0)
			j = 0;
			k = 0;
			while (k<contents{i}(3))
				j += 1;
				k += contents{i+j}(1);
				if (length(contents{i+j})>3)
					simple = false;
					break;
				end
				syze += contents{i+j}(1);
				expr = [expr,num2str(contents{i+j}(2)),","];
			end
		else
			for j = 1:contents{i}(4)
				if (length(contents{i+j})>3)
					simple = false;
					break;
				end
				syze += contents{i+j}(1);
				expr = [expr,num2str(contents{i+j}(2)),","];
			end
		end
		if (simple)
			expr = expr(1:(length(expr)-1));
			expr = [expr,")"];
			expr = eval(expr);
			contents(i) = [contents{i}(1),expr];
			contents{i}(1) = syze;
			contents((i+1):(i+j)) = 0;
		end
	end
	contents = contents(~(cellfun("isempty",cellfun("nonzeros",contents,"UniformOutput",false))));
end
res2 = contents{1}(2);

% test
assert(res1==949);
assert(res2==1114600142730);














