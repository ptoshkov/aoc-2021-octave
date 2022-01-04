dat = importdata("day13.dat");txt = dat.textdata;dat = dat.data(1:length(dat.data)-length(txt),:)+1;

% part 1
HEIGHT = (max(dat)(1));
WIDTH = (max(dat)(2));
grid = zeros(HEIGHT,WIDTH);
grid(sub2ind(size(grid),dat(:,1),dat(:,2))) = 1;
grid = transpose(grid);
res1 = 0;
for i = 1:length(txt)
	HEIGHT = (size(grid)(1));
	WIDTH = (size(grid)(2));
	if strfind(txt{i}," y=")
		ax = (str2num((txt{i}((strfind(txt{i}," y=")+3):length(txt{i}))))+1);
		grid = grid((1:(ax-1)),:)|flip(grid(((ax+1):HEIGHT),:));
	else
		ax = (str2num((txt{i}((strfind(txt{i}," x=")+3):length(txt{i}))))+1);
		grid = (grid(:,(1:(ax-1)))|flip(grid(:,((ax+1):WIDTH)),2));
	end
	res1 += ((i==1)*sum(sum(grid)));
end

% part 2
disp(grid(:,(1:4)));disp("\n")
disp(grid(:,(6:9)));disp("\n")
disp(grid(:,(11:14)));disp("\n")
disp(grid(:,(16:19)));disp("\n")
disp(grid(:,(21:24)));disp("\n")
disp(grid(:,(26:29)));disp("\n")
disp(grid(:,(31:34)));disp("\n")
disp(grid(:,(36:39)));disp("\n")
res2 = "BLHFJPJF";

% test
assert(res1==712);
assert(res2=="BLHFJPJF"); % visual test
