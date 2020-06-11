%Funktion zum Stoppen der Iteration bei einem Fehler kleiner 3 mm / 3°

function [cancel] = ShouldStop(error)
    for i = 1 : 3
        disp(i + ": " + abs(error(i)));
        if abs(error(i)) > 0.003
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