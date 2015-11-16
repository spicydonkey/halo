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
title(fig(1),'Gaussian fit to \it{g^{(2)}-1}');