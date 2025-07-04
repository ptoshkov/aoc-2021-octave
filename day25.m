global EMPTY;
global EAST;
global SOUTH;

dat = importdata('day25.dat');
dat = cell2mat(dat);
EMPTY = 0;
EAST = 1;
SOUTH = -1;

function new = text2numeric(dat)
    global EAST;
    global SOUTH;

    new = zeros(size(dat));
    new(dat == '>') = EAST;
    new(dat == 'v') = SOUTH;
end

dat = text2numeric(dat);

function new = add_padding(dat)
    new = [dat, dat; dat, zeros(size(dat))];
end

function new = remove_padding(dat)
    global EAST;
    global SOUTH;

    [rows, cols] = size(dat);
    new = dat(1:rows/2, 1:cols/2) + dat(1+rows/2:rows, 1:cols/2) + dat(1:rows/2, 1+cols/2:cols);
    new = min(new, EAST);
    new = max(new, SOUTH);
end

function dat = submove1(dat)
    global EMPTY;
    global EAST;

    dat = add_padding(dat);
    dat_lshift = [dat(:, 2:end), zeros(rows(dat), 1)];
    dat_is_east_and_right_is_empty = ((dat == EAST) & (dat_lshift == EMPTY));
    dat(dat_is_east_and_right_is_empty) = EMPTY;
    dat_is_east_and_right_is_empty_rshift = [zeros(rows(dat_is_east_and_right_is_empty), 1), dat_is_east_and_right_is_empty(:, 1:end-1)];
    dat(logical(dat_is_east_and_right_is_empty_rshift)) = EAST;
    dat = remove_padding(dat);
end

function dat = submove2(dat)
    global EMPTY;
    global SOUTH;

    dat = add_padding(dat);
    dat_ushift = [dat(2:end, :); zeros(1, columns(dat))];
    dat_is_south_and_down_is_empty = ((dat == SOUTH) & (dat_ushift == EMPTY));
    dat(dat_is_south_and_down_is_empty) = EMPTY;
    dat_is_south_and_down_is_empty_dshift = [zeros(1, columns(dat_is_south_and_down_is_empty)); dat_is_south_and_down_is_empty(1:end-1, :)];
    dat(logical(dat_is_south_and_down_is_empty_dshift)) = SOUTH;
    dat = remove_padding(dat);
end

function dat = move(dat)
    dat = submove1(dat);
    dat = submove2(dat);
end

dat_prev = zeros(size(dat));
i = 0;

while(true)
    if(isequal(dat, dat_prev))
        disp(i);
        break;
    end

    dat_prev = dat;
    dat = move(dat);
    i++;
end

assert(i == 509);


