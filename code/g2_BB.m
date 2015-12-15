%% Back-to-Back momentum correlation function, g(2)(V_sum)
% Evaluate the 3D second order BB momentum correlation function of s-wave
% scattered halo
% DK Shin
% 16.11.2015


%% g2 parameters
p_delta = 0.2;      % scaled p-ball radius for g2 correlation evaluation
%p_delta = 5*w_halo;     % since g2 correlation length would be dependent
%on the halo thickness

%% G2 momentum correlation function
P_BB = cell(N_sim,1);
P_BB_all = [];          % container for collating all BB pairs
for i = 1:N_sim
    P_BB{i} = pairsum(P_HALO{i},p_delta);   % gets all atom-pairs in each halo within certain specified BB range
    P_BB_all = [P_BB_all P_BB{i}];          % collate
end


%% Normalisation
% WARNING: quadratic dependence on N_sim*N_halo: memory and time intensive
P_BB_norm = pairsum(P_HALO_all,p_delta);    % all atom-pairs across all halos for normalisation