%% Histogram plot of g2
% DK Shin

%% Parameter
n_hist_bin = 40;

%% Histogramming
G2_singleshot = cell(3,1);
G2_allshot = cell(3,1);
bin = cell(3,1);
g2 = cell(3,1);

figure();
plotStyle = 'rgb';
axesName = ['x';'y';'z'];
for i=1:3
    [G2_singleshot{i}, bin{i}] = hist(Psum_BB_singleshot_collate(i,:),n_hist_bin);
    G2_allshot{i} = hist(Psum_BB_allshot(i,:),bin{i});
    
    g2{i} = N_sim*G2_singleshot{i}./G2_allshot{i};
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