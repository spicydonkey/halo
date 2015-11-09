%% Momentum squeezing in a simple halo
% Analyse a momentum distribution for momentum squeezing - for halo data
% DK Shin
% 09.11.15


%% Parameters
half_angle = pi/10;     % half-cone angle for integration


%% Calculation of relative number difference
% comparison region
temp_azi = 2*pi*rand();
temp_pol = acos(2*rand()-1);

v_norm = zeros(3,1);      % unit norm vector for specifying region
v_norm(1) = sin(temp_pol)*cos(temp_azi);      
v_norm(2) = sin(temp_pol)*sin(temp_azi);
v_norm(3) = sqrt(1-v_norm(1)^2-v_norm(2)^2);

p_proj = v_norm'*p_halo./sqrt(sum(p_halo.^2));  % projection of halo momentum vector onto the normal
%p_proj_sort = sort(p_proj);                     % could be useful
in_region = p_proj>cos(half_angle);

N = sum(in_region);             % number of particles in selected region


% %% Graphical check: region selection and particle counting
% % Gather all particles in region
% p_sel = zeros(3,N);
% counter = 1;
% for i = 1:length(in_region) 
%     if in_region(i)
%         p_sel(:,counter) = p_halo(:,i);
%         counter = counter + 1;
%     end
% end
% clear counter;
% 
% figure(3); hold on;
% scatter3(p_sel(1,:),p_sel(2,:),p_sel(3,:),2.2,'g','filled');