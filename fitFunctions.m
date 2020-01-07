% takes in a name (i.e. biexp_conv, stretched exp, etc.) and returns the
% an anonymous function for that type of fit
function func = fitFunctions(name)

% single exponential starting at t0, with peak amplitude a+y0, and decaying
% the time constant t1 towards y0
if strcmp(name, 'sing_exp')
    func = @(a, t0, t1, y0, x) heaviside(x-t0).*(a*exp(-(x-t0)/t1)+y0);
    return
end

% single exponential starting at t0, with peak amplitude a+y0, and decaying
% the time constant t1
% numerically convoluted with a guassian with standard deviation s using
% function gaussConv.m
if strcmp(name, 'sing_exp_conv')
    func = @(a, t0, t1, y0, s, x) gaussConv(x, heaviside(x-t0).*(a*exp(-(x-t0)/t1)+y0), s)';
    return 
end


% biexponential injection 
if strcmp(name, 'biexp_inj')
    func = @(t0, a1, t1, a2, t2, x) heaviside(x-t0)*(a1*(1-exp(-(x-t0)/t1)) + a2*(1-exp(-(x-t0)/t2)));
    return
end

% biexponential injection followed by stretched exponential trapping
if strcmp(name, 'biexp_inj_strc_trap')
    func = @(t0, a1, t1, a2, t2, t, b, y0, x) ...
        heaviside(x-t0).*(a1*(1-exp(-(x-t0)/t1)) + a2*(1-exp(-(x-t0)/t2))).*...
        ((a1+a2)*exp(-((x-t0)/t).^b)+y0);
    return
end
% single exponential starting at t0, with peak amplitude a+y0, and decaying
% the time constant t1 towards y0
% convoluted with a guassian with standard deviation s using closed form
% expression derived here:
% http://www.np.ph.bham.ac.uk/research_resources/programs/halflife/gauss_exp_conv.pdf
if strcmp(name, 'sing_exp_conv_test')
    func = @(a, t0, t1, s, x) a*0.5*exp(-(1/t1)*(x-t0-s^2/(2*t1))).*(1+erf((x-t0-(s^2/t1))/(s*sqrt(2))));
    return
end

% stretched exponential starting at t0, with peak amplitude (a+y0) decaying
% towards y0.  
if strcmp(name, 'strc_exp')
    func = @(a, t0, t1, b, y0, x) heaviside(x-t0).*(a*exp(-((x-t0)/t1).^b)+y0);
    return
end

% stretched exponential starting at t0, with peak amplitude (a+y0) decaying
% towards y0 
% numerically convoluted with a gaussian with std. dev. s
if strcmp(name, 'strc_exp_conv')
    func = @(a, t0, t1, b, y0, s, x) gaussConv(x, heaviside(x-t0).*(a*exp(-((x-t0)/t1).^b)+y0),s)';
    return 
end

%Double exponential
%1st exponential has an amplitude of a1 and time constant t1
%2nd exponential has an amplitude of a2 and time constant t2 
if strcmp(name, 'dbl_exp')
    func = @(a1, a2, t0, t1, t2, y0, x) heaviside(x-t0).*(a1*exp(-(x-t0)/t1)+a2*exp(-(x-t0)/t2)+y0);
    return 
end

%Double exponential convoluted with a Gaussian 
%1st exponential has an amplitude of a1 and time constant t1
%2nd exponential has an amplitude of a2 and time constant t2 
if strcmp(name, 'dbl_exp_conv')
    func = @(a1, a2, t0, t1, t2, y0, s, x) gaussConv(x, heaviside(x-t0).*(a1*exp(-(x-t0)/t1)+a2*exp(-(x-t0)/t2)+y0), s)';
    return 
end

%Single and streched exponential convolued with a Guassian 
%Single exponential has an amplitude of a1 and time constant t1
%Stretched exponential has an amplitude of a2, time constant t2, and
%stretch factor of b
if strcmp(name, 'sing_exp_strc_exp')
    func = @(a1, a2, t0, t1, t2, b, y0, x) heaviside(x-t0).*(a1*exp(-(x-t0)/t1)+a2*exp(-((x-t0)/t2).^b)+y0);
    return 
end

%Single and streched exponential convolued with a Guassian
%Single exponential has an amplitude of a1 and time constant t1
%Stretched exponential has an amplitude of a2, time constant t2, and
%stretch factor of b
if strcmp(name, 'sing_exp_strc_exp_conv')
    func = @(a1, a2, t0, t1, t2, b, y0, s, x) gaussConv(x, heaviside(x-t0).*(a1*exp(-(x-t0)/t1)+a2*exp(-((x-t0)/t2).^b)+y0), s)';
    return 
end

%Double streched exponential convolued with a Guassian 
%First stretched exponential has an amplitude of a1, time constant t1, and
%stretch factor of b1
%Second stretched exponential has an amplitude of a2, time constant t2, and
%stretch factor of b2
if strcmp(name, 'dbl_strc_exp')
    func = @(a1, a2, t0, t1, t2, b1, b2, y0, x) heaviside(x-t0).*(a1*exp((-(x-t0)/t1).^b1)+a2*exp(-((x-t0)/t2).^b2)+y0);
    return 
end

%Double streched exponential convolued with a Guassian 
%First stretched exponential has an amplitude of a1, time constant t1, and
%stretch factor of b1
%Second stretched exponential has an amplitude of a2, time constant t2, and
%stretch factor of b2
if strcmp(name, 'dbl_strc_exp_conv')
    func = @(a1, a2, t0, t1, t2, b1, b2, y0, s, x) gaussConv(x, heaviside(x-t0).*(a1*exp((-(x-t0)/t1).^b1)+a2*exp(-((x-t0)/t2).^b2)+y0), s)';
    return 
end

if strcmp(name, 'quad')
    func = @(k, a, x) k*(x-a).^2;
    return
end



error('the name supplied (%s) does not correspond to any function specified in fitFunctions', name)
    

