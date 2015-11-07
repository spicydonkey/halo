%% Gas collision simulation
% A classical simulation of the evolution of the momentum distribution of
% gas by two-particle collisions
% DK Shin
% 07.11.15

close all; clear all;

%% Simulation parameters
% momentum distribution parameters (NORMAL distribution)
mean = [0;0;0];
dev = [1;1;10];

n_pair = 5000;   % sample number (number of pairs for TBC)

%% Simulation
% create sample from momentum distribution and output histogram
momentum = cell(2,1);
figure();
for i=1:2
    for j=1:3
        momentum{i}(j,:) = random('norm',mean(j),dev(j),[1,n_pair]);
        subplot(2,3,(i-1)*3+j); hist(momentum{i}(j,:));
    end
end

% two-body collision: s-wave scattering
p_centre = (momentum{1}+momentum{2})/2;     % collision centre frame

p_0 = momentum{1}-p_centre;     % momentum in centre frame
p_0_abs = zeros(1,n_pair);      % magnitude of momentum in com (one of pair)
for i=1:n_pair
    p_0_abs(i) = norm(p_0(:,i));
end

scat_angle(1,:) = 2*pi*rand([1,n_pair]);  % polar scattering angle
scat_angle(2,:) = pi*rand([1,n_pair]);    % azimutal scattering angle

p_0_scat = zeros(3,n_pair);         % scattered momenta in com
p_0_scat(1,:) = p_0_abs.*sin(scat_angle(1,:)).*cos(scat_angle(2,:));
p_0_scat(2,:) = p_0_abs.*sin(scat_angle(1,:)).*sin(scat_angle(2,:));
p_0_scat(3,:) = p_0_abs.*cos(scat_angle(1,:));

p_scat = cell(2,1);
p_scat{1} = p_0_scat + p_centre;    % tranform scattered momentum back to the original reference frame
p_scat{2} = -p_0_scat + p_centre;   % the collision partner

%% Graphical output
% Scattered momentum distribution
figure();
for i=1:2
    for j=1:3
    subplot(2,3,(i-1)*3+j); hist(p_scat{i}(j,:));
    end
end

% scatter plot
figure();
for i = 1:2
    scatter3(momentum{i}(1,:),momentum{i}(2,:),momentum{i}(3,:),0.1,'b'); hold on;
end

for i = 1:2
    scatter3(p_scat{i}(1,:),p_scat{i}(2,:),p_scat{i}(3,:),0.1,'r'); hold on;
end