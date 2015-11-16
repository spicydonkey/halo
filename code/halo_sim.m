function [p_halo, p_in] = halo_sim(p_dist, n_halo ,q_eff)

%% Quantum efficiency - random selection
% build boolean array for predicting atom detection for constant halo
% number
is_detected = [];
while sum(sum(is_detected))<n_halo
    is_detected = [is_detected (rand(2,1)<q_eff)];
end
if sum(sum(is_detected))>n_halo
    is_detected(2,end)=0;
end
n_pair = size(is_detected,2);   % number of pairs to collide in simulation

%% Simulation
% create sample from momentum distribution and output histogram
p_in = cell(2,1);

for i=1:2
    for j=1:3
        p_in{i}(j,:) = random('norm',p_dist{i}{1}(j),p_dist{i}{2}(j),[1,n_pair]);
    end
end

% two-body collision: s-wave scattering
P_com = (p_in{1}+p_in{2})/2;    % collision centre frame

p_0 = p_in{1}-P_com;            % momentum of particle-1 in centre frame (pair momentum 0)
p_0_abs = zeros(1,n_pair);      % magnitude of colliding momentum in com
for i=1:n_pair
    p_0_abs(i) = norm(p_0(:,i));
end

scat_angle(1,:) = acos(2*rand([1,n_pair])-1);   % polar scattering angle for spherically uniform distribution
scat_angle(2,:) = 2*pi*rand([1,n_pair]);        % azimutal scattering angle

p_0_scat = zeros(3,n_pair);         % scattered momenta in com
p_0_scat(1,:) = p_0_abs.*sin(scat_angle(1,:)).*cos(scat_angle(2,:));
p_0_scat(2,:) = p_0_abs.*sin(scat_angle(1,:)).*sin(scat_angle(2,:));
p_0_scat(3,:) = p_0_abs.*cos(scat_angle(1,:));

p_out = cell(2,1);
p_out{1} = p_0_scat + P_com;        % tranform scattered momentum back to the original reference frame
p_out{2} = -p_0_scat + P_com;       % the collision partner

% build detected halo from RNG quantum detection
p_halo = zeros(3,n_halo);
counter = 1;
for i=1:2
    for j=1:n_pair
        if(is_detected(i,j))
            p_halo(:,counter) = p_out{i}(:,j);
            counter = counter + 1;
        end
    end
end

return