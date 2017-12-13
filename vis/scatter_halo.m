function [H] = scatter_halo(K,hfig)
% Visualisation of halo data 
% pretty 3D-scatter plot of halos in K-space
% 
% [h] = scatter_halo(K)
%
%

if nargin>1
    H=figure(hfig);
else
    H=figure();
end

plot_zxy(K);    % scatter plot of halo

% figure annotation
axis equal;
box on;
xlabel('$K_x$','interpreter','latex');
ylabel('$K_y$','interpreter','latex');
zlabel('$K_z$','interpreter','latex');

end