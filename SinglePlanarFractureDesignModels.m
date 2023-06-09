%%% Auth: Arian Velayati, PhD
... This script can be used to design single plane fracture
... using PKN and KGD models - Pseudo-2D geometric models

clc;close all; clear;

%% PKN
% Good for long fracture (xf>hf) --> well defined bottom and top barriers
% Assumptions:
... Plane-strain fracture deformation in a vertical plane
... perpendicular to the direction of fraction propagation 
... Linear isotropic elasticity, negligible ffracture toughness, and laminar flow
% Simple analytical solution assuming qinj = cte and no leak-off

% Inputs
i = 25; % injection rate (bbl/min)
Ep = 8.9e6; % Plane strain modulus (psi)
vis = 1; % Fluid viscosity (cp)
hf = 100; % Fracture height (ft)
t = 30; % Time into fracturing (min)
Prop_vol = 0.2; % volumetric percent of proppant in fracturing fluid recipe

% Unit conversions
i = i*0.0026; % m3/s (one-wing)
Ep = Ep*6894.75729; % Pa
vis = vis*0.001; % Pa.s
hf = hf*0.3048; % m 
t = t*60; % s

%%% Calculations and outputs
% Fracture half-length; m
xf = 0.524*((i^3*Ep)/(vis*hf^4))^(1/5) * t^(4/5);

% Maximum width at the wellbore; m
wo = 3.040 * ((i^2*vis)/(Ep*hf))^(1/5) * t^(1/5);

% Net pressure at the wellbore; Pa
pnetw = 1.520* ((Ep^4*i^2*vis)/(hf^6))^(1/5) * t^(1/5);

% Volume of fracture with time (2-wing); m3
Vfrac = 2*(pi/5) * wo * hf * xf;

% Require proppant and fracking fluid volume; m3
Prop =  Prop_vol * Vfrac;
Fluid = (1-Prop_vol) * Vfrac;

% Table of results
 T = table(xf,wo,pnetw,Vfrac, Prop, Fluid, 'VariableNames',{'length_m','width_m','netpressure_Pa','Volume_m3', 'Prop_m3','Fluid_m3'})
  
    writetable(T,'PKN_Design.csv')
%% KGD Model
% Good for short fracture (xf<hf) --> Fractures in leak off tests or
% frac-pack completions
% Assumptions:
... Plane-strain fracture deformation in a horizontal plane
... Linear isotropic elasticity, negligible fracture toughness, and laminar flow
% Simple analytical solution assuming qinj = cte and no leak-off
% Fracture half-length; m
xf2 = 0.539*((i^3*Ep)/(vis*hf^3))^(1/5) * t^(2/3);

% Maximum width at the wellbore; m
wo2 = 2.360 * ((i^3*vis)/(Ep*hf^3))^(1/6) * t^(1/3);

% Net pressure at the wellbore; Pa
pnetw2 = 1.090 * ((Ep^2*vis))^(1/3) * t^(-1/3);

% Volume of fracture with time (2-wing); m3
Vfrac2 = 2 * wo * hf * xf;

% Require proppant and fracking fluid volume; m3
Prop2 =  Prop_vol * Vfrac2;
Fluid2 = (1-Prop_vol) * Vfrac2;

% Table of results
 T2 = table(xf2,wo2,pnetw2,Vfrac2, Prop2, Fluid2, 'VariableNames',{'length_m','width_m','netpressure_Pa','Volume_m3', 'Prop_m3','Fluid_m3'})
  
    writetable(T,'KGD_Design.csv')
    
