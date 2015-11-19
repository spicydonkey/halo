%% Simulation configuration
% DK Shin
% 19.11.15


%% Constants
hbar = 1.055e-34;
m_He = 6.65e-27;
a_He = 7.5e-9;      % s-wave scattering length of He*
k_laser = 2*pi/(1083e-9);   % Raman/Bragg wave number


%% Simulation
N_sim=1000;         % number of simulations


%% Experimental
QE = 0.1;       % quantum efficiency of detector
N_halo=30;      % number of atoms in detected halo

% BEC
N_0 = 1e4;      % number of atoms in condensate

% mean/recoil momentum
P_dist{1}{1} = hbar*k_laser*[0;0;1];    % BEC1 mean momentum
P_dist{2}{1} = -P_dist{1}{1};   % BEC2 mean momentum (experimentally fix global origin as centre of motion)
P_norm = norm(P_dist{1}{1});    % BEC com momentum (recoil velocity from Bragg/Raman) to normalise all other momenta

% trap potential
w_trap = 2*pi*[48;180;180];


%% Number squeezing analysis
zone_frac=1e-2;     % fraction of halo to perform num diff analysis
Nz_polar=10;        % number of polar and azimuthal zones to compare
Nz_azim=10;