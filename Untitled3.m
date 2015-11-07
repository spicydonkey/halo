clear all; close all;

n_pair=10000;
R = 1;  % radius of sphere

scat_angle(1,:) = pi*rand([1,n_pair]);      % polar scattering angle
scat_angle(2,:) = 2*pi*rand([1,n_pair]);    % azimutal scattering angle

p_0_scat = zeros(3,n_pair);         % scattered momenta in com
p_0_scat(1,:) = R.*sin(scat_angle(1,:)).*cos(scat_angle(2,:));
p_0_scat(2,:) = R.*sin(scat_angle(1,:)).*sin(scat_angle(2,:));
p_0_scat(3,:) = R.*cos(scat_angle(1,:));

figure();
scatter3(p_0_scat(1,:),p_0_scat(2,:),p_0_scat(3,:));

figure();
for i=1:3
    subplot(1,3,i);
    hist(p_0_scat(i,:));
end