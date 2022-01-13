clear all;
MAXROWS = 27;
MAXCOLS = 3;
THRESHOLD = 12;
INVALID = inf*ones(1,MAXCOLS);
fid = fopen("day19.dat");
line = fgets(fid);
dat = [];
temp = [];
i = 1;
while (line >= 0)
	if isempty(str2num(line))
		if (~(strcmp(line,"\n")))
			pad = inf*ones((MAXROWS-(size(temp)(1))),MAXCOLS);
			temp = [temp;pad];
			dat(:,:,i) = temp;
			temp = [];
			i += 1;
		end
	else
		temp(end+1,:) = str2num(line);
	end
	line = fgets(fid);
end
dat = [dat(:,:,2:(size(dat)(3)))];
pad = inf*ones((MAXROWS-(size(temp)(1))),MAXCOLS);
temp = [temp;pad];
dat(:,:,end+1) = temp;
fclose(fid);

function [orientations,axes_out,signs_out] = get_orientations(dat)
	signs = unique(perms([1,1,1,-1,-1,-1])(:,1:3),"rows");
	axes = perms([1,2,3]);
	orientations = [];
	axes_out = [];
	signs_out = [];
	for j = 1:length(axes)
		temp = dat(:,axes(j,1));
		temp = [temp,dat(:,axes(j,2))];
		temp = [temp,dat(:,axes(j,3))];
		for k = 1:length(signs)
			orientations(:,:,(end+1)) = temp.*signs(k,:);
			axes_out = [axes_out;axes(j,1),axes(j,2),axes(j,3)];
			signs_out = [signs_out;signs(k,:)];
		end
	end
	orientations = orientations(:,:,(2:size(orientations)(3)));
end

function res = compute_vmag(pos1,pos2)
	res = ((pos2(3)-pos1(3))^2)+((pos2(2)-pos1(2))^2)+((pos2(1)-pos1(1))^2);
end

function mags = compute_mags(dat)
	INVALID = [inf,inf,inf];
	mags = [];
	for i = 1:(size(dat)(1))
		pos1 = dat(i,:);
		for j = 1:(size(dat)(1))
			pos2 = dat(j,:);
			if ((j<=i)||all(pos1==INVALID)||all(pos2==INVALID))
				continue;
			end
			new_mag = [pos1,pos2,compute_vmag(pos1,pos2)];
			mags = [mags;new_mag];
		end
	end
end

% part 1
dat_aligned(:,:,2) = dat(:,:,1);
dat_flat = dat(:,:,1);
dat_flat = dat_flat(all(transpose(dat_flat~=INVALID)),:);
found = [1];
while (size(dat_aligned)(3)<=size(dat)(3))
	for i = 2:(size(dat)(3))
		cand = dat(:,:,i);
		cand = cand(all(transpose(cand~=INVALID)),:);
		mags = compute_mags(cand);
		for j = 2:(size(dat_aligned)(3))
			cand_ref = dat_aligned(:,:,j);
			cand_ref = cand_ref(all(transpose(cand_ref~=INVALID)),:);
			mags_ref = compute_mags(cand_ref);
			common = mags(ismember(mags(:,end),mags_ref(:,end)),:);
			common_ref = mags_ref(ismember(mags_ref(:,end),mags(:,end)),:);
			if ((size(common)(1))==66)
				vert = common(1,:);
				vert_ref = mags_ref(mags_ref(:,end)==vert(end),:);
				x1 = vert(1:3);
				x2 = vert(4:6);
				x1_ref = vert_ref(1:3);
				x2_ref = vert_ref(4:6);
				calib = common(all(transpose(common(:,1:3)==x2)),:)(1,:);
				calib_ref = common_ref(common_ref(:,end)==calib(end),:);
				if (all(calib_ref(1:3)==x1_ref)||all(calib_ref(4:6)==x1_ref))
					temp = x1;
					x1 = x2;
					x2 = temp;
				end
				[orientations1,axes,signs] = get_orientations(x1);
				[orientations2,_,_] = get_orientations(x2);
				for k = 1:(size(orientations1)(3))
					x1 = orientations1(:,:,k);
					x2 = orientations2(:,:,k);
					diff1 = x1_ref-x1;
					diff2 = x2_ref-x2;
					if all(diff1==diff2)
						disp("HI")
						%disp(diff1)
						%disp(i)
						%disp(found)
						disp(size(dat_aligned)(3))
						%disp(j)
						%disp(axes(k,:))
						%disp(signs(k,:))
						new_dat = cand(:,axes(k,1));
						new_dat = [new_dat,cand(:,axes(k,2))];
						new_dat = [new_dat,cand(:,axes(k,3))];
						new_dat = new_dat.*signs(k,:);
						new_dat += diff1;
						if (sum(found==i)<=0)
							found = unique([found,i]);
							dat_flat = [dat_flat;new_dat];
							pad = inf*ones((MAXROWS-(size(new_dat)(1))),MAXCOLS);
							new_dat = [new_dat;pad];
							dat_aligned(:,:,(end+1)) = new_dat;
						end
						break;
					end
				end
				break;
			end
		end
	end
end
res1 = size(unique(dat_flat,"rows"))(1);

% part 2
res2 = 0;

% test
assert(res1==467);
assert(0==0);
















