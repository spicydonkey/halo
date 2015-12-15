%% Histogram plot of g2
% DK Shin

%% Parameter
n_hist_bin = 40;

%% Histogramming
G2 = cell(3,1);
bin = cell(3,1);
G2norm = cell(3,1);
g2 = cell(3,1);

figure();
plotStyle = 'rgb';
axesName = 'xyz';
for i=1:3
    [G2{i}, bin{i}] = hist(P_BB_all(i,:),n_hist_bin);
    G2norm{i} = hist(P_BB_norm(i,:),bin{i});
    
    g2{i} = N_sim*G2{i}./G2norm{i};
    plot(bin{i},g2{i},plotStyle(i)); hold on;
    
    legendInfo{i} = axesName(i);
end
grid on; hold off;

% Plot labels
title('g^{(2)} correlation of back-to-back scattered atom-pairs projected along each axes');
xlabel('\deltar');
ylabel('g^{(2)}');
legend(legendInfo);

% clear variables
clear legendInfo;
clear plotStyle;
clear axesName;