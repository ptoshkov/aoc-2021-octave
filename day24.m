monad = 99999999999999;

function print_monad(monad)
    if(monad == 99999999999900 ||
       monad == 99999999990000 ||
       monad == 99999999000000 ||
       monad == 99999900000000 ||
       monad == 99990000000000 ||
       monad == 99000000000000 ||
       monad == 90000000000000 ||
       monad == 29111111111111 ||
       monad == 21191111111111 ||
       monad == 21111911111111 ||
       monad == 21111119111111 ||
       monad == 21111111191111 ||
       monad == 21111111111911 ||
       monad == 21111111111111 ||
       monad == 19111111111111 ||
       monad == 11191111111111 ||
       monad == 11111911111111 ||
       monad == 11111119111111 ||
       monad == 11111111191111 ||
       monad == 11111111111911)
        disp(monad);
    end
end

function z = fmonad(monad, z)
    x = 0;
    y = 0;

    w = monad(1);
    z = 26*z + w + 6;
    disp(z);

    w = monad(2);
    z = 26*z + w + 6;
    disp(z);

    w = monad(3);
    z = 26*z + w + 3;
    disp(z);

    disp("four")
    disp(rem(z, 26) - 11);
    w = monad(4);
    x = ((rem(z, 26) - 11) ~= w);
    z = (w + 11)*x + (25*x + 1)*floor(z/26);
    disp(z);

    w = monad(5);
    z = 26*z + w + 9;
    disp(z);

    disp("six")
    disp(rem(z, 26) - 1);
    w = monad(6);
    x = ((rem(z, 26) - 1) ~= w);
    z = (w + 3)*x + (25*x + 1)*floor(z/26);
    disp(z);

    w = monad(7);
    z = 26*z + w + 13;
    disp(z);

    w = monad(8);
    z = 26*z + w + 6;
    disp(z);

    disp("nine")
    disp(rem(z, 26));
    w = monad(9);
    x = (rem(z, 26) ~= w);
    z = (w + 14)*x + (25*x + 1)*floor(z/26);
    disp(z);

    w = monad(10);
    z = 26*z + w + 10;
    disp(z);

    disp("eleven")
    disp(rem(z, 26) - 5);
    w = monad(11);
    x = ((rem(z, 26) - 5) ~= w);
    z = (w + 12)*x + (25*x + 1)*floor(z/26);
    disp(z);

    disp("twelve")
    disp((rem(z, 26) - 16));
    w = monad(12);
    x = ((rem(z, 26) - 16) ~= w);
    z = (w + 10)*x + (25*x + 1)*floor(z/26);
    disp(z);

    disp("thirteen")
    disp((rem(z, 26) - 7));
    w = monad(13);
    x = ((rem(z, 26) - 7) ~= w);
    z = (w + 11)*x + (25*x + 1)*floor(z/26);
    disp(z);

    disp("fourteen")
    disp((rem(z, 26) - 11));
    w = monad(14);
    x = ((rem(z, 26) - 11) ~= w);
    z = (w + 15)*x + (25*x + 1)*floor(z/26);
    disp(z);
end

res = fmonad ([9 9 9 1 1 9 9 3 9 4 9 6 8 4],0);
assert(res==0);
res = fmonad ([6 2 9 1 1 9 4 1 7 1 6 1 1 1],0);
assert(res==0);
