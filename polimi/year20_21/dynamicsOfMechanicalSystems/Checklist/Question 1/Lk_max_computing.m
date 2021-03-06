clear all
close all
clc

% Beam's type linear mass and bending stiffness
% Red beams
m1 = 312;
EJ1 = 1.40e9;
% Green beams
m2 = 200;
EJ2 = 4.5e8;
% Blue beams
m3 = 90;
EJ3 = 2.0e8;

% Lk_max computing
sc = 2; % safe coefficient
omegaMax = 10;
omegaMax_rad = 2*pi*omegaMax;

Lk_max_red = computeLkMax(sc,omegaMax_rad,EJ1,m1)
Lk_max_green = computeLkMax(sc,omegaMax_rad,EJ2,m2)
Lk_max_blue = computeLkMax(sc,omegaMax_rad,EJ3,m3)

% Lk_max computing function
function Lk_max = computeLkMax(sc,omegaMax_rad,EJk,mk)
Lk_max = (pi*(EJk/mk)^(1/4))/sqrt(sc*omegaMax_rad);
end



