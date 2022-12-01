clear
clc

dino = simpleGameEngine('Final.png',80,80,1,[255,255,255]);

emptyrow = [5,5,5,5,5,5,5,5,5,5];

walk2 = [emptyrow;emptyrow;2,5,5,5,5,5,5,5,5,5];
walk3 = [emptyrow;emptyrow;3,5,5,5,5,5,5,5,5,5];
duck1 = [emptyrow;emptyrow;9,5,5,5,5,5,5,5,5,5];
duck2 = [emptyrow;emptyrow;10,5,5,5,5,5,5,5,5,5];
walkdeath = [emptyrow;emptyrow;4,5,5,5,5,5,5,5,5,5];
background = [emptyrow;emptyrow;emptyrow];

jumpcycle = 0;
jumpcooldown = 0;
goingup = true;
updater = 0;
deathbuffer = 0;
ticker = 0;
happyfeet = false;
duck = false;
hit = false;
framerate = 120;
level = 4;



attempt = 1;
currentscore = 0;
obstacles = [13,13,13,13,13,13,13];
obstaclespacing = 10;
frequency = [10,11,11,12,12,12,13,13,14];
levelbuffer = true;


scoreboard = [];
rankedscoreboard = [];

drawScene(dino,background,walk3)
dino.my_figure.KeyPressFcn = @(src,event)guidata(src,event.Key);
dino.my_figure.KeyReleaseFcn = @(src,event)guidata(src,'0');
key_down = guidata(dino.my_figure);

while ~strcmp(key_down,'escape')
   
    while hit == false 
   
        %updates the score
        currentscore = currentscore + 1;

        %update background speed depending on level
        %updater range 0-40
        updater = updater + level;

        %cactus shift goes from 0 to 12, cactus shift goes to 0  if key pressed
        %cactus shifts thru array every 40 frames
        %level dictates speed, or number of frames skipped, Level 1 means frame by
        %frame on sprite sheet or slowest speed. Level 2 means skipping through
        %every other frame meaning twice as fast
        %simple loop animates empty ground
        ground = 112 + updater;
    
        %every frame sets the ground and sky empty before placing objects
        activerow = [ground,ground,ground,ground,ground,ground,ground,ground,ground,ground];
        midrow = emptyrow;
        toprow = emptyrow;

        firstjumprow = emptyrow;
        secondjumprow = emptyrow;
        thirdjumprow = emptyrow;



    
        %ticker changes every frame, ticker = framerate
        if ticker < 120
            ticker = ticker +1;   
        else
            ticker = ticker - 120;
        end
    
        %do switch feet every 10 frames or 10/120 seconds
        if mod(ticker, 10) == 0
                happyfeet = ~happyfeet;
        end
    
        
 
    
        %updater is the variable that flips through the indexes on the sprite sheet
        %every frame
        if mod(updater, 40) == 0
            updater = 0;
            if currentscore < 600
                range = 3;
            else
                if currentscore < 1000
                    range = 4;
                    frequency = [9,10,10,11,11,11,12,12,13];
                else
                    if currentscore < 1400
                        range = 7;
                    else
                        if currentscore < 2000
                            frequency = [8,9,9,10,10,10,11,11,12];
                        else 
                            if currentscore < 2500

                                
                                if levelbuffer == true
                                    if obstaclespacing == 0
                                         obstaclespacing = 20;
                                         levelbuffer = false;
                                    end
                           
                                else
                                    level = 5;
                                    frequency = [10,11,11,12,12,12,13,13,14];
                                end
                                
                            else
                                if currentscore < 3000
                                    frequency = [9,10,10,11,11,11,12,12,13];
                                else
                                    if currentscore < 3500
                                         frequency = [8,9,9,10,10,10,11,11,12];
                                    end
                                end
                            end
                        end
                    end
                end
            end
        
            if obstaclespacing == 0 
                obstaclespacing = frequency(randi(length(frequency)));
                randomindex = randi(range);
                while obstacles(randomindex) ~= 13
                    randomindex = randi(range);
                end
                obstacles(randomindex) = 0;
            end
            if obstaclespacing > 0
                obstaclespacing = obstaclespacing - 1;
            end
            if obstacles(4) < 13
                obstacles(4) = obstacles(4) + 1;
            end
            if obstacles(1) < 13
                obstacles(1) = obstacles(1) + 1;
            end   
            if obstacles(2) < 13
                obstacles(2) = obstacles(2) + 1;
            end   
            if obstacles(3) < 13
                obstacles(3) = obstacles(3) + 1;
            end   
            if obstacles(5) < 13
                obstacles(5) = obstacles(5) + 1;
            end   
            if obstacles(6) < 13
                obstacles(6) = obstacles(6) + 1;
            end 
            if obstacles(7) < 13
                obstacles(7) = obstacles(7) + 1;
            end     
        end
       
        
    
        %animates the cycle for a single tall cactus
        if obstacles(1) == 0
            activerow(10) = 33 + updater;
        else
            if obstacles(1) < 10
                activerow(10 - obstacles(1)) = 33 + updater;
                activerow(11 - obstacles(1)) = 73 + updater;
                hit = checkcollision(activerow, jumpcooldown, duck);
            else
                if obstacles(1) == 10
                    activerow(1) = 73 + updater;    
                end
            end
        end
        %animates the cycle for a single small cactus
        if obstacles(2) == 0
            activerow(10) = 609 + updater;
        else
            if obstacles(2) < 10
                activerow(10 - obstacles(2)) = 609 + updater;
                activerow(11 - obstacles(2)) = 649 + updater;
                hit = checkcollision(activerow, jumpcooldown, duck);
            else
                if obstacles(2) == 10
                    activerow(1) = 649 + updater;    
                end
            end
        end
        %animates the cycle for a double small cactus
        if obstacles(3) == 0
            activerow(10) = 689 + updater;
        else
            if obstacles(3) < 10
                activerow(10 - obstacles(3)) = 689 + updater;
                activerow(11 - obstacles(3)) = 729 + updater;
                hit = checkcollision(activerow, jumpcooldown, duck);
            else
                if obstacles(3) == 10
                    activerow(1) = 729 + updater;    
                end
            end
        end
        %animates the cycle for a quad cactus
        if obstacles(4) == 0
            activerow(10) = 201 + updater;
        else
            if obstacles(4) == 1
                activerow(9) = 201 + updater;
                activerow(10) = 241 + updater;
            else
                if obstacles(4) < 10
                    activerow(12 - obstacles(4)) = 281 + updater;
                    activerow(11 - obstacles(4)) = 241 + updater;
                    activerow(10 - obstacles(4)) = 201 + updater;
                    hit = checkcollision(activerow, jumpcooldown, duck);
                else
                    if obstacles(4) == 10
                        activerow(1) = 241 + updater;
                        activerow(2) = 281 + updater;
                        hit = checkcollision(activerow, jumpcooldown, duck);
                    else
                        if obstacles(4) == 11
                           activerow(1) = 281 + updater;
                           hit = checkcollision(activerow, jumpcooldown, duck);
                        end
                    end
                end
            end
        end
         %animates the cycle for a low bird
        if obstacles(5) == 0
            activerow(10) = 369 + updater;
        else
            if obstacles(5) < 10
                activerow(10 - obstacles(5)) = 369 + updater;
                activerow(11 - obstacles(5)) = 409 + updater;
                hit = checkcollision(activerow,jumpcooldown, duck);
              
            else
                if obstacles(5) == 10
                    activerow(1) = 409 + updater;    
                    hit = checkcollision(activerow,jumpcooldown,duck);
                end
            end
        end
         %animates the cycle for a midlow bird
        if obstacles(6) == 0
            activerow(10) = 449 + updater;
        else
            if obstacles(6) < 10
                activerow(10 - obstacles(6)) = 449 + updater;
                activerow(11 - obstacles(6)) = 489 + updater;
                hit = checkcollision(activerow,jumpcooldown, duck);
              
            else
                if obstacles(6) == 10
                    activerow(1) = 489 + updater; 
                    hit = checkcollision(activerow,jumpcooldown, duck);
                end
            end
        end
         %animates the cycle for a midhigh bird
        if obstacles(7) == 0
            midrow(10) = 529 + updater;
        else
            if obstacles(7) < 10
                midrow(10 - obstacles(7)) = 529 + updater;
                midrow(11 - obstacles(7)) = 569 + updater;
                hit = checkcollision(midrow,jumpcooldown, duck);
              
            else
                if obstacles(7) == 10
                    midrow(1) = 569 + updater;   
                    hit = checkcollision(midrow,jumpcooldown, duck);
                end
            end
        end
    
        %update jump animation every 2 frames or 1/60 seconds
        if hit == true
            deathbuffer = 168;
        end
        if jumpcycle == 1
            if mod(ticker, 2) == 0
                if goingup == true
                    jumpcooldown = jumpcooldown + 1;
                else
                    jumpcooldown = jumpcooldown - 1;
                end
            end
            if jumpcooldown  < 2
                thirdjumprow(1) = 152 + jumpcooldown + deathbuffer;
            else
                if jumpcooldown < 6
                    thirdjumprow(1) = 152 + jumpcooldown + deathbuffer;
                    secondjumprow(1) = 159 + jumpcooldown + deathbuffer;
                else
                    if jumpcooldown < 20
                        secondjumprow(1) = 159 + jumpcooldown + deathbuffer;
                        firstjumprow(1) = 177 + jumpcooldown + deathbuffer;
                    else
                        firstjumprow(1) = 177 + jumpcooldown + deathbuffer;
                    end
                end
            end
        end
        if jumpcooldown == 20
            goingup = false;
        end
        if jumpcooldown == 0
            jumpcycle = 0;
        end
    
        jump = [firstjumprow;secondjumprow;thirdjumprow]; 
        background = [toprow;midrow;activerow];  
    
        tic
        key_down = guidata(dino.my_figure);
    
        if hit == false
            if jumpcycle == 1
                 drawScene(dino, background, jump)
            else
                if strcmp(key_down,'downarrow')
                   duck = true;
                   if happyfeet == true 
                        drawScene(dino, background,duck1)
                    else 
                        drawScene(dino, background,duck2)
                   end
                else
                   duck = false;
                   if happyfeet == true
                       drawScene(dino, background,walk2)
                   else
                       drawScene(dino,background, walk3)
                   end
                end
            end
            if strcmp(key_down,'uparrow') || strcmp(key_down, 'space')
                if jumpcycle == 0
                        jumpcycle = 1;
                        goingup = true;
                        jumpcooldown = 0;
                else
                    jumpcycle = 1;
                end     
            end
        else
            if jumpcycle == 0
                drawScene(dino, background,walkdeath)
            else
                drawScene(dino, background, jump)
            end
        end
       
        
        pause(1/framerate - toc);  
    end

    if currentscore ~= 0
        gameover = text(305,40,"GAME OVER","FontSize",20,"FontWeight","bold");
        instructions1 = text(15,30,"PRESS 'ESC' TO EXIT",'FontSize',8);
        instructions2 = text(15,50,"PRESS 'RETURN' TO PLAY AGAIN",'FontSize',8);
        scoredisplay = text(350, 70, "Your Score: " + int2str(currentscore),"FontSize",10,"FontWeight","bold");

        scoreboard = [scoreboard ; [attempt, currentscore]];
        rankedscoreboard = [scoreboard(1:end,1), sort(scoreboard(1:end,2),"descend")];
        scoreboarddisplay = [text(360, 100, "Top 5 scores:"), text(450, 100, "")];
       

        if size(rankedscoreboard)  < 5
            for x = 1 : size(scoreboard)
                scoreboarddisplay = [scoreboarddisplay; [text(380, 110 + 20 * x, int2str(x)),text(440, 110 + 20 * x,int2str(rankedscoreboard(x,2))) ]];
            end
        else
            for x = 1 : 5
                scoreboarddisplay = [scoreboarddisplay; [text(380, 110 + 20 * x, int2str(x)),text(440, 110 + 20 * x,int2str(rankedscoreboard(x,2))) ]];
            end
        end
       

        attempt = attempt + 1;
        currentscore = 0;

    end
    

    tic
    key_down = guidata(dino.my_figure);
    pause(1/framerate - toc)
    if strcmp(key_down,'return')

        delete(gameover)
        delete(scoredisplay)
        delete(scoreboarddisplay)
        delete(instructions1)
        delete(instructions2)

        jumpcycle = 0;
        jumpcooldown = 0;
        goingup = true;
        updater = 0;
        deathbuffer = 0;
        ticker = 0;
        happyfeet = false;
        duck = false;
        hit = false;
        level = 4;
        framerate = 120;
    

        obstacles = [13,13,13,13,13,13,13];
        obstaclespacing = 10;
        frequency = [10,11,11,12,12,12,13,13,14];
        levelbuffer = true;
        
    end
end
close all
fprintf("play time is over")