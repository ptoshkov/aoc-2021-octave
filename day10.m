dat = importdata("day10.dat");
WEIGHTS = containers.Map({")","]","}",">"},[3,57,1197,25137]);

function txt = checkline(txt,loc)
	if (loc>length(txt))
		return;
	end
	if (((txt(loc)==")") && (txt(loc-1)=="(")) ||
		((txt(loc)=="]") && (txt(loc-1)=="[")) ||
		((txt(loc)=="}") && (txt(loc-1)=="{")) ||
		((txt(loc)==">") && (txt(loc-1)=="<")))
		txt = [txt(1:(loc-2)),txt((loc+1):length(txt))];
		txt = checkline(txt,max(1,(loc-2)));
	else
		txt = checkline(txt,(loc+1));
	end
end

% parts 1 & 2
res1 = 0;
res2 = [];
for i = 1:length(dat)
	txt = checkline(dat{i},2);
	closing = min([strfind(txt,")"),strfind(txt,"]"),strfind(txt,"}"),strfind(txt,">")]);
	if isempty(closing)
		tmp = 0;
		for j = 0:(length(txt)-1)
			pt = (((txt(length(txt)-j)=="(")*1)+
				((txt(length(txt)-j)=="[")*2)+
				((txt(length(txt)-j)=="{")*3)+
				((txt(length(txt)-j)=="<")*4));
			tmp = ((5*tmp)+pt);
		end
		res2(end+1) = tmp;
		continue;
	end
	closing = txt(closing);
	closing = strfind(dat{i},closing);
	for j = 1:length(closing)
		for k = 1:length(WEIGHTS)
			txt = dat{i};
			txt(closing(j)) = (keys(WEIGHTS){k});
			txt = checkline(txt,2);
			txt = [strfind(txt,")"),strfind(txt,"]"),strfind(txt,"}"),strfind(txt,">")];
			res1 += isempty(txt)*(WEIGHTS((dat{i}(closing(j)))));
		end
	end
end
res2 = (sort(res2)(ceil(length(res2)/2)));

% test
assert(res1==387363);
assert(res2==4330777059);
