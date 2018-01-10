% prototype script to filter bright spots in halo with a global threshold
%
%
% INPUT
%   K: NSHOTx2 cell-array of k-vectors
%
% OUTPUT
%   K_filt: NSHOTx2 cell-array of filtered k-vecs
%


%% find noisy regions
k=cell(1,2);
for ii=1:2
    k{ii}=vertcat(K{:,ii});
end

% count distribution around sphere
naz=100;
nel=50;
dpsi=0.1;
[n,az,el]=cellfun(@(kk) haloZoneCount(kk,naz,nel,dpsi,[],'simple'),k,'UniformOutput',false);

% eliminate polar caps
z_max=0.7;      % max-z used to filter halos as bad
b_pole=cellfun(@(ee)(abs(ee)>asin(z_max)),el,'UniformOutput',false);      % bool to bad region around poles
for ii=1:2
    n{ii}(b_pole{ii})=NaN;      % values around polar-caps are set to NaN
end

% set threshold level
c_thresh=3;     % num of std from mean to set threshold level
n_thresh=cellfun(@(nn)mean(nn(:),'omitnan')+c_thresh*std(nn(:),'omitnan'),n,'UniformOutput',false);

% get noisy regions
b_noisy_zone=cellfun(@(nn,nt)nn>nt,n,n_thresh,'UniformOutput',false);
az_noise=cellfun(@(t,b)t(b),az,b_noisy_zone,'UniformOutput',false);
el_noise=cellfun(@(t,b)t(b),el,b_noisy_zone,'UniformOutput',false);


%% filter halo
dpsi_lim=0.1;   % filtering bin size (rad)

% find counts near noisy region
S=cellfun(@(x)zxy2sphpol(x),K,'UniformOutput',false);
b_bad_count=cellfun(@(s)false(size(s,1),1),S,'UniformOutput',false);    % initialise bad counts
for mm=1:2
    tS=S(:,mm);
    bb_bad=cellfun(@(s)false(size(s,1),1),tS,'UniformOutput',false);     % initialise bad counts
    for ii=1:length(az_noise{mm})
        taz=az_noise{mm}(ii);
        tel=el_noise{mm}(ii);
        
        % get indices to counts in this noisy zone
        tb_bad=cellfun(@(s) inZone(taz,tel,s(:,1),s(:,2),dpsi_lim),tS,'UniformOutput',false);
        
        % update accumulator
        bb_bad=cellfun(@(b1,b2)b1|b2,bb_bad,tb_bad,'UniformOutput',false);
    end
    b_bad_count(:,mm)=bb_bad;      % store
end

fprintf('number of counts in noisy region: %d \n',sum(cellfun(@(b) sum(b),b_bad_count)));

% filter the bad counts
% NOTE: atom ordering is unchanged between cart <--> spherical transform
K_bad=cellfun(@(k,b) k(b,:),K,b_bad_count,'UniformOutput',false);     % bad k-vecs
K_filt=cellfun(@(k,b) k(~b,:),K,b_bad_count,'UniformOutput',false);     % filtered k-vecs

% display
figure();
plot_zxy(K_bad,[],100);
hold on;
plot_zxy(K_filt,[],10);
axis equal;
box on;
xlabel('$K_x$','interpreter','latex');
ylabel('$K_y$','interpreter','latex');
zlabel('$K_z$','interpreter','latex');
