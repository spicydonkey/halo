%% Back-to-Back momentum correlation function, g(2)(V_sum)
% Evaluate the 3D second order BB momentum correlation function of s-wave
% scattered halo
% DK Shin
% 16.11.2015


%% g2 parameters
p_delta = 0.2;      % scaled p-ball radius for g2 correlation evaluation


%% G2 momentum correlation function
P_BB = cell(N_sim,1);
for i = 1:N_sim
    P_BB{i} = pairsum(P_HALO{i},p_delta);
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

P_BB_norm = pairsum(P_HALO_all,p_delta);


%% Histogramming
G2 = cell(3,1);
bin = cell(3,1);
G2norm = cell(3,1);
g2 = cell(3,1);

figure();
colors = 'rgb';
for i=1:3
    [G2{i}, bin{i}] = hist(P_BB_all(i,:),50);
    G2norm{i} = hist(P_BB_norm(i,:),bin{i});
    
    g2{i} = N_sim*G2{i}./G2norm{i};
    plot(bin{i},g2{i},colors(i)); hold on;
end
grid on;