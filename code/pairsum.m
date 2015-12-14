function deltaP = pairsum(P_vect, p_delta)


N_p = size(P_vect,2);   % number of particles in momentum space

N = 0;
P_corr = cell(N_p,1);
for i=1:N_p
    P_temp = P_vect(:,i+1:end) + P_vect(:,i)*ones(1,N_p-i);     % pair-wise sum
    P_temp = ballfilter(P_temp, p_delta);   % momentum pair filtering 
    P_corr{i} = P_temp;   % keep correlations in specified volume
    N = N + size(P_temp,2);
    if mod(i,round(N_p/100))==0
        disp([num2str(round(i/round(N_p/100))) '%']);
    end
end

deltaP = zeros(3,N);
index = 1;
for i=1:N_p
    deltaP(:,index:(index+size(P_corr{i},2)-1)) = P_corr{i};
    index = index+size(P_corr{i},2);
end

return