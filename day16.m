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
	end
	if bin2dec(dat(7))
		len = (-1);
		num = bin2dec(dat(8:(7+TYP1)));
		dat = dat((8+TYP1):length(dat));
	else
		num = (-1);
		disp(dat(8:(8+TYP0)))
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
LEN = (4*length(dat));
dat = dec2bin(hex2dec(dat));
dat = [strrep(num2str(zeros(1,(LEN-length(dat))))," ",""),dat];
[ver,typ,len,num,dat] = parse_op(dat);
[ver,typ,val,dat] = parse_lit(dat);
[ver,typ,val,dat] = parse_lit(dat);
[ver,typ,val,dat] = parse_lit("110100101111111000101000");
while bin2dec(dat)
end

% part 2

% test
assert(0==0);
assert(0==0);














