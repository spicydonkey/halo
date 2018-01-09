function n_rings = halo_dld_ringing(k,v_collision)
% n_rings = halo_dld_ringing(k_halo)
%
% Evaluates number of false counts caused by detector ringing in halo
%
% k_halo: atoms in K-space (halo radius normalised)
% v_collision: *full* collision velocity [m/s] (default is 120mm/s == 25mm radius halo)

if ~exist('v_collision','var')
    v_collision = 0.120;    % NOTE: an approximate for ±45deg beam geom
end

%% reconstruct counts in TXY units
% k --> v: velocity-space
v = cellfun(@(K) K*v_collision/2,k,'UniformOutput',false);
% v --> r: real space
tof = 0.416;    % atom time-of-flight to detector [s]
r = cellfun(@(V) V*tof,v,'UniformOutput',false);
% r --> txy: dld units [(s,m,m)]
vz = 9.81*tof;  % atom z-velocity when landing on detector
txy = cellfun(@(R) R.*[1/vz,1,1],r,'UniformOutput',false);

%% evaluate detector ringing events
dead_time = 300e-9;     % default 100ns deadtime on TDC
dead_xy = 3e-3;         %

n_rings = zeros(size(txy));
for ii = 1:2
    [~,b_ring] = postfilter_dld_ring(txy(:,ii),dead_time,dead_xy);      % check for ringing
    n_rings(:,ii) = cellfun(@(b) sum(b),b_ring);
end

end