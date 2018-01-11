% prototype script to filter bright spots in halo with a global threshold
%
%
% INPUT
%   K: NSHOTx2 cell-array of k-vectors
%
% OUTPUT
%   K_filt: NSHOTx2 cell-array of filtered k-vecs
%

%% configs
dpsi=0.1;

z_thresh=1;     % num of std from mean to set threshold level

dpsi_lim=0.1;   % filtering bin size (rad)

%% find noisy regions
% count distribution around sphere
[~,n]=summary_disthalo_ndist(K,[nAz,nEl],'flat');

% eliminate polar caps
for ii=1:2
    n{ii}(b_pole)=NaN;      % values around polar-caps are set to NaN
end

% set threshold level
n_thresh=cellfun(@(nn)mean(nn(:),'omitnan')+z_thresh*std(nn(:),'omitnan'),n,'UniformOutput',false);

% get noisy regions
b_noisy_zone=cellfun(@(nn,nt)nn>nt,n,n_thresh,'UniformOutput',false);
Az_noise=cellfun(@(b)Az(b),b_noisy_zone,'UniformOutput',false);
El_noise=cellfun(@(b)El(b),b_noisy_zone,'UniformOutput',false);

% combined noisy region
b_noisy_zone_comb=or(b_noisy_zone{:});


%% filter density map
n_filt=n;
for ii=1:2
    n_filt{ii}(b_noisy_zone{ii})=NaN;       % set to NaN
end

% compare raw + filtered
for ii=1:2
    figure();
    
    subplot(1,2,1);
    plotFlatMapWrappedRad(Az,El,n{ii},'eckert4');
    colorbar();
    
    subplot(1,2,2);
    plotFlatMapWrappedRad(Az,El,n_filt{ii},'eckert4');
    colorbar();
end


%% filter bell corr
E_orig=E;
E_filt=E;
E_filt(b_noisy_zone_comb)=NaN;


% %% filter halo
% % find counts near noisy region
% S=cellfun(@(x)zxy2sphpol(x),K,'UniformOutput',false);
% b_bad_count=cellfun(@(s)false(size(s,1),1),S,'UniformOutput',false);    % initialise bad counts
% for mm=1:2
%     tS=S(:,mm);
%     bb_bad=cellfun(@(s)false(size(s,1),1),tS,'UniformOutput',false);     % initialise bad counts
%     for ii=1:length(Az_noise{mm})
%         taz=Az_noise{mm}(ii);
%         tel=El_noise{mm}(ii);
%         
%         % get indices to counts in this noisy zone
%         tb_bad=cellfun(@(s) inZone(taz,tel,s(:,1),s(:,2),dpsi_lim),tS,'UniformOutput',false);
%         
%         % update accumulator
%         bb_bad=cellfun(@(b1,b2)b1|b2,bb_bad,tb_bad,'UniformOutput',false);
%     end
%     b_bad_count(:,mm)=bb_bad;      % store
% end
% 
% fprintf('number of counts in noisy region: %d \n',sum(cellfun(@(b) sum(b),b_bad_count)));
% 
% % filter the bad counts
% % NOTE: atom ordering is unchanged between cart <--> spherical transform
% K_bad=cellfun(@(k,b) k(b,:),K,b_bad_count,'UniformOutput',false);     % bad k-vecs
% K_filt=cellfun(@(k,b) k(~b,:),K,b_bad_count,'UniformOutput',false);     % filtered k-vecs
% 
% % display
% figure();
% plot_zxy(K_bad,[],100);
% hold on;
% plot_zxy(K_filt,[],10);
% axis equal;
% box on;
% xlabel('$K_x$','interpreter','latex');
% ylabel('$K_y$','interpreter','latex');
% zlabel('$K_z$','interpreter','latex');
