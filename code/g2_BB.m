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


%% Filtering and projection
deltaP = 5*(prod(P_dist{1}{2}))^(1/3)/P_norm;     % momentum filtering radius
is_Pcorr = sqrt(sum(P_BB_all.^2,1))<deltaP;     % boolean array to select momentum pairs within BB region

P_BB_filt = zeros(3,sum(is_Pcorr));
counter=1;
for i=1:length(is_Pcorr)
    if is_Pcorr(i)
        P_BB_filt(:,counter) = P_BB_all(:,i);
        counter = counter + 1;
    end
end

is_Pcorr_all = sqrt(sum(P_BB_norm.^2,1))<deltaP;
P_BB_norm_filt = zeros(3,sum(is_Pcorr_all));
counter=1;
for i=1:length(is_Pcorr_all)
    if is_Pcorr_all(i)
        P_BB_norm_filt(:,counter) = P_BB_norm(:,i);
        counter = counter + 1;
    end
end