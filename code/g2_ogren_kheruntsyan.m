% Free parameters
t = 1e-3;
C = 1e3;
TUNE = t*C;
TUNE = 1.6;       % tune myself

P = logspace(-4,log10(p_delta));     % normalised momentum

kiRi = R_bec*P*(P_norm/hbar);

g2_BB_ok = ((105^2)*pi/(32*TUNE^2))*(besselj(2.5,kiRi)./(kiRi.^2.5)).^2;

P = [-fliplr(P) P];
g2_BB_ok = [fliplr(g2_BB_ok) g2_BB_ok];

F_ok = cell(3,1);

% Plot
figure();
for i=1:3
    subplot(3,1,i);
    %plot(g2_fit{i},bin{i},g2_0{i});
    plot(P,g2_BB_ok(i,:));
    grid on; hold on;
    
    F_ok{i} = fit(P.',g2_BB_ok(i,:).','gauss1');
    plot(F_ok{i},P.',g2_BB_ok(i,:).');
end