%% Halo: Simulation and data analysis for observing squeezing
% Analyse the number differences (momentum-corr pairs) in the simulation of the scattered halo from a collision of two BECs
% DK Shin
% 10.11.15


close all; clear all;


%% Parameters
N_sim=5;      % number of simulations

% Halo simulation
% bec momentum distribution (GAUSSIAN)
P_dist{1}{1} = [1;0;0];         % BEC1 mean momentum
P_dist{1}{2} = [0.1;0.1;0.1];   % BEC1 momentum std
P_dist{2}{1} = -P_dist{1}{1};   % BEC2 mean momentum (experimentally fix global origin as centre of motion)
P_dist{2}{2} = [0.1;0.1;0.1];   % BEC2 momentum std

% number of collision pairs (can improve by uncertainties and detector qe,
% etc)
N_pair=10000;

% Data analysis
zone_frac=1e-2;      % fraction of halo to perform num diff analysis
% number of "polar" and "azimutal" zones (must be EVEN to update later)
Nz_polar=3;
Nz_azim=4;


%% Simulation
N_diff = zeros(Nz_polar*Nz_azim,N_sim);
for i_sim = 1:N_sim
    close all;
    % run halo simulation
    P_halo = halo_sim(P_dist,N_pair);
    
    % find number differences vs. theta,phi in this simulation
    
    % collate result in N_diff
end


%% Data analysis
% Calculate normalised number difference variance between zones


%% Graphical output
% Plot V(theta,phi)