dat = importdata("day18.dat");
nums = [0:66];
chars = (nums+33);
chars(chars==44) = 100;
chars(chars==48) = 101;
chars(chars==49) = 102;
chars(chars==50) = 103;
chars(chars==51) = 104;
chars(chars==52) = 105;
chars(chars==53) = 106;
chars(chars==54) = 107;
chars(chars==55) = 108;
chars(chars==56) = 109;
chars(chars==57) = 110;
chars(chars==91) = 111;
chars(chars==93) = 112;
chars = char(chars);

function output = pto2dec(input,nums,chars)
	output = "";
	for i = 1:length(input)
		if (strcmp(input(i),"[")||strcmp(input(i),"]")||strcmp(input(i),",")||strcmp(input(i),"0"))
			output = [output,input(i)];
		else
			output = [output,num2str(nums(chars==input(i)))];
		end
	end
end

function input = dec2pto(input,nums,chars)
	numbers = eval(input);
	numbers = flip(sort(numbers));
	for i = 1:length(numbers)
		input = strrep(input,num2str(numbers(i)),chars(nums==numbers(i)));
	end
end

function input = str2pto(input,nums,chars)
	if (strcmp(input,"[")||strcmp(input,"]")||strcmp(input,","))
		input = [];
	else
		input = str2num(pto2dec(input,nums,chars));
	end
end

function lyne = explode(lyne,nums,chars)
	lyne = dec2pto(lyne,nums,chars);
	for i = 3:length(lyne)
		opening = length(strfind(lyne(1:i),"["));
		closing = length(strfind(lyne(1:i),"]"));
		if (isempty(str2pto(lyne(i),nums,chars))||isempty(str2pto(lyne(i-2),nums,chars))||((opening-closing)<5))
			continue;
		else
			try
				for j = 3:(i-1)
					if isempty(str2pto(lyne(i-j),nums,chars))
						continue;
					else
						left = str2pto(lyne(i-j),nums,chars);
						right = str2pto(lyne(i-2),nums,chars);
						result = left+right;
						if (result>66)
							disp("OUT OF RANGE!!! RESULT CORRUPTED!!!")
						end
						lyne(i-j) = dec2pto(num2str(result),nums,chars);
						break;
					end
				end
			catch
				%warning("Could not explode to the left.");
			end
			try
				for j = (i+1):length(lyne)
					if isempty(str2pto(lyne(j),nums,chars))
					else
						left = str2pto(lyne(j),nums,chars);
						right = str2pto(lyne(i),nums,chars);
						result = left+right;
						if (result>66)
							disp("OUT OF RANGE!!! RESULT CORRUPTED!!!")
						end
						lyne(j) = dec2pto(num2str(result),nums,chars);
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
	lyne = pto2dec(lyne,nums,chars);
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

function lyne = cleanup_line(lyne,nums,chars)
	while (true)
		lyne_tmp = explode(lyne,nums,chars);
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

function output = compute_mag(input)
	input = strrep(input,"[","(3*");
	input = strrep(input,"]","*2)");
	input = strrep(input,",","+");
	output = eval(input);
end

% part 1
res1 = dat{1};
for i = 2:length(dat)
	fprintf("Line %d\n",i);
	tic
	res1 = cleanup_line(["[",res1,",",dat{i},"]"],nums,chars);
	toc
end
res1 = compute_mag(res1);
fprintf("Magnitude: %d\n",res1);

% part 2
res2 = 0;
for i = 1:length(dat)
	fprintf("Line %d\n",i);
	fprintf("Result so far: %d\n",res2);
	tic
	for j = 1:length(dat)
		fprintf("#");
		if (i==j)
			continue;
		end
		temp = cleanup_line(["[",dat{i},",",dat{j},"]"],nums,chars);
		temp = compute_mag(temp);
		res2 = max(res2,temp);
	end
	fprintf("\n");
	toc
end
fprintf("Final result: %d\n",res2);

% test
%assert(explode("[[[[[9,8],1],2],3],4]",nums,chars),"[[[[0,9],2],3],4]");
%assert(explode("[7,[6,[5,[4,[3,2]]]]]",nums,chars),"[7,[6,[5,[7,0]]]]");
%assert(explode("[[6,[5,[4,[3,2]]]],1]",nums,chars),"[[6,[5,[7,0]]],3]");
%assert(explode("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]",nums,chars),"[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]");
%assert(explode("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]",nums,chars),"[[3,[2,[8,0]]],[9,[5,[7,0]]]]");
%assert(explode("[[[[0,7],4],[7,[[8,4],9]]],[1,1]]",nums,chars),"[[[[0,7],4],[15,[0,13]]],[1,1]]");
%assert(explode("[[[[0,7],4],[15,[0,13]]],[1,1]]",nums,chars),"[[[[0,7],4],[15,[0,13]]],[1,1]]");
%assert(splyt("[[[[0,7],4],[15,[0,13]]],[1,1]]"),"[[[[0,7],4],[[7,8],[0,13]]],[1,1]]");
%assert(splyt("[[[[0,7],4],[[7,8],[0,13]]],[1,1]]"),"[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]");
%assert(cleanup_line("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]",nums,chars),"[[[[0,7],4],[[7,8],[6,0]]],[8,1]]");
%assert(cleanup_line("[[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]",nums,chars),
%					"[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]");
%assert(cleanup_line("[[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]],[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]]",nums,chars),
%	"[[[[6,7],[6,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]]");
%assert(dec2pto("[2,[0,[9,[50,9]]]]",nums,chars),"[#,[!,[*,[S,*]]]]");
%assert(pto2dec("[#,[!,[*,[S,*]]]]",nums,chars),"[2,[0,[9,[50,9]]]]");
%assert(compute_mag("[[1,2],[[3,4],5]]"),143);
%assert(compute_mag("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"),3488);
%assert(str2pto("*",nums,chars),9);
assert(res1==3216);
assert(res2==4643);







