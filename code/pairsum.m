function deltaP_bb = pairsum(P_vect, p_delta)

N_p = size(P_vect,2);   % number of particles in momentum space

%%%%%%%%%%% MEMORY PROBLEM
P_temp = zeros(3,N_p*(N_p-1)/2);    % preallocate size of array storing pair sum

i_cat = 1;      % index for list comprehension
for i=1:N_p
    P_temp(:,i_cat:(i_cat+(N_p-i)-1)) = P_vect(:,(i+1):end)+P_vect(:,i)*ones(1,N_p-i);
    i_cat = i_cat + N_p - i;    % update index location
end
%%%%%%%%%%%%

in_delta = sqrt(sum(P_temp.^2,1))<p_delta;  % elements within correlation region of interest

N = sum(in_delta);      % number of p vectors within corr region of interest
deltaP_bb = zeros(3,N);

% filter out widely separated pairwise correlations
counter = 1;
for i=1:size(P_temp,2)
    if in_delta(i)
        deltaP_bb(:,counter) = P_temp(:,i);
        counter = counter + 1;
    end
end

return