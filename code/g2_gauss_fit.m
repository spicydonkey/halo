%% g2 Gaussian fit

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

w_BB = zeros(3,3);
for i=1:3
    w_BB(i,1) = g2_fit{i}.c1;
    CI = confint(g2_fit{i},0.99);
    CI_std = CI(:,3).';
    w_BB(i,2:3) = CI_std;
end
w_BB = 0.8326*w_BB;

% Calculate normalised ratios (wrt momentum dist) for comparison
r_wBB_S = zeros(3,3);
for i=1:3
    r_wBB_S(i,:) = w_BB(i,:)/w_p_dist(i);
end

% Plot
figure();
boxplot(r_wBB_S'); hold on;
scatter([1,2,3],1.08*[1,1,1],'filled'); hold on;
scatter([1,2,3],sqrt(2)*[1,1,1],'filled'); hold on;
title('\it w_i^{(BB)}/w_i^{(S)} \rm comparison between simulation and theory');
ylim([1,2]);
xlabel('axes index');

% g(2) correlation length vs. halo thickness
r_wBB_halo = w_BB/w_halo;
figure();
boxplot(r_wBB_halo');
title('g^{(2)} correlation length vs. halo thickness: \it w_i^{(BB)}/w_{halo}');