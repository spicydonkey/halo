%% Back-to-Back momentum correlation function, g(2)(V_sum)
% Evaluate the 3D second order BB momentum correlation function of s-wave
% scattered halo
% DK Shin
% 16.11.2015


%% G2 momentum correlation function
P_BB = cell(N_sim,1);
for i = 1:N_sim
    P_BB{i} = pairsum(P_HALO{i});
end

P_BB_all = [];
for i = 1:N_sim
    P_BB_all = [P_BB_all P_BB{i}];
end


%% Normalisation
% collate all halo
P_HALO_all = zeros(3,N_sim*N_halo);
for i = 1:N_sim
    P_HALO_all(:,(i-1)*N_halo+1:i*N_halo)=P_HALO{i};
end

P_BB_norm = pairsum(P_HALO_all);


