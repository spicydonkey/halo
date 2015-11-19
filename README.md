# halo
Simulation of colliding Bose-Einstein condensates in producing momentum-correlated pairs of atoms.
S-wave scattering and T-F approximation are used in the simulation model.
Scattering halo qualitatively resembling experiments are produced and data analysis is undertaken to quantify number squeezing and momentum correlation.


## Package
### MATLAB scripts
* halo.m
* halo_sim.m
* halo_analyse.m (RENAME this file)
* g2_BB.m
* g2_histo.m
* g2_gauss_fit.m
* g2_ogren_kheruntsyan.m
* pairsum.m
* ballfilter.m


## Instructions
1. **Configure** simulation parameters in halo.m: *N_sim, N_halo, QE, N_0, P_dist, w_trap, zone_frac, Nz_polar, Nz_azim* 
2. **Run** halo.m script
	~~Explain what the script does~~
3. **Configure** parameters in g2_BB.m: *p_delta*
4. **Run** g2_BB.m 
	~~Explain what the script does~~
5. **Run** g2_gauss_fit.m
	~~explain~~
6. **Run** g2_ogren_kheruntsyan.m
	~~explain~~

## He* BEC collision experiment
* Raman/Bragg laser wavelength: 1083nm
* He* s-wave scattering length: a_He = 7.5nm
* He4 mass: m_He = 6.65e-27 kg

## BEC momentum distribution
### Ogren-Kheruntsyan
* Width of the momentum distribution of the source condensate (TF approx) along direction i
	w(S)_i =~ 1.99/R_i

### Thomas-Fermi approximation of BEC wavefunction
* Thomas-Fermi radius: R_i = sqrt(2*mu/(m*omega_i^2))
* Chemical potential: mu = (15*N_0*a/abar)^0.4*hbar*omega_avg/2

#### BEC parameters
* Characteristic length of oscillator: abar = sqrt(hbar/(m*omega_avg))
* Oscillator frequency: omega_avg = (omega_1*omega_2*omega_3)^(1/3)
* Condensate population: N_0
