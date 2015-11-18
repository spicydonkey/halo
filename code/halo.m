%% Halo: Simulation and data analysis for observing squeezing
% Analyse the number differences (momentum-corr pairs) in the simulation of the scattered halo from a collision of two BECs
% DK Shin
% 10.11.15

%% Calculation of T-F momentum wavefunction
% Pre-collision BEC momentum distribution is calculated from T-F approximation: requires population and mean momentum of colliding condensates, and trap frequency
w_trap_bar = prod(w_trap)^(1/3);
a_bar = sqrt(hbar/(m_He*w_trap_bar));       % mean characteristic length of trap
mu = 1.4771*hbar*w_trap_bar*(N_0*a_He/w_trap_bar)^0.4;  % chemical potential

% Thomas-Fermi radii
R_bec = sqrt(2*mu/m_He)./w_trap;

% TF condensate momentum distribution (approximated by Gaussian)
for i=1:2
    P_dist{i}{2} = hbar*(1.69./R_bec);  % standard deviation (calculated from HWHM=1.99/R_i)
end


%% Simulation
N_zone = zeros(Nz_polar*Nz_azim,N_sim);
P_HALO = cell(N_sim,1);
for i_sim = 1:N_sim
    close all;
    % run halo simulation
    [P_halo, P_in] = halo_sim(P_dist,N_halo,QE);
    
    % Scale momentum to recoil velocity unit (BEC initial momentum)
    for i=1:length(P_in)
        P_in{i} = P_in{i}/P_norm;
    end
    P_halo = P_halo/P_norm;
    
    % find number vs zones in this simulation and collate
    N_zone(:,i_sim) = halo_analyse(P_halo,zone_frac,Nz_polar,Nz_azim);
    
    % save scattered halo momentum data
    P_HALO{i_sim} = P_halo;
end
clear i_sim;
    
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
%title(['N_{sim}=',num2str(N_sim),', N_{pair}=',num2str(N_halo),', \Omega_{frac}=',num2str(zone_frac),', \sigma_{p1}=',mat2str(P_dist{1}{2},3),', \sigma_{p2}=',mat2str(P_dist{2}{2},3)]);
title(['N_{sim}=',num2str(N_sim),', N_{halo}=',num2str(N_halo),', \Omega_{frac}=',num2str(zone_frac),', N_0=',num2str(N_0,2),', \omega=',mat2str(w_trap)]);
xlabel('\Delta\theta'); ylabel('\Delta\phi'); zlabel('Normalised variance');
xlim([0,pi]); ylim([0,2*pi]);


%% Halo simulation visualisation
% Simulation single-shot
figure();
for i = 1:2
    scatter3(P_in{i}(1,:),P_in{i}(2,:),P_in{i}(3,:),2,'b','filled');
    hold on;
end
scatter3(P_halo(1,:),P_halo(2,:),P_halo(3,:),2,'r','filled');
title('Colliding Bose-Einstein condensates in momentum space (single shot)');
xlabel('p_{x}'); ylabel('p_{y}'); zlabel('p_{z}');
axis equal;

% Halo momentum distribution
P_HALO_abs = sqrt(sum(P_HALO_all.^2,1));    % momentum magnitude in halo

[halo_p_count, halo_p_bin] = hist(P_HALO_abs,100);
halo_p_count = halo_p_count/sum(halo_p_count);  % normalise distribution

halo_p_fit = fit(halo_p_bin.',halo_p_count.','gauss1'); % Gaussian fit
w_halo = 0.8326*halo_p_fit.c1;

figure();
bar(halo_p_bin,halo_p_count); hold on;
plot(halo_p_fit,halo_p_bin,halo_p_count);
title('Scattered halo momentum (magnitude) distribution');
xlabel('P/P_{rec}'); ylabel('P');