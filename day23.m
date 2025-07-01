% part 1
global SORTED;
global POSITIONS;
global NUM_POSITIONS;
global lowest_cost;
global states;
global total_costs;

dat = importdata('day23.dat');
dat = [cell2mat(dat(1:3)); cell2mat(dat(4:5))];
lowest_cost = Inf;
SORTED = dat;
SORTED(3,4) = 'A';
SORTED(4,4) = 'A';
SORTED(3,6) = 'B';
SORTED(4,6) = 'B';
SORTED(3,8) = 'C';
SORTED(4,8) = 'C';
SORTED(3,10) = 'D';
SORTED(4,10) = 'D';
POSITIONS = [
    2, 2; % 1
    2, 3; % 2
    2, 5; % 3
    2, 7; % 4
    2, 9; % 5
    2, 11; % 6
    2, 12; % 7
    3, 4; % 8
    3, 6; % 9
    3, 8; % 10
    3, 10; % 11
    4, 4; % 12
    4, 6; % 13
    4, 8; % 14
    4, 10; % 15
    ];
NUM_POSITIONS = (size(POSITIONS))(1);
states = [];
total_costs = [];

function ret = is_sorted(dat)
    global SORTED;
    ret = all((dat==SORTED)(:));
end

function ret = is_empty(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == '.');
end

function ret = is_A(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'A');
end

function ret = is_B(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'B');
end

function ret = is_C(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'C');
end

function ret = is_D(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'D');
end

function ret = is_room(idx)
    ret = (idx(1) > 2);
end

function ret = is_hallway(idx)
    ret = (idx(1) == 2);
end

function ret = is_clear_A(dat)
    ret = (((is_empty(dat, [3, 4])) || (is_A(dat, [3, 4]))) && ((is_empty(dat, [4, 4])) || (is_A(dat, [4, 4]))));
end

function ret = is_clear_B(dat)
    ret = (((is_empty(dat, [3, 6])) || (is_B(dat, [3, 6]))) && ((is_empty(dat, [4, 6])) || (is_B(dat, [4, 6]))));
end

function ret = is_clear_C(dat)
    ret = (((is_empty(dat, [3, 8])) || (is_C(dat, [3, 8]))) && ((is_empty(dat, [4, 8])) || (is_C(dat, [4, 8]))));
end

function ret = is_clear_D(dat)
    ret = (((is_empty(dat, [3, 10])) || (is_D(dat, [3, 10]))) && ((is_empty(dat, [4, 10])) || (is_D(dat, [4, 10]))));
end

function steps = get_steps(dat, idx1, idx2)
    steps = 0;
    idx1_row = idx1(1);
    idx1_col = idx1(2);
    idx2_row = idx2(1);
    idx2_col = idx2(2);

    if(idx1_row >= 4)
        if(~(is_empty(dat, [3, idx1_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx1_row >= 3)
        if(~(is_empty(dat, [2, idx1_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    incr = 1;

    if(idx1_col > idx2_col)
        incr = -1;
    end

    route = dat(2, (idx1_col + incr):incr:idx2_col);

    if(~(all(route == '.')))
        steps = 0;
        return;
    end

    steps += length(route);

    if(idx2_row >= 3)
        if(~(is_empty(dat, [3, idx2_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx2_row >= 4)
        if(~(is_empty(dat, [4, idx2_col])))
            steps = 0;
            return;
        end
        steps++;
    end
end

function cost = get_cost(dat, idx1, idx2)
    cost = 0;

    if(all(idx1==idx2))
        return;
    end

    if(~(is_empty(dat, idx2)))
        return;
    end

    if(is_A(dat, idx1))
        if(isequal(idx1, [4, 4]))
            return;
        end

        if(isequal(idx1, [3, 4]) && is_A(dat, [4, 4]))
            return;
        end
    elseif(is_B(dat, idx1))
        if(isequal(idx1, [4, 6]))
            return;
        end

        if(isequal(idx1, [3, 6]) && is_B(dat, [4, 6]))
            return;
        end
    elseif(is_C(dat, idx1))
        if(isequal(idx1, [4, 8]))
            return;
        end

        if(isequal(idx1, [3, 8]) && is_C(dat, [4, 8]))
            return;
        end
    elseif(is_D(dat, idx1))
        if(isequal(idx1, [4, 10]))
            return;
        end

        if(isequal(idx1, [3, 10]) && is_D(dat, [4, 10]))
            return;
        end
    end

    if(idx2(1) == 3)
        % destination is top chamber

        bottom_chamber_idx = [4, idx2(2)];
        if(is_empty(dat, bottom_chamber_idx))
            % bottom chamber is empty
            return;
        end
    end

    if(is_room(idx2))
        % destination is a room

        if(is_A(dat, idx1) && (idx2(2) ~= 4))
            % animal is A and room is not room A
            return;
        elseif(is_B(dat, idx1) && (idx2(2) ~= 6))
            % animal is B and room is not room B
            return;
        elseif(is_C(dat, idx1) && (idx2(2) ~= 8))
            % animal is C and room is not room C
            return;
        elseif(is_D(dat, idx1) && (idx2(2) ~= 10))
            % animal is D and room is not room D
            return;
        end

        if(is_A(dat, idx1) && (~(is_clear_A(dat))))
            % enemies in room A
            return;
        elseif(is_B(dat, idx1) && (~(is_clear_B(dat))))
            % enemies in room B
            return;
        elseif(is_C(dat, idx1) && (~(is_clear_C(dat))))
            % enemies in room C
            return;
        elseif(is_D(dat, idx1) && (~(is_clear_D(dat))))
            % enemies in room D
            return;
        end
    end

    if(~(is_room(idx2)))
        % destination is hallway

        if(~(is_room(idx1)))
            % animal is in hallway
            return;
        end
    end

    steps = get_steps(dat, idx1, idx2);

    if(steps == 0)
        % path is obstructed
        return;
    end

    cost_per_move = 0;
    if(is_A(dat, idx1))
        cost_per_move = 1;
    elseif(is_B(dat, idx1))
        cost_per_move = 10;
    elseif(is_C(dat, idx1))
        cost_per_move = 100;
    elseif(is_D(dat, idx1))
        cost_per_move = 1000;
    end
    assert(cost_per_move > 0);
    cost = steps*cost_per_move;
end

function total_cost = move(dat, total_cost)
    global POSITIONS;
    global NUM_POSITIONS;
    global lowest_cost;
    global states;
    global total_costs;

    if(total_cost >= lowest_cost)
        return;
    end

    state = reshape(transpose(dat), 1, []);
    state_idx = ismember(states, state, 'rows');

    if(any(state_idx))
        state_cost = total_costs(state_idx);

        if(total_cost < state_cost)
            % found new lowest cost for this state
            total_costs(state_idx) = total_cost;
        else
            return;
        end
    else
        % found a new state
        states = [states; state];
        total_costs = [total_costs; total_cost];
    end

    if(is_sorted(dat))
        disp("SORTED")
        disp(total_cost);
        lowest_cost = min(lowest_cost, total_cost);
        return;
    end

    % pause(1);
    % disp("moving")
    % disp(dat)
    % disp("position")
    % disp(position)
    % disp("value")
    % disp(dat(idx(1), idx(2)));

    for position = 1:NUM_POSITIONS
        idx = POSITIONS(position, :);
        
        if(is_empty(dat, idx))
            continue;
        end

        for target = 1:NUM_POSITIONS
            target_idx = POSITIONS(target, :);
            cost = get_cost(dat, idx, target_idx);

            if(cost > 0)
                new_dat = dat;
                % move current to target
                new_dat(target_idx(1), target_idx(2)) = new_dat(idx(1), idx(2));
                % set current to empty
                new_dat(idx(1), idx(2)) = '.';
                move(new_dat, total_cost + cost);
            end
        end
    end
end

move(dat, 0);
assert(lowest_cost == 15365);

clear all;

% part 2
global SORTED;
global POSITIONS;
global NUM_POSITIONS;
global lowest_cost;
global states;
global total_costs;

dat = importdata('day23.dat');
dat = [cell2mat(dat(1:3)); cell2mat(dat(4:5))];
dat = [dat(1:3, :);
' ', ' ', '#', 'D', '#', 'C', '#', 'B', '#', 'A', '#', ' ', ' ';
' ', ' ', '#', 'D', '#', 'B', '#', 'A', '#', 'C', '#', ' ', ' ';
dat(4:5, :)];
lowest_cost = Inf;
SORTED = dat;
SORTED(3,4) = 'A';
SORTED(4,4) = 'A';
SORTED(5,4) = 'A';
SORTED(6,4) = 'A';
SORTED(3,6) = 'B';
SORTED(4,6) = 'B';
SORTED(5,6) = 'B';
SORTED(6,6) = 'B';
SORTED(3,8) = 'C';
SORTED(4,8) = 'C';
SORTED(5,8) = 'C';
SORTED(6,8) = 'C';
SORTED(3,10) = 'D';
SORTED(4,10) = 'D';
SORTED(5,10) = 'D';
SORTED(6,10) = 'D';
POSITIONS = [
    2, 2; % 1
    2, 3; % 2
    2, 5; % 3
    2, 7; % 4
    2, 9; % 5
    2, 11; % 6
    2, 12; % 7
    3, 4; % 8
    3, 6; % 9
    3, 8; % 10
    3, 10; % 11
    4, 4; % 12
    4, 6; % 13
    4, 8; % 14
    4, 10; % 15
    5, 4; % 16
    5, 6; % 17
    5, 8; % 18
    5, 10; % 19
    6, 4; % 20
    6, 6; % 21
    6, 8; % 22
    6, 10; % 23
    ];
NUM_POSITIONS = (size(POSITIONS))(1);
states = [];
total_costs = [];

function ret = is_sorted(dat)
    global SORTED;
    ret = all((dat==SORTED)(:));
end

function ret = is_empty(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == '.');
end

function ret = is_A(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'A');
end

function ret = is_B(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'B');
end

function ret = is_C(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'C');
end

function ret = is_D(dat, idx)
    value = dat(idx(1), idx(2));
    ret = (value == 'D');
end

function ret = is_room(idx)
    ret = (idx(1) > 2);
end

function ret = is_hallway(idx)
    ret = (idx(1) == 2);
end

function ret = is_clear_A(dat)
    ret = (
        ((is_empty(dat, [3, 4])) || (is_A(dat, [3, 4]))) &&
        ((is_empty(dat, [4, 4])) || (is_A(dat, [4, 4]))) &&
        ((is_empty(dat, [5, 4])) || (is_A(dat, [5, 4]))) &&
        ((is_empty(dat, [6, 4])) || (is_A(dat, [6, 4])))
        );
end

function ret = is_clear_B(dat)
    ret = (
        ((is_empty(dat, [3, 6])) || (is_B(dat, [3, 6]))) &&
        ((is_empty(dat, [4, 6])) || (is_B(dat, [4, 6]))) &&
        ((is_empty(dat, [5, 6])) || (is_B(dat, [5, 6]))) &&
        ((is_empty(dat, [6, 6])) || (is_B(dat, [6, 6])))
        );
end

function ret = is_clear_C(dat)
    ret = (
        ((is_empty(dat, [3, 8])) || (is_C(dat, [3, 8]))) &&
        ((is_empty(dat, [4, 8])) || (is_C(dat, [4, 8]))) &&
        ((is_empty(dat, [5, 8])) || (is_C(dat, [5, 8]))) &&
        ((is_empty(dat, [6, 8])) || (is_C(dat, [6, 8])))
        );
end

function ret = is_clear_D(dat)
    ret = (
        ((is_empty(dat, [3, 10])) || (is_D(dat, [3, 10]))) &&
        ((is_empty(dat, [4, 10])) || (is_D(dat, [4, 10]))) &&
        ((is_empty(dat, [5, 10])) || (is_D(dat, [5, 10]))) &&
        ((is_empty(dat, [6, 10])) || (is_D(dat, [6, 10])))
        );
end

function steps = get_steps(dat, idx1, idx2)
    steps = 0;
    idx1_row = idx1(1);
    idx1_col = idx1(2);
    idx2_row = idx2(1);
    idx2_col = idx2(2);

    if(idx1_row >= 6)
        if(~(is_empty(dat, [5, idx1_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx1_row >= 5)
        if(~(is_empty(dat, [4, idx1_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx1_row >= 4)
        if(~(is_empty(dat, [3, idx1_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx1_row >= 3)
        if(~(is_empty(dat, [2, idx1_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    incr = 1;

    if(idx1_col > idx2_col)
        incr = -1;
    end

    route = dat(2, (idx1_col + incr):incr:idx2_col);

    if(~(all(route == '.')))
        steps = 0;
        return;
    end

    steps += length(route);

    if(idx2_row >= 3)
        if(~(is_empty(dat, [3, idx2_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx2_row >= 4)
        if(~(is_empty(dat, [4, idx2_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx2_row >= 5)
        if(~(is_empty(dat, [5, idx2_col])))
            steps = 0;
            return;
        end
        steps++;
    end

    if(idx2_row >= 6)
        if(~(is_empty(dat, [6, idx2_col])))
            steps = 0;
            return;
        end
        steps++;
    end
end

function cost = get_cost(dat, idx1, idx2)
    cost = 0;

    if(all(idx1==idx2))
        return;
    end

    if(~(is_empty(dat, idx2)))
        return;
    end

    if(is_A(dat, idx1))
        if(isequal(idx1, [6, 4]))
            return;
        end

        if(isequal(idx1, [5, 4]) && is_A(dat, [6, 4]))
            return;
        end

        if(isequal(idx1, [4, 4]) && is_A(dat, [5, 4]) && is_A(dat, [6, 4]))
            return;
        end

        if(isequal(idx1, [3, 4]) && is_A(dat, [4, 4]) && is_A(dat, [5, 4]) && is_A(dat, [6, 4]))
            return;
        end
    elseif(is_B(dat, idx1))
        if(isequal(idx1, [6, 6]))
            return;
        end

        if(isequal(idx1, [5, 6]) && is_B(dat, [6, 6]))
            return;
        end

        if(isequal(idx1, [4, 6]) && is_B(dat, [5, 6]) && is_B(dat, [6, 6]))
            return;
        end

        if(isequal(idx1, [3, 6]) && is_B(dat, [4, 6]) && is_B(dat, [5, 6]) && is_B(dat, [6, 6]))
            return;
        end
    elseif(is_C(dat, idx1))
        if(isequal(idx1, [6, 8]))
            return;
        end

        if(isequal(idx1, [5, 8]) && is_C(dat, [6, 8]))
            return;
        end

        if(isequal(idx1, [4, 8]) && is_C(dat, [5, 8]) && is_C(dat, [6, 8]))
            return;
        end

        if(isequal(idx1, [3, 8]) && is_C(dat, [4, 8]) && is_C(dat, [5, 8]) && is_C(dat, [6, 8]))
            return;
        end
    elseif(is_D(dat, idx1))
        if(isequal(idx1, [6, 10]))
            return;
        end

        if(isequal(idx1, [5, 10]) && is_D(dat, [6, 10]))
            return;
        end

        if(isequal(idx1, [4, 10]) && is_D(dat, [5, 10]) && is_D(dat, [6, 10]))
            return;
        end

        if(isequal(idx1, [3, 10]) && is_D(dat, [4, 10]) && is_D(dat, [5, 10]) && is_D(dat, [6, 10]))
            return;
        end
    end

    if(idx2(1) == 3)
        % destination is top chamber

        bottom_chamber_idx1 = [4, idx2(2)];
        bottom_chamber_idx2 = [5, idx2(2)];
        bottom_chamber_idx3 = [6, idx2(2)];
        if(is_empty(dat, bottom_chamber_idx1) || is_empty(dat, bottom_chamber_idx2) || is_empty(dat, bottom_chamber_idx3))
            % bottom chamber is empty
            return;
        end
    end

    if(idx2(1) == 4)
        % destination is top chamber

        bottom_chamber_idx1 = [5, idx2(2)];
        bottom_chamber_idx2 = [6, idx2(2)];
        if(is_empty(dat, bottom_chamber_idx1) || is_empty(dat, bottom_chamber_idx2))
            % bottom chamber is empty
            return;
        end
    end

    if(idx2(1) == 5)
        % destination is top chamber

        bottom_chamber_idx = [6, idx2(2)];
        if(is_empty(dat, bottom_chamber_idx))
            % bottom chamber is empty
            return;
        end
    end

    if(is_room(idx2))
        % destination is a room

        if(is_A(dat, idx1) && (idx2(2) ~= 4))
            % animal is A and room is not room A
            return;
        elseif(is_B(dat, idx1) && (idx2(2) ~= 6))
            % animal is B and room is not room B
            return;
        elseif(is_C(dat, idx1) && (idx2(2) ~= 8))
            % animal is C and room is not room C
            return;
        elseif(is_D(dat, idx1) && (idx2(2) ~= 10))
            % animal is D and room is not room D
            return;
        end

        if(is_A(dat, idx1) && (~(is_clear_A(dat))))
            % enemies in room A
            return;
        elseif(is_B(dat, idx1) && (~(is_clear_B(dat))))
            % enemies in room B
            return;
        elseif(is_C(dat, idx1) && (~(is_clear_C(dat))))
            % enemies in room C
            return;
        elseif(is_D(dat, idx1) && (~(is_clear_D(dat))))
            % enemies in room D
            return;
        end
    end

    if(~(is_room(idx2)))
        % destination is hallway

        if(~(is_room(idx1)))
            % animal is in hallway
            return;
        end
    end

    steps = get_steps(dat, idx1, idx2);

    if(steps == 0)
        % path is obstructed
        return;
    end

    cost_per_move = 0;
    if(is_A(dat, idx1))
        cost_per_move = 1;
    elseif(is_B(dat, idx1))
        cost_per_move = 10;
    elseif(is_C(dat, idx1))
        cost_per_move = 100;
    elseif(is_D(dat, idx1))
        cost_per_move = 1000;
    end
    assert(cost_per_move > 0);
    cost = steps*cost_per_move;
end

function total_cost = move(dat, total_cost)
    global POSITIONS;
    global NUM_POSITIONS;
    global lowest_cost;
    global states;
    global total_costs;

    if(total_cost >= lowest_cost)
        return;
    end

    state = reshape(transpose(dat), 1, []);
    state_idx = ismember(states, state, 'rows');

    if(any(state_idx))
        state_cost = total_costs(state_idx);

        if(total_cost < state_cost)
            % found new lowest cost for this state
            total_costs(state_idx) = total_cost;
        else
            return;
        end
    else
        % found a new state
        states = [states; state];
        total_costs = [total_costs; total_cost];
    end

    if(is_sorted(dat))
        disp("SORTED")
        disp(total_cost);
        lowest_cost = min(lowest_cost, total_cost);
        return;
    end

    % pause(1);
    % disp("moving")
    % disp(dat)

    for position = 1:NUM_POSITIONS
        idx = POSITIONS(position, :);
        
        if(is_empty(dat, idx))
            continue;
        end

        for target = 1:NUM_POSITIONS
            target_idx = POSITIONS(target, :);
            cost = get_cost(dat, idx, target_idx);

            if(cost > 0)
                new_dat = dat;
                % move current to target
                new_dat(target_idx(1), target_idx(2)) = new_dat(idx(1), idx(2));
                % set current to empty
                new_dat(idx(1), idx(2)) = '.';
                move(new_dat, total_cost + cost);
            end
        end
    end
end

move(dat, 0);
assert(lowest_cost == 52055);
