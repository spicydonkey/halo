function n_zone = spherePartition(vectors,zone_frac,n_pol,n_azim)
% Bin vectors into spherically partitioned zones

zone_half_angle = acos(1-2*zone_frac);      % half-cone angle of zone


%% Calculation of relative number difference

n_zone = zeros(n_pol,n_azim);       % reshaped later to a column vector
z_pol = linspace(0,pi,n_pol);
z_azim = linspace(0,2*pi,n_azim);

for i = 1:n_pol
    for j = 1:n_azim        
        % get this zone's normal vector
        z_norm = zeros(3,1);      % unit norm vector for specifying region
        z_norm(1) = sin(z_pol(i))*cos(z_azim(j));
        z_norm(2) = sin(z_pol(i))*sin(z_azim(j));
        z_norm(3) = cos(z_pol(i));
        
        V_proj = z_norm'*vectors./sqrt(sum(vectors.^2));  % normed projection of vector onto the zone normal
        
        in_region = V_proj>cos(zone_half_angle);    % mark vectors lying in a cone around the normal
        N_zone_temp = sum(in_region);               % number of vectors in this zone
        n_zone(i,j) = N_zone_temp;
    end
end
n_zone = reshape(n_zone,n_pol*n_azim,1);

return