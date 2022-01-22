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

% part 2
pos = str2num([dat{1}(end),",",dat{2}(end)]);
scores = zeros(1,2);
universes = 0;
player = 1;
possibilities = [3,1;4,3;5,6;6,7;7,6;8,3;9,1];
wins1 = 0;
wins2 = 0;
while (size(scores)>0)
	% pause(1)
	% disp("hi")
	% disp("positions")
	% disp(pos)
	% disp("scores")
	% disp(scores)
	% disp("universes")
	% disp(universes)
	pos_new = [];
	scores_new = [];
	universes_new = [];
	for i = 1:(size(scores)(1))
		disp(size(scores)(1))
		disp(i)
		for j = 1:(size(possibilities)(1))
			result = possibilities(j,1);
			pos_tmp = pos(i,player) + result;
			pos_tmp = rem(pos_tmp,10)+10*(rem(pos_tmp,10)==0);
			if ((scores(i,player)+pos_tmp)>=21)
				if (player==1)
					wins1 += universes(i);
				else
					wins2 += universes(i);
				end
			else
				pos_new = [pos_new;pos(i,:)];
				pos_new(end,player) = pos_tmp;
				scores_new = [scores_new;scores(i,:)];
				scores_new(end,player) += pos_tmp;
				universes_new = [universes_new,universes(i)+possibilities(j,2)];
			end
		end
		player = ((~(player-1))+1);
	end
	pos = pos_new;
	scores = scores_new;
	universes = universes_new;
end

% test
assert(res1==897798);
assert(0==0);
