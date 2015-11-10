%% Halo: Simulation and data analysis for observing squeezing
% Analyse the number differences (momentum-corr pairs) in the simulation of the scattered halo from a collision of two BECs
% DK Shin
% 10.11.15


close all; clear all;


%% Parameters
N_sim=1000;      % number of simulations

% Halo simulation
% bec momentum distribution (GAUSSIAN)
P_dist{1}{1} = [1;0;0];         % BEC1 mean momentum
P_dist{1}{2} = [0.1;0.1;0.1];   % BEC1 momentum std
P_dist{2}{1} = -P_dist{1}{1};   % BEC2 mean momentum (experimentally fix global origin as centre of motion)
P_dist{2}{2} = [0.1;0.1;0.1];   % BEC2 momentum std

% number of collision pairs (can improve by uncertainties and detector qe,
% etc)
N_pair=1000;

% Data analysis
zone_frac=1e-2;      % fraction of halo to perform num diff analysis
% number of "polar" and "azimutal" zones (must be EVEN to update later)
Nz_polar=11;
Nz_azim=4;


%% Simulation
N_zone = zeros(Nz_polar*Nz_azim,N_sim);
for i_sim = 1:N_sim
    close all;
    % run halo simulation
    P_halo = halo_sim(P_dist,N_pair);
    
    % find number vs. theta,phi in this simulation
    % AND collate result in N_zone
    N_zone(:,i_sim) = halo_analyse(P_halo,zone_frac,Nz_polar,Nz_azim);
end


%% Data analysis
% Calculate normalised number difference variance between zones
N_diff = N_zone - ones(size(N_zone,1),1)*N_zone(1,:);
V_ndiff = ( mean(N_diff.^2,2) - mean(N_diff,2).^2 )./( mean(N_zone(1,:)) + mean(N_zone,2) );

V_ndiff = reshape(V_ndiff,Nz_polar,Nz_azim);


%% Graphical output
% Plot V(theta,phi)
theta = linspace(0,pi,Nz_polar);
phi = linspace(0,2*pi,Nz_azim+1);
phi = phi(1:Nz_azim);

surf(theta,phi,V_ndiff);