function P_pairsum = pairsum(P_particles)

N_p = size(P_particles,2);  % number of particles in momentum space

P_pairsum = zeros(3,N_p*(N_p-1)/2);     % preallocate size of array storing pair sum

i_cat = 1;      % index at start of list comprehension
for i=1:N_p
    P_pairsum(:,i_cat:(i_cat+(N_p-i)-1)) = P_particles(:,i+1:end)-P_particles(:,i)*ones(1,N_p-i);
    i_cat = i_cat + N_p - i;    % update index location
end

return