%% Simulation configuration
% User defined parameters to configure the halo simulation
% Some important parameters include: N_halo, f_trap, N_0
% DK Shin
% 19.11.15


%% Constants
hbar = 1.055e-34;
m_He = 6.65e-27;
a_He = 7.5e-9;      	% s-wave scattering length between He* m_x=1 (for magnetic trap)
%a_He = 5.3e-9;		% scattering length, He* m_x=0
wavelength_laser = 1083e-9;
k_laser = 2*pi/wavelength_laser;    % Raman/Bragg transition laser wave-number


%% Simulation
N_sim=2500;         % number of simulations to run


%% Experimental parameters
QE = 0.1;       % quantum efficiency of detector
N_halo=30;      % number of atoms in detected halo

% BEC
N_0 = 1e4;      % number of atoms in condensate

% trap potential
f_trap = [50;100;100];      % trap frequencies in Hz

% mean/recoil momentum of condenstates
P_dist{1}{1} = hbar*k_laser*[0;0;1];    % BEC1 mean momentum (3D-vector)
P_dist{2}{1} = -P_dist{1}{1};   % BEC2 mean momentum (experimentally fix global origin as centre of motion)
P_norm = norm(P_dist{1}{1});    % BEC com momentum (recoil velocity from Bragg/Raman) to normalise all other momenta


%% Number squeezing analysis
zone_frac=1e-2;     % fraction of halo to perform num diff analysis
Nz_polar=10;        % number of polar and azimuthal zones to compare
Nz_azim=10;
