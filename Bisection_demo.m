f = @(x) x^3;
a = -0.13;
b = 0.13;
% this means tolerance is 10^(-5)
tol = 10e-5;

tic
[root, number_of_iterations] = bisection (f,a,b,tol);
toc
function [root, number_of_iterations] = bisection (f,a,b,tol)
%%%%%%%%%%%
% input:
% f: function which we want to find the root
% a,b: the left and right endpoint of the domain
% tol: an estimate of how close we would like to be to our root
%
% output:
% root: is the root of the function
% number_of_iterations: the number of iterations the program took
%%%%%%%%%%

% first make the bisection work
if f(a)*f(b) > 0 % means this is not a proper interval to find the root
    root = NaN;
    number_of_iterations = 0;
    disp('wrong answer')
else
    number_of_iterations = 0; %iteration counter
    a_k = a;%the sequence of left endpoint
    b_k = b;%the sequence of right endpoint
    m_k = (a_k + b_k)/2;
    while abs(m_k-0) > tol %loop until the midpoint is at most 'tol' from the root
        number_of_iterations = number_of_iterations +1;
        m_k = (a_k + b_k)/2;
        if sign(f(m_k)) == sign(f(a_k))
            a_k = m_k;
        else
            b_k = m_k;
        end
    end
    root = m_k;
end

end
        
    
    