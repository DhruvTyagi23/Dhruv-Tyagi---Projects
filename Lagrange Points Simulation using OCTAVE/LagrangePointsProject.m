% LagrangePointsProject.m
%
% Dhruv Tyagi 2K19/EP/032
%
% Plots Lagrange points and contour lines of Surface potential that pass through them
% for the circular, restricted 3-body problem. 
%
% Assumes G = 1 and R = 1, where R  is the distance between masses m1 & m2.
% The origin of the coordinate system is placed at the center-of-mass point
%
% Function Files used:
%    SurfPotential.m - returns pseudo-potential (SOURCE: https://www.matlab-monkey.com/celestialMechanics/CRTBP/LagrangePoints/crtbpPotential.m)
%    lagrangePoints.m - returns 5x3 array containing (x,y,z) coordinates
%                       of the Lagrange points for given values of m1, m2
%

clc;
clear all;

% Parameters and Initialization  %

M1 = 1;      % mass 1
M2 = 0.1;    % mass 2
M = M1 + M2; % total mass
mu = M2/(M1+M2) % define mass ratio parameter 'mu'

% finding Lagrange points %

LP = lagrangePoints(mu)

% Parameters Required to plot lines of Equi-potential  %

R = 1;       % distance between M1 and M2 set to 1
G = 1;       % Gravitational Constant set to 1
mu = G*M;
mu1 = G*M1;
mu2 = G*M2;
[X,Y] = meshgrid(-2:0.01:2);
U = SurfPotential(mu1, mu2, X, Y);

%P = 2*pi * sqrt(R^3 / mu);  % period from Kepler's 3rd law
%omega0 = 2*pi/P;            % angular velocity of massive bodies

% finding Pseudo-potentials %

LP1_level = SurfPotential(mu1, mu2, LP(1,1), LP(1,2));
LP2_level = SurfPotential(mu1, mu2, LP(2,1), LP(2,2));
LP3_level = SurfPotential(mu1, mu2, LP(3,1), LP(3,2));
qkq = SurfPotential(mu1, mu2, -0.43, 0)
% Plotting  %

% plotting zero-velocity curves that run through L1, L2, L3
contour(X,Y,U,[LP1_level LP2_level LP3_level -3.767 -2.3453 -0.3322 -0.7886 -0.5546 -4.1121 -1.5471 -2.55]) % -3.767 -2.3453 -4.1121 -1.5471 -2.55 %  -0.3322 -0.7886 -0.5546
hold on
grid on

% plotting bodies M1 & M2
plot(-M2/(M1+M2),0,'ko','MarkerSize',14,'MarkerFaceColor','y')
plot(M1/(M1+M2),0,'ko','MarkerSize',5,'MarkerFaceColor','b')

% plotting Lagrange points and labels
plot(LP(:,1),LP(:,2),'k+')
labels = {'L1', 'L2', 'L3', 'L4', 'L5'}
text(LP(:,1)-.2,LP(:,2),labels)

% plotting title, limits, etc.
title(sprintf('Lagrange Points for 2 bodies of masses, m_1 = %.2f & m_2 = %.2f',M1, M2), "fontsize", 15);
xlabel('x axis', "fontsize", 14)
ylabel('y axis', "fontsize", 14)
axis square
axis equal
xlim([-1.8 1.8])
ylim([-1.8 1.8])

