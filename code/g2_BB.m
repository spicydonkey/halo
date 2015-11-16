%% Back-to-Back momentum correlation function, g(2)(V_sum)
% Evaluate the 3D second order BB momentum correlation function of s-wave
% scattered halo
% DK Shin
% 16.11.2015


%% G2 momentum correlation function
P_PAIR_SUM = cell(N_sim,1);
for i = 1:N_sim
    P_PAIR_SUM{i} = pairsum(P_HALO{i});
end

%% Normalisation
% collate all halo
P_HALO_NORM = zeros(3,N_sim*2*N_pair);
for i = 1:N_sim
    P_HALO_NORM(:,(i-1)*N_halo+1:i*N_halo);
end

P_PAIR_NORM = pairsum(P_HALO_NORM);

%P_sum_mag = sqrt(sum(P_sum.^2,1));  % magnitude of normed pairwise sum momenta