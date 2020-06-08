function [cancel] = ShouldStop(error)
    for i = 1 : 3
        disp(i + ": " + abs(error(i)));
        if abs(error(i)) > 3
            cancel = false;
            
            return
        end
    end
    
    for i = 4 : 6
        disp(i + ": " + abs(error(i)));
        if abs(error(i)) > 3/180*pi
            cancel = false;
            
            return
        end
    end
    
    cancel = true;
end