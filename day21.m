clear all;
dat = importdata("day21.dat");

function [score_out,rolls_out] = play_game(pos_init,player,init)
	persistent pos;
	persistent die;
	persistent score;
	persistent rolls;
	if (init)
		pos = [];
		die = [];
		score = [];
		rolls = [];
	end
	if (isempty(pos)||isempty(die))
		pos = pos_init;
		die = 1;
		score = zeros(1,2);
		rolls = 0;
	end
	pos_tmp = pos(player)+(3*(die+1));
	pos_tmp = rem(pos_tmp,10)+10*(rem(pos_tmp,10)==0);
	pos(player) = pos_tmp;
	score(player) += pos_tmp;
	die += 3;
	die = rem(die,100)+100*(rem(die,100)==0);
	rolls += 3;
	score_out = score;
	rolls_out = rolls;
end

% part 1
pos = str2num([dat{1}(end),",",dat{2}(end)]);
score = zeros(1,2);
player = 1;
rolls = 0;
init = 1;
LIMIT = 1000;
while all(score<LIMIT)
	[score,rolls] = play_game(pos,player,init);
	init = max(0,init-1);
	player = ((~(player-1))+1);
end
res1 = rolls*min(score);

% part 2
res2 = 0;

% test
assert(res1==897798);
assert(res2==0);
