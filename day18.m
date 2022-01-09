dat = importdata("day18.dat");

%str2num
%num2str

function output = pto2dec(input)
	foobar
end

function input = dec2pto(input)
	for i = flip(33:99)
		j = i;
		if (i==44)
			j = 101;
		end
		if (i==91)
			j = 102;
		end
		if (i==93)
			j = 103;
		end
		input = strrep(input,num2str(i-33),char(j));
	end
end

function lyne = explode(lyne)
	for i = 3:length(lyne)
		opening = length(strfind(lyne(1:i),"["));
		closing = length(strfind(lyne(1:i),"]"));
		if (isempty(str2num(lyne(i)))||isempty(str2num(lyne(i-2)))||((opening-closing)<5))
			continue;
		else
			try
				for j = 3:(i-1)
					if isempty(str2num(lyne(i-j)))
						continue;
					else
						lyne(i-j) = num2str(str2num(lyne(i-j))+str2num(lyne(i-2)));
						break;
					end
				end
			catch
				%warning("Could not explode to the left.");
			end
			try
				for j = (i+1):length(lyne)
					if isempty(str2num(lyne(j)))
					else
						lyne(j) = num2str(str2num(lyne(j))+str2num(lyne(i)));
						break;
					end
				end
			catch
				%warning("Could not explode to the right.");
			end
			try
				lyne((i-2):i) = "000";
			catch
				%warning("Could not replace exploded pair w/ '0'.");
			end
		break;
		end
	end
	lyne = strrep(lyne,"[000]","0");
end

function lyne = splyt(lyne)
	val = 0;
	for i = 2:length(lyne)
		if (isempty(str2num(lyne(i)))||isempty(str2num(lyne(i-1))))
			continue;
		else
			val = str2num(lyne((i-1):i));
			lyne((i-1):i) = "00";
			break;
		end
	end
	val = ["[",num2str(floor(val/2)),",",num2str(ceil(val/2)),"]"];
	lyne = strrep(lyne,"00",val);
end

function lyne = cleanup_line(lyne)
	while (true)
		disp(lyne)
		pause(1)
		lyne_tmp = explode(lyne);
		if strcmp(lyne,lyne_tmp)
			lyne_tmp = splyt(lyne);
		end
		if strcmp(lyne,lyne_tmp)
			lyne = lyne_tmp;
			break;
		end
		lyne = lyne_tmp;
	end
end

% part 1
res1 = 0;

% part 2
res2 = 0;

% test
assert(explode("[[[[[9,8],1],2],3],4]"),"[[[[0,9],2],3],4]");
assert(explode("[7,[6,[5,[4,[3,2]]]]]"),"[7,[6,[5,[7,0]]]]");
assert(explode("[[6,[5,[4,[3,2]]]],1]"),"[[6,[5,[7,0]]],3]");
assert(explode("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"),"[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]");
assert(explode("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"),"[[3,[2,[8,0]]],[9,[5,[7,0]]]]");
assert(explode("[[[[0,7],4],[7,[[8,4],9]]],[1,1]]"),"[[[[0,7],4],[15,[0,13]]],[1,1]]");
assert(explode("[[[[0,7],4],[15,[0,13]]],[1,1]]"),"[[[[0,7],4],[15,[0,13]]],[1,1]]");
assert(splyt("[[[[0,7],4],[15,[0,13]]],[1,1]]"),"[[[[0,7],4],[[7,8],[0,13]]],[1,1]]");
assert(splyt("[[[[0,7],4],[[7,8],[0,13]]],[1,1]]"),"[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]");
assert(cleanup_line("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]"),"[[[[0,7],4],[[7,8],[6,0]]],[8,1]]");
% assert(cleanup_line("[[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]"),
% 					"[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]");
assert(dec2pto("[2,[0,[9,[50,9]]]]"),"[#,[!,[*,[S,*]]]]");
assert(res1==0);
assert(res2==0);







