function [hit] = checkcollision(activerow, jumpcooldown, duck)
    height = 0;
    hit = false;
    if jumpcooldown > 0
        height = -2/5 * (jumpcooldown) * (jumpcooldown - 40);
    end
    %tall cactus

    if height < 17 && activerow(1) < 68 && activerow(1) > 32
        hit = true;
    end
    if height < 40 && activerow(1) < 63 && activerow(1) > 39
        hit = true;
    end
    if height < 57 && activerow(1) < 83 && activerow(1) > 42
        hit = true;
    end
    if height < 80 && activerow(1) < 77  && activerow(1) > 49
        hit = true;
    end

    %quadcactus

    if height < 20 && (activerow(1) < 283 && activerow(1) > 200)
        hit = true;
    end
    if height < 40 && activerow(1) < 276 && activerow(1) > 207
        hit = true;
    end
    if height < 60 && activerow(1) < 298 && activerow(1) > 210
        hit = true;
    end
    if height < 80 && activerow(1) < 291  && activerow(1) > 217
        hit = true;
    end

    %lowbird

    if height < 29  && activerow(1) < 411 && activerow(1) > 378
        hit = true;
    end
    if height < 29 && activerow(1) < 424 && activerow(1) > 420 
        hit = true;
    end

    %midlowbird
    if height == 0  && activerow(1) > 448  && activerow(1) < 495
        if duck == false
            hit = true; 
        end
    else
        
        if height < 70 && activerow(1) < 491 && activerow(1) > 458
            if duck == false
                hit = true; 
            end
        end 
        if height < 57 && activerow(1) < 497 && activerow(1) > 467
            if duck == false
                hit = true;      
            end
        end
        if height < 30 && activerow(1) < 469 && activerow(1) > 448
            if duck == false
                hit = true;
            end
        end
        if height < 17 && activerow(1) < 495 && activerow(1) > 458
            if duck == false    
                hit = true;
            end
        end
    end

    %midhigh bird

    if height > 31 && height < 67 && activerow(1) > 545 && activerow(1) < 576
        hit = true;
    end

    if height > 44 && height < 80 && activerow(1) > 528 && activerow(1) < 552
        hit = true;
    end
    
    if height > 54 && height < 107 && activerow(1) > 555 && activerow(1) < 580
        hit = true;
    end
    
    if height > 67 && height < 120 && activerow(1) > 538 && activerow(1) < 572
        hit = true;
    end

    %smallsingle
    if height < 40 && activerow(1) > 622 && activerow(1) < 640
        hit = true;
    end
    
    %smalldouble
    if height < 23 && activerow(1) > 688 && activerow(1) < 736
        hit = true;
    end
    if height < 62 && activerow(1) > 702 && activerow(1) < 744
        hit = true;
    end

end
