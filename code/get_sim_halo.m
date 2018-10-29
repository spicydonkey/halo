function V = get_sim_halo(Npair,varargin)
% GET_SIM_HALO simulated halo data
%
% Npair: number of BB pairs in halo
% 
% OPTIONAL
% sig: Gaussian noise 1x3 cell-array of doubles ({0,0,0})
% qe: detector quantum efficiency (0.1)
% Nbgd: num uncorrelated atoms in halo (0)
%
%
%------------------------------------------------------------------------
% EXAMPLE
%   Npair=200;
%   sig={0.01, 0.02, 0.01};
%   Nbgd=10;
%   V=get_sim_halo(Npair,'sig',sig,'Nbgd',Nbgd);
%------------------------------------------------------------------------
%
% DKS
% 2018-10-29
%

% parse inputs
defSig={0,0,0};
defQe=0.1;
defNbgd=0;

p=inputParser;
addOptional(p,'sig',defSig);
addOptional(p,'qe',defQe);
addOptional(p,'Nbgd',defNbgd);
parse(p,varargin{:});

sig=p.Results.sig;
qe=p.Results.qe;
Nbgd=p.Results.Nbgd;

% create BB pairs
u_pair=get_rand_usph(Npair);
u_pair=cat(1,u_pair,-u_pair);       % ORDERED

% background (uncorrelated) vectors
u_bgd=get_rand_usph(Nbgd);
u=cat(1,u_pair,u_bgd);

% Gaussian vector noise
du=cellfun(@(s) normrnd(0,s,size(u,1),1),sig,'UniformOutput',false);
du=cat(2,du{:});
U=u+du;

% detection pass/fail
is_det=rand(size(u,1),1)<qe;
v=U(is_det,:);

% randomly order output vector
Irand=randperm(size(v,1))';
V=v(Irand,:);

end