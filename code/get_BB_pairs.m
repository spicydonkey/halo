%% Evaluate all atom-pairs for back-to-back scattering
% Get all back-to-back momentum pairs for evaluating the second order
% correlation function avoiding self and repeated comparisons
% DK Shin
% 16.11.2015


%% Back-to-back cut-off
p_delta = 0.2;      % scaled p-ball radius for g2 correlation evaluation
%p_delta = 5*w_halo;     % since g2 correlation length would be dependent
%on the halo thickness


%% Correlation pairs in a "single" experiment
Psum_BB_singleshot = cell(N_sim,1);
Psum_BB_singleshot_collate = [];          % container for collating all BB pairs
for i = 1:N_sim
    Psum_BB_singleshot{i} = pairsum(P_HALO{i},p_delta);   % gets all atom-pairs in each halo within certain specified BB range
    Psum_BB_singleshot_collate = [Psum_BB_singleshot_collate Psum_BB_singleshot{i}];  % collate
end


%% Normalising pairs - correlations across "all" experiments
% WARNING: quadratic dependence on N_sim*N_halo: memory and time intensive
Psum_BB_allshot = pairsum(P_HALO_all,p_delta);    % all atom-pairs across all halos for normalisation