% To compute the position of the vessel,
% complex numbers are used.
% 
% A complex number of the form
%     complex = real + i*imag
% corresponds to the position
%     position = horizontal + vertical
% or the position/aim
%     position/aim = horizontal + aim

dat = importdata("day2.dat");
dat = strrep(dat,"forward ","");
dat = strrep(dat,"up ","i*");
dat = strrep(dat,"down ","-i*");
dat = str2double(dat);

% part 1
pos = sum(dat);
hpos = real(pos);
vpos = imag(pos);
res1 = abs(hpos*vpos);

% part 2
hpos = real(dat);
aim = cumsum(imag(dat));
vpos = (hpos.*aim);
res2 = abs(sum(hpos)*sum(vpos));

%test
assert(res1==2147104);
assert(res2==2044620088);
