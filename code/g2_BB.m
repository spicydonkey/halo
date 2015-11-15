%% Back-to-Back momentum correlation function, g(2)(V_sum)
% Evaluate the 3D second order BB momentum correlation function of s-wave
% scattered halo
% DK Shin
% 16.11.2015


% Pair-wise momentum sum
N_p = size(P_halo,2);   % number of particles detected in momentum space

P_sum = zeros(3,N_p*(N_p-1)/2);     % preallocate size of array storing pair sum

i_cat = 1;      % index at start of list comprehension
for i=1:N_p
    P_sum(:,i_cat:(i_cat+(N_p-i)-1)) = P_halo(:,i+1:end)-P_halo(:,i)*ones(1,N_p-i);
    i_cat = i_cat + N_p - i;    % update index location
end

P_sum_mag = sqrt(sum(P_sum.^2,1));  % magnitude of normed pairwise sum momenta