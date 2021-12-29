fid = fopen("day04.dat");
line = fgets(fid);
dat = {};
while (line >= 0)
	dat = [dat;str2num(line)];
	line = fgets(fid);
end
fclose(fid);

DIM = 5;
numbers = cell2mat(dat(1));
boards = cell2mat(dat(2:length(dat)));
boards = reshape(transpose(boards),DIM,DIM,[]);
scores = [];

% part 1
for i = 1:length(numbers)
	matches = (-(boards==numbers(i)));
	boards = ((boards.*(~(matches)))+matches);
	win_col = any(sum(boards  )==(-DIM));
	win_row = any(sum(boards,2)==(-DIM));
	win = or(win_row,win_col);
	win = reshape(win,1,(size(boards)(3)));
	if any(win)
		idx = nonzeros(win.*(1:(size(boards)(3))));
		board = boards(:,:,idx);
		board = (board.*(board>=0));
		score = sum(sum(board))*numbers(i);
		score = reshape(score,[],1);
		scores = [scores;score];
		boards(:,:,idx) = (-2);
	end
end
res1 = scores(1);

% part 2
res2 = scores(length(scores));

%test
assert(res1==51776);
assert(res2==16830);
