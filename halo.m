%% Halo: Simulation and data analysis for observing squeezing
% Analyse the number differences (momentum-corr pairs) in the simulation of the scattered halo from a collision of two BECs
% DK Shin
% 10.11.15


%% Parameters
% Statistics
N_sim;      % number of simulations

% Halo simulation
% parameters for halo momentum distribution
% number of collision pairs (can improve by uncertainties and detector qe,
% etc)

% Data analysis
ZONE_F;     % fraction of halo to perform num diff analysis
% number of "polar" and "azimutal" zones (EVEN numbers to update later)
N_POLAR;
N_AZIM;


%% Simulation
for i_sim = 1:N_sim
    % run halo simulation
    
    % find number differences vs. theta,phi in this simulation
    
    % collate result
end


%% Data analysis
% Calculate normalised number difference variance between zones


%% Graphical output
% Plot V(theta,phi)