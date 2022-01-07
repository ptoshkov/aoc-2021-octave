fid = fopen("day16.dat");dat = textscan(fid,"%s"){1};fclose(fid);dat = dat{1};

function [ver,typ,len,num,dat] = parse_op(dat)
	LIT = 4;
	TYP0 = 15;
	TYP1 = 11;
	ver = bin2dec(dat(1:3));
	typ = bin2dec(dat(4:6));
	if (typ==LIT)
		disp("ERROR: THIS PACKET IS NOT AN OPERATOR!!!")
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
	LIT = 4;
	ver = bin2dec(dat(1:3));
	typ = bin2dec(dat(4:6));
	if (~(typ==LIT))
		disp("ERROR: THIS PACKET IS NOT A LITERAL!!!")
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
vers = 0;
while (bin2dec(dat)~=0)
	[ver,typ,len,num,dat_pre] = parse_op(dat);
	contents(end+1) = "op";
	if ((len<0)&&(num<0))
		[ver,typ,val,dat_pre] = parse_lit(dat);
		contents(end) = "lit";
	end
	vers += ver;
	dat = dat_pre;
end

% part 2

% test
assert(949==949);
assert(0==0);














