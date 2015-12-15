%% Run Halo simulation
% 18.11.2015
% DK Shin

clear all; close all;

tic;    % begin timestamp

sim_config;
halo;
get_BB_pairs;
g2_histo;
g2_gauss_fit;

toc;    % end timestamp