% SurfPotential.m
%
% Calculates the potential for the circular, restricted 3-body problem evaluated in
% the rotating reference frame tied to m1 & m2
% Assumes G = 1 and R = 1, where R  is the distance between masses m1 & m2
% The origin of the coordinate system is placed at the center of mass point
%
% passed parameters:
% m1 = mass of object 1 (typically set m1 + m2 = 1)
% m2 = mass of object 2
% (x, y) = coordinates of position to evaluate potential. x and y may be
% single values, or arrays.
%
% returned value = gravitational-potential at position (x,y)
% if x & y are arrays, SurfPotential will return an array
%
%

function U = SurfPotential(m1, m2, x, y)

    
    omega = sqrt(m1+m2);            % angular velocity of massive bodies

    x1 = -m2/(m1+m2);               % x coordinate of m1
    x2 = 1 + x1;                    % x coordinate of m2

    r1 = sqrt((x-x1).^2+y.^2);      % distance from m1 to (x,y)
    r2 = sqrt((x-x2).^2+y.^2);      % distance from m2 to (x,y)

    U = -omega^2/2*(x.^2+y.^2) - m1./r1 - m2./r2;
   
    
end

