function n_zone = halo_analyse(p_halo,zone_frac,n_pol,n_azim)

zone_half_angle = acos(1-2*zone_frac);      % half-cone angle of zone


%% Calculation of relative number difference

n_zone = zeros(n_pol,n_azim);   % reshaped later to a column vector
for i = 1:n_pol
    z_pol = (i-1)*(pi/(n_pol-1));
    for j = 1:n_azim
        z_azim = (j-1)*(2*pi/n_azim);
        
        % zone-normal vector
        z_norm = zeros(3,1);      % unit norm vector for specifying region
        z_norm(1) = sin(z_pol)*cos(z_azim);
        z_norm(2) = sin(z_pol)*sin(z_azim);
        z_norm(3) = cos(z_pol);
        
        p_proj = z_norm'*p_halo./sqrt(sum(p_halo.^2));  % projection of halo momentum vector onto the normal

        in_region = p_proj>cos(zone_half_angle);
        
        N_zone_temp = sum(in_region);             % number of particles in selected zone
        
        n_zone(i,j) = N_zone_temp;
        
        
%         %% Graphical check: region selection and particle counting
%         % Gather all particles in region
%         p_sel = zeros(3,N_zone_temp);
%         counter = 1;
%         for k = 1:length(in_region)
%             if in_region(k)
%                 p_sel(:,counter) = p_halo(:,k);
%                 counter = counter + 1;
%             end
%         end
%         clear counter;
%         
%         figure(42); hold on;
%         scatter3(p_sel(1,:),p_sel(2,:),p_sel(3,:),2.2,'g','filled');
    end
end
n_zone = reshape(n_zone,n_pol*n_azim,1);




return