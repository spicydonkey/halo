%% Histogram plot of g2
% DK Shin

%% Parameter
n_hist_bin = 30;

%% Histogramming
G2 = cell(3,1);
bin = cell(3,1);
G2norm = cell(3,1);
g2 = cell(3,1);

figure();
colors = 'rgb';
for i=1:3
    [G2{i}, bin{i}] = hist(P_BB_all(i,:),n_hist_bin);
    G2norm{i} = hist(P_BB_norm(i,:),bin{i});
    
    g2{i} = N_sim*G2{i}./G2norm{i};
    plot(bin{i},g2{i},colors(i)); hold on;
end
grid on;