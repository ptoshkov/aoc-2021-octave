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
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=12;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=6;
    y*=x;
    z+=y;

    w = monad(2);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=10;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=6;
    y*=x;
    z+=y;

    w = monad(3);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=13;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=3;
    y*=x;
    z+=y;

    w = monad(4);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=-11;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=11;
    y*=x;
    z+=y;

    w = monad(5);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=13;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=9;
    y*=x;
    z+=y;

    w = monad(6);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=-1;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=3;
    y*=x;
    z+=y;

    w = monad(7);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=10;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=13;
    y*=x;
    z+=y;

    w = monad(8);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=11;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=6;
    y*=x;
    z+=y;

    w = monad(9);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=0;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=14;
    y*=x;
    z+=y;

    w = monad(10);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    x+=10;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=10;
    y*=x;
    z+=y;

    w = monad(11);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=-5;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=12;
    y*=x;
    z+=y;

    w = monad(12);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=-16;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=10;
    y*=x;
    z+=y;

    w = monad(13);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=-7;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=11;
    y*=x;
    z+=y;
    
    w = monad(14);
    x*=0;
    x+=z;
    assert(x >= 0); x = rem(x, 26);
    z = floor(z/26);
    x+=-11;
    x = (x == w);
    x = (x == 0);
    y*=0;
    y+=25;
    y*=x;
    y+=1;
    z*=y;
    y*=0;
    y+=w;
    y+=15;
    y*=x;
    z+=y;
end

while(true)
    print_monad(monad);
    found = false;
    monad_mat = sprintf('%d', monad) - '0';

    if(~(any(monad_mat == 0)))
        for z = 0:25
            if(fmonad(monad_mat, z) == 0)
                disp("FOUND");
                disp(monad);
                found = true;
            end
        end
    end

    if(found)
        break;
    end

    monad--;
end

% monad = 11111111111111;
% 
% while(true)
%     print_monad(monad);
%     found = false;
%     monad_mat = sprintf('%d', monad) - '0';
% 
%     if(~(any(monad_mat == 0)))
%         for z = 0:25
%             if(fmonad(monad_mat, z) == 0)
%                 disp("FOUND");
%                 disp(monad);
%                 found = true;
%             end
%         end
%     end
% 
%     if(found)
%         break;
%     end
% 
%     monad++;
% end

