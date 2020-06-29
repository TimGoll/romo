%Generiert eine zufällige Zahl zwischen mmin und max

function [random]=RandRange(min, max)

random = min + rand(1)*(max-min);

end