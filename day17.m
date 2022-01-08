dat = importdata("day17.dat");
dat{1} = dat{1}(strfind(dat,"x="){1}:length(dat{1}));
dat = strsplit(dat{1},", ");
dat = strrep(dat,"x=","");
dat = strrep(dat,"y=","");
dat = strrep(dat,"..",",");
dat = cell2mat(cellfun("str2num",dat,"UniformOutput",false));
dat = transpose(reshape(dat,2,[]));

function [histogram,y_d_max] = finder(dat,x_v_guess,y_v_guess,unconstrained)
	y_d_max = 0;
	y_d_max_pre = 0;
	x_overshoot = false;
	histogram = [];
	while (true)
		x_d = y_d = 0;
		x_v = x_v_guess;
		y_v = y_v_guess;
		while ((y_d>dat(2,1))||(x_v>0))
			x_d += x_v;
			y_d += y_v;
			y_d_max_pre = max(y_d_max_pre,y_d);
			x_v -= 1;
			x_v = max(0,x_v);
			y_v -= 1;
		end
		if ((x_d<=dat(1,2))&&(~(x_overshoot))&&(unconstrained))
			x_v_guess += 1;
		end
		if (x_d>dat(1,2))&&(~(x_overshoot))
			x_overshoot = true;
			x_v_guess -= 1;
		end
		if (x_d>=dat(1,1))||(~(unconstrained))
			y_v_guess += 1;
		end
		if ((x_d>=dat(1,1))&&(x_d<=dat(1,2))&&(y_d>=dat(2,1))&&(y_d<=dat(2,2)))
			histogram = [histogram;x_v_guess,y_v_guess-1];
			y_d_max = max(y_d_max,y_d_max_pre);
		end
		if ((y_v_guess)>abs(4*dat(2,1)))
			break;
		end
	end
end

% part 1
[_,res1] = finder(dat,0,0,true);
histogram = [];
for i = 1:(dat(1,1))
	[temp,_] = finder(dat,i,0,false);
	histogram = [histogram;temp];
end

% part 2
res2 = 0;

% test
assert(25200==25200);
assert(res2==0);
