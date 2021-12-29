dat = importdata("day10.dat");
WEIGHTS = containers.Map({")","]","}",">"},[3,57,1197,25137]);

function txt = checkline(txt,loc)
	if ((loc<1) || (loc>length(txt)))
		return;
	end
	if (((txt(loc)==")") && (txt(loc-1)=="(")) ||
		((txt(loc)=="]") && (txt(loc-1)=="[")) ||
		((txt(loc)=="}") && (txt(loc-1)=="{")) ||
		((txt(loc)==">") && (txt(loc-1)=="<")))
		txt = [txt(1:(loc-2)),txt((loc+1):length(txt))];
		txt = checkline(txt,(loc-2));
	else
		txt = checkline(txt,(loc+1));
	end
end

% part 1
res1 = 0;
for i = 1:length(dat)
	txt = checkline(dat{i},2);
	closing = min([strfind(txt,")"),strfind(txt,"]"),strfind(txt,"}"),strfind(txt,">")]);
	if isempty(closing)
		continue;
	end
	closing = txt(closing);
	closing = strfind(dat{i},closing);
	for j = 1:length(closing)
		for k = 1:length(WEIGHTS)
			txt = dat{i};
			txt(closing(j)) = (keys(WEIGHTS){k});
			txt = checkline(txt,2);
			if isempty([strfind(txt,")"),strfind(txt,"]"),strfind(txt,"}"),strfind(txt,">")])
				res1 += WEIGHTS((dat{i}(closing(j))));
			end
		end
	end
end

% part 2
res2 = 0;

% test
assert(res1==0);
assert(res2==0);
