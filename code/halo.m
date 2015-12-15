%% Halo simulation
% Simulate the collision of two BECs and scattering halo
% DK Shin
% 10.11.15

%% Calculation of T-F momentum wavefunction
% Pre-collision BEC momentum distribution is calculated from T-F approximation: requires population and mean momentum of colliding condensates, and trap frequency
w_trap = 2*pi*f_trap;       % trap frequencies in rad/s
w_trap_bar = prod(w_trap)^(1/3);    % mean trap frequency
a_bar = sqrt(hbar/(m_He*w_trap_bar));       % mean characteristic length of trap
mu = 1/2*hbar*w_trap_bar*(15*N_0*a_He/a_bar)^0.4;  % chemical potential of BEC

R_bec = sqrt(2*mu/m_He)./w_trap;    % Thomas-Fermi radii

% Momentum spread of colliding condensates
w_P_bec = hbar*(1.99./R_bec);   % HWHM width of TF condensate momentum distribution (analytic)
for i=1:2
    P_dist{i}{2} = w_P_bec/sqrt(2*log(2));  % convert HWHM to stddev - Gaussian approximation
end


%% Collision simulation
N_zone = zeros(Nz_polar*Nz_azim,N_sim);
P_HALO = cell(N_sim,1);     % scattering halo data saved separately for each shot
P_source = cell(2,1);       % randomly sampled colliders from source condensates

for i = 1:N_sim
    % run halo simulation
    [P_halo, P_in] = halo_sim(P_dist,N_halo,QE);
    
    % Normalise momenta to recoil/collision momentum
    for j=1:length(P_in)
        P_in{j} = P_in{j}/P_norm;
    end
    P_halo = P_halo/P_norm;
    
    % sort and bin scattered atoms into spherical partition zones for
    % number squeezing analysis
    N_zone(:,i) = spherePartition(P_halo,zone_frac,Nz_polar,Nz_azim);
    
    % save collision simulation
    P_HALO{i} = P_halo;
    for k=1:2
        P_source{k} = [P_source{k} P_in{k}];
    end
end
    
% collate all halo
P_HALO_all = zeros(3,N_sim*N_halo);
for i = 1:N_sim
    P_HALO_all(:,(i-1)*N_halo+1:i*N_halo)=P_HALO{i};
end


%% Number difference
% Calculate normalised number difference variance between zones
N_diff = N_zone - ones(size(N_zone,1),1)*N_zone(1,:);

V_ndiff = ( mean(N_diff.^2,2) - mean(N_diff,2).^2 )./( mean(N_zone(1,:)) + mean(N_zone,2) );    % formula for normalsed number difference variance
V_ndiff = reshape(V_ndiff,Nz_polar,Nz_azim);        % reshape array for surface plot


%% Number difference squeezing visualisation
% Plot the dependence of the variance of number difference on location of zones
theta = linspace(0,pi,Nz_polar);
phi = linspace(0,2*pi,Nz_azim);

[THETA, PHI] = meshgrid(theta,phi);

figure();
surf(THETA',PHI',V_ndiff);
title({'Number squeezing in simulated halo',['N_{sim}=',num2str(N_sim),', N_{halo}=',num2str(N_halo),', \Omega_{frac}=',num2str(zone_frac),', N_0=',num2str(N_0,2),', \omega=',mat2str(f_trap),'Hz']});
xlabel('\Delta\theta'); ylabel('\Delta\phi'); zlabel('Normalised variance');
xlim([0,pi]); ylim([0,2*pi]);


%% Halo simulation visualisation
% 3D scatter source and halo plot
figure();
N_halo_plot = 5000;
if N_halo_plot > N_sim*N_halo
    N_halo_plot = N_sim*N_halo;
end
scatter3(P_HALO_all(1,1:N_halo_plot),P_HALO_all(2,1:N_halo_plot),P_HALO_all(3,1:N_halo_plot),2,'r','filled');
hold on;
N_source_plot = round(N_halo_plot/2);
for i=1:2
    scatter3(P_source{i}(1,1:N_source_plot),P_source{i}(2,1:N_source_plot),P_source{i}(3,1:N_source_plot),2,'b','filled');
    hold on;
end
title('Colliding condensates and scattering halo in momentum space');
xlabel('P_{x}/P_{rec}'); ylabel('P_{y}/P_{rec}'); zlabel('P_{z}/P_{rec}');
axis equal;
hold off;

% Halo momentum distribution
P_HALO_abs = sqrt(sum(P_HALO_all.^2,1));    % momentum magnitude in halo

[halo_p_count, halo_p_bin] = hist(P_HALO_abs,100);
halo_p_count = halo_p_count/sum(halo_p_count);  % normalise distribution

halo_p_fit = fit(halo_p_bin.',halo_p_count.','gauss1'); % Gaussian fit
w_halo = 0.8326*halo_p_fit.c1;      % HWHM width of scattering halo

figure();
bar(halo_p_bin,halo_p_count); hold on;
plot(halo_p_fit,halo_p_bin,halo_p_count); hold off;
title('Momentum distribution of scattering halo');
xlabel('P/P_{rec}'); ylabel('Prob');