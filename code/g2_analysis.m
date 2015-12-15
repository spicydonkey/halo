%% g2 analysis
% Fit Gaussians to histogrammed g2 and compare results to quantum
% simulations
% DK Shin

% Create shifted g2 (i.e. g2-1) for Gaussian fit
g2_0 = cell(3,1);
for i=1:3
    g2_0{i} = g2{i}-1;
end

% Fit g2_0 with Gaussian
g2_fit = cell(3,1);
for i=1:3
    g2_fit{i} = fit(bin{i}.',g2_0{i}.','gauss1');
end

% Plot fit
figure();
for i=1:3
    fig(i) = subplot(3,1,i);
    plot(g2_fit{i},bin{i},g2_0{i}); grid on; hold on;
end
hold off;
title(fig(1),'Gaussian fit to \it{g^{(2)}-1}');


%% Correlation width comparison
w_p_dist = sqrt(2*log(2))*P_dist{1}{2}/P_norm;  % HWHM (width) of momentum distribution

w_BB = zeros(3,1);      % HWHM width of BB correlation length (and error)
err_wBB = zeros(3,1);
for i=1:3
    w_BB(i) = g2_fit{i}.c1;
    CI = confint(g2_fit{i},0.95);
    err_wBB(i) = diff(CI(:,3))/2;    % CI error
end
w_BB = 0.8326*w_BB;     % scale spread measure to HWHM (ref. MATLAB gauss fit parameter "c1")
err_wBB = 0.8326*err_wBB;

% Calculate normalised ratios (wrt momentum dist) for comparison
r_wBB_S = w_BB./w_p_dist;
err_r_wBB_S = err_wBB./w_p_dist;

% Plot ratio of corr length to source momentum width
axesName = ['x';'y';'z'];
figure();
errorbar([1,2,3],r_wBB_S,err_r_wBB_S,'ok'); hold on;
plot([1,2,3],1.08*[1,1,1],'r'); hold on;
plot([1,2,3],sqrt(2)*[1,1,1],'b'); hold on;
title('Ratio of back-to-back correlation length to source momentum width:\it w_i^{(BB)}/w_i^{(S)}');
ylim([0.5,2]);
xlabel('axis');
ylabel('w_i^{(BB)}/w_i^{(S)}');
set(gca,'XTick',[1,2,3]);
set(gca,'XTickLabel',axesName);
legend({'Classical simulation','Quantum TF','Quantum Gaussian'});

% g(2) correlation length vs. halo thickness
r_wBB_halo = w_BB/w_halo;
err_r_wBB_halo = err_wBB/w_halo;
figure();
errorbar([1,2,3],r_wBB_halo,err_r_wBB_halo,'ok'); hold on;
title('g^{(2)} correlation length vs. halo thickness: \it w_i^{(BB)}/w_{halo}');
xlabel('axis');
ylabel('w_i^{(BB)}/w_{halo}');
set(gca,'XTick',[1,2,3]);
set(gca,'XTickLabel',axesName);