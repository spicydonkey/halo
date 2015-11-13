%% Momentum squeezing in a simple halo
% Analyse a momentum distribution for momentum squeezing - for halo data
% DK Shin
% 09.11.15


%% Parameters
int_frac = 1e-4;                    % fraction of total halo to perform integration
half_angle = acos(1-2*int_frac);    % half-cone angle


%% Calculation of relative number difference
% reference z-axis region
temp_azi = 0;
temp_pol = 0;

v_norm = zeros(3,1);      % unit norm vector for specifying region
v_norm(1) = sin(temp_pol)*cos(temp_azi);      
v_norm(2) = sin(temp_pol)*sin(temp_azi);
v_norm(3) = cos(temp_pol);

p_proj = v_norm'*p_halo./sqrt(sum(p_halo.^2));  % projection of halo momentum vector onto the normal
in_region = p_proj>cos(half_angle);

N_ref = sum(in_region);             % number of particles in ref region

% comparison region
N_rep = 1000;
data_sqz = zeros(3,N_rep);
for i = 1:N_rep
    if i==1
        % reference region
        temp_pol = 0;
        temp_azi = 0;
    elseif i==2
        % directly opposite region
        temp_pol = pi;
        temp_azi = 0;
    else
        % randomise others
        temp_pol = acos(2*rand()-1);
        temp_azi = 2*pi*rand();
    end
    
    v_norm = zeros(3,1);      % unit norm vector for specifying region
    v_norm(1) = sin(temp_pol)*cos(temp_azi);
    v_norm(2) = sin(temp_pol)*sin(temp_azi);
    v_norm(3) = cos(temp_pol);
    
    p_proj = v_norm'*p_halo./sqrt(sum(p_halo.^2));  % projection of halo momentum vector onto the normal
    %p_proj_sort = sort(p_proj);                     % could be useful
    in_region = p_proj>cos(half_angle);
    
    N = sum(in_region);             % number of particles in selected region
    N_diff = N - N_ref;
    
    data_sqz(:,i) = [temp_pol;temp_azi;N_diff];
end

data_sqz_sort = sortrows(data_sqz')';

% Output plot of squeezing
figure(); plot(data_sqz_sort(1,:),data_sqz_sort(3,:));
grid on;
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi'});

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