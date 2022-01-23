dat = importdata("day21.dat");

% part 1
pos = str2num([dat{1}(end),",",dat{2}(end)]);
scores = zeros(1,2);
player = 1;
rolls = 0;
die = 1;
while all(scores<1000)
	pos_tmp = pos(player)+(3*(die+1));
	pos_tmp = rem(pos_tmp,10)+10*(rem(pos_tmp,10)==0);
	pos(player) = pos_tmp;
	scores(player) += pos_tmp;
	die += 3;
	die = rem(die,100)+100*(rem(die,100)==0);
	rolls += 3;
	player = ((~(player-1))+1);
end
res1 = rolls*min(scores);

% part 2 - I COPIED THIS SOLUTION FROM
% https://www.reddit.com/r/adventofcode/comments/rl6p8y/comment/hpkxh2c/?utm_source=share&utm_medium=web2x&context=3
function [w1,w2] = wins(p1,t1,p2,t2)
    rf = [3,1; 4,3; 5,6; 6,7; 7,6; 8,3; 9,1];
    if t2 <= 0
        w1 = 0;
        w2 = 1;
        return
    end
    w1 = w2 = 0;
    for i = 1:(size(rf)(1))
        r = rf(i,1);
        f = rf(i,2);
        [c2,c1] = wins(p2,t2,rem(p1+r,10),t1-1-rem(p1+r,10));
        w1 += f*c1;
        w2 += f*c2;
    end
end
LIMIT = 21;
pos = str2num([dat{1}(end),",",dat{2}(end)]);
tic
res2 = max(wins(pos(1)-1,LIMIT,pos(2)-1,LIMIT));
toc


% test
assert(res1==897798);
assert(res2==48868319769358);
