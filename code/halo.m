%% Halo: Simulation and data analysis for observing squeezing
% Analyse the number differences (momentum-corr pairs) in the simulation of the scattered halo from a collision of two BECs
% DK Shin
% 10.11.15


close all; clear variables;


%% Constants
hbar = 1.055e-34;
m_He = 6.65e-27;
a_He = 7.5e-9;      % s-wave scattering length of He*


%% Parameters
N_sim=1000;     % number of simulations
N_pair=1000;    % number of collision pairs (can improve by uncertainties and detector qe, etc)

% Pre-collision BEC momentum distribution 
% T-F approximation: requires population and mean momentum of colliding condensates, and trap frequency

N_0 = 1e8;      % number of atoms in condensate

% mean momentum
P_dist{1}{1} = m_He*[1;0;0];    % BEC1 mean momentum
P_dist{2}{1} = -P_dist{1}{1};   % BEC2 mean momentum (experimentally fix global origin as centre of motion)

% trap frequency (harmonic potential)
w_trap = [50;1000;1000];

% Data analysis
zone_frac=1e-2;     % fraction of halo to perform num diff analysis
Nz_polar=10;        % number of polar and azimuthal zones to compare
Nz_azim=10;


%% Calculation of T-F momentum wavefunction
w_trap_bar = prod(w_trap)^(1/3);
a_bar = sqrt(hbar/(m_He*w_trap_bar));   % mean characteristic length of trap
mu = 1.4771*hbar*w_trap_bar*(N_0*a_He/w_trap_bar)^0.4;  % chemical potential

% Thomas-Fermi radii
R_bec = sqrt(2*mu/m_He)./w_trap;

% TF condensate momentum distribution (approximated by Gaussian)
for i=1:2
    P_dist{i}{2} = hbar*(1.69./R_bec);  % standard deviation (calculated from HWHM=1.99/R_i)
end


%% Simulation
N_zone = zeros(Nz_polar*Nz_azim,N_sim);
for i_sim = 1:N_sim
    close all;
    % run halo simulation
    [P_halo, P_in] = halo_sim(P_dist,N_pair);
    
    % find number vs zones in this simulation and collate
    N_zone(:,i_sim) = halo_analyse(P_halo,zone_frac,Nz_polar,Nz_azim);
end
clear i_sim;


%% Data analysis
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
%title(['N_{sim}=',num2str(N_sim),', N_{pair}=',num2str(N_pair),', \Omega_{frac}=',num2str(zone_frac),', \sigma_{p1}=',mat2str(P_dist{1}{2},3),', \sigma_{p2}=',mat2str(P_dist{2}{2},3)]);
title(['N_{sim}=',num2str(N_sim),', N_{pair}=',num2str(N_pair),', \Omega_{frac}=',num2str(zone_frac),', N_0=',num2str(N_0,2),', \omega=',mat2str(w_trap)]);
xlabel('\Delta\theta'); ylabel('\Delta\phi'); zlabel('Normalised variance');
xlim([0,pi]); ylim([0,2*pi]);


%% Halo simulation visualisation
n_bins = 30;
% pre-collision condensate momentum distribution
figure();
for i=1:2
    for j=1:3
        subplot(2,3,(i-1)*3+j); hist(P_in{i}(j,:),n_bins);
    end
end

% halo momentum (magnitude) distribution
P_halo_abs = sum(P_halo.^2).^0.5;
figure();
hist(P_halo_abs,n_bins);
title('Momentum magnitude distribution in scattering halo (in COM frame)');
xlabel('|p|');

% Simulation single-shot
figure();
for i = 1:2
    scatter3(P_in{i}(1,:),P_in{i}(2,:),P_in{i}(3,:),2,'b','filled');
    hold on;
end
scatter3(P_halo(1,:),P_halo(2,:),P_halo(3,:),2,'r','filled');
title('Colliding Bose-Einstein condensates in momentum space');
xlabel('p_{x}'); ylabel('p_{y}'); zlabel('p_{z}');
axis equal;