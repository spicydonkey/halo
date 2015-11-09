%% Gas collision simulation
% A classical simulation of the evolution of the momentum distribution of
% gas by two-particle collisions
% DK Shin
% 07.11.15

close all; clear variables;

%% Simulation parameters
% momentum distribution parameters (NORMAL distribution)
mean{1} = [1;0;0];
stddev{1} = [0.1;0.1;0.1];
%mean{2} = [-3;0;0];
mean{2} = -mean{1};     % fix global origin as centre of motion for the system
stddev{2} = [0.1;0.1;0.1];

n_pair = 10000;   % sample number (number of pairs for TBC)

%% Simulation
% create sample from momentum distribution and output histogram
p_in = cell(2,1);
figure();
for i=1:2
    for j=1:3
        p_in{i}(j,:) = random('norm',mean{i}(j),stddev{i}(j),[1,n_pair]);
        subplot(2,3,(i-1)*3+j); hist(p_in{i}(j,:),30);
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

%% Graphical output
% Scattered momentum distribution
figure();
for i=1:2
    for j=1:3
        subplot(2,3,(i-1)*3+j); hist(p_out{i}(j,:),30);
    end
end

% scatter plot
figure();
for i = 1:2
    scatter3(p_in{i}(1,:),p_in{i}(2,:),p_in{i}(3,:),2,'b','filled'); hold on;
end

for i = 1:2
    scatter3(p_out{i}(1,:),p_out{i}(2,:),p_out{i}(3,:),2,'r','filled'); hold on; axis equal;
end