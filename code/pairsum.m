function deltaP = pairsum(P_vect, p_delta)

N_p = size(P_vect,2);   % number of particles in momentum space

deltaP = [];
for i=1:N_p
    P_temp = P_vect(:,i+1:end) + P_vect(:,i)*ones(1,N_p-i);     % pair-wise sum
    P_temp = ballfilter(P_temp, p_delta);   % momentum pair filtering 
    deltaP = [deltaP P_temp];   % keep correlations in specified volume
end

return