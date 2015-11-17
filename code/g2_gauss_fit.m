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


%% Comparison to theory
w_p_dist = sqrt(2*log(2))*P_dist{1}{2}/P_norm;  % HWHM (width) of momentum distribution

w_BB_sim = zeros(3,3);
for i=1:3
    w_BB_sim(i,1) = g2_fit{i}.c1;
    CI = confint(g2_fit{i},0.99);
    CI_std = CI(:,3).';
    w_BB_sim(i,2:3) = CI_std;
end
w_BB_sim = 0.8326*w_BB_sim;

w_BB_theory = 1.08*w_p_dist;

% Calculate normalised ratios (wrt momentum dist) for comparison
r_wBBsim = zeros(3,3);
for i=1:3
    r_wBBsim(i,:) = w_BB_sim(i,:)/w_p_dist(i);
end

r_BB_theory = 1.08*ones(3,1);

% Plot
figure();
boxplot(r_wBBsim'); hold on;
scatter([1,2,3],1.08*[1,1,1],'filled'); hold on;
scatter([1,2,3],sqrt(2)*[1,1,1],'filled'); hold on;
title('\it w_i^{(BB)}/w_i^{(S)} \rm comparison between simulation and theory');
ylim([1,2]);
xlabel('axes index');