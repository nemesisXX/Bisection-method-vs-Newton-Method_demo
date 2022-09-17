%%
 
% f(x) = sin(x) + x^2
% we need f'(x) = cos(x) + 2*x
ff = @(xx) sin(xx) + xx.^2;
ffprime = @(xx) cos(xx) + 2*xx;


x_plot = -2:0.01:2;   
    
close all
figure(1)
plot(x_plot,ff(x_plot), '-k', 'Linewidth', 3); hold all;
plot(x_plot,0.*x_plot, '--r', 'Linewidth', 2); hold all;
%plot(xx,ffprime(xx), '--g', 'Linewidth', 2);
leg = legend('f(x)', 'y=0', 'fprime');
set(leg,'autoupdate','off')
%axis([-2*pi,2*pi,-2,2]);
xlim([min(x_plot) max(x_plot)])


%%
% initialization
x = [];
x(1) = 1.9; %2.01;

tol = 1e-14;

fprintf('\nNewtons method \n');

fprintf('%10s    %12s   \n', 'Iteration', 'Value');

fprintf('%10d    %.16f  \n', 1, x(1));

cols = parula(7);


for i = 1:100
    
    % The actual Newton step
    x(i+1) = x(i) - ff(x(i))/ffprime(x(i));
    
    % Note that: x_{i+1} is the x-intecept of the line y = f(x_i) + f'(x_i)*(x - x_i)
    % The line y = ... is the equation of the tangent line to f(x) at x=x_i
    % We plot this relationship below
    
    % Brennan Plotting Garbage to plot slope lines and next itterates
    figure(1)
    plot([x(i) x(i)],[ff(x(i)) ff(x(i))],'o','color',cols(i,:),'markerfacecolor',cols(i,:),'markersize',10)
    hold all
    n_line = @(t) ff(x(i)) + ffprime(x(i))*(t - x(i));
    if(x(i+1) < x(i))
        tt = (x(i+1)):0.01:(1.2*x(i));
    else
        fact = 1.05*(x(i) < 0) + 0.7*(x(i) > 0);
        tt = (fact*x(i)):0.01:(x(i+1));
    end
    plot(tt,n_line(tt),'-','color',cols(i,:),'linewidth',2)
    hold all
    plot([x(i+1) x(i+1)],[0 ff(x(i+1))],'--','color',cols(i,:),'linewidth',1)
    % end line plotting
    
    hold all
    % print the curent itterate
    fprintf('%10d    %.16f\n', i+1, x(i+1));
    if (abs(ff(x(i+1)))<tol)
        fprintf('Converged after %d iterations.\n', i)
        break;
    end
end


%%

% Define Error-at-step-k = E_k = |x_k - root|
% We know that: E_{k+1} = mu * E_{k}^{q}
% E_{k+1} = mu * E_{k}^{q}
% E_{k} = mu * E_{k-1}^{q}
% Divide these to get
% E_{k+1}/E_{k} = ( E_{k}/E_{k-1} )^q
% take the log of both sides 
% log( E_{k+1}/E_{k} ) = q * log( E_{k}/E_{k-1} )
% solve for q
% q = log( E_{k+1}/E_{k} ) / log( E_{k}/E_{k-1} )

root = 0;
Error = abs(x - root);
figure(2)
subplot(1,2,1)
semilogy(Error)
xlabel('k')
ylabel('Error')
subplot(1,2,2)
% q = log( E_{k+1}/E_{k} ) / log( E_{k}/E_{k-1} )
q_est = log(Error(3:end)./Error(2:end-1))./log(Error(2:end-1)./Error(1:end-2));
plot(q_est)
xlabel('k')
ylabel('$$q_{est}$$')

disp('q_est = ')
disp(q_est)
