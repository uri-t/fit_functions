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
    func = @(a, t0, t1, s, x) gaussConv(x, heaviside(x-t0).*exp(-(x-t0)/t1), s);
    return 
end

% single exponential starting at t0, with peak amplitude a+y0, and decaying
% the time constant t1 towards y0
% convoluted with a guassian with standard deviation s using closed form
% expression derived here:
% http://www.np.ph.bham.ac.uk/research_resources/programs/halflife/gauss_exp_conv.pdf
if strcmp(name, 'sing_exp_conv_test')
    func = @(a, t0, t1, s, x) 0.5*exp(-(1/t1)*(x-t0-s^2/(2*t1))).*(1+erf((x-t0-(s^2/t1))/(s*sqrt(2))));
    return
end

% stretched exponential starting at t0, with peak amplitude (a+y0) decaying
% towards y0.  
if strcmp(name, 'strc_exp')
    func = @(a, t0, t1, b, y0, x) heaviside(x-t0).*(a*exp(-((x-t0)/t1).^b)+y0);
end

% stretched exponential starting at t0, with peak amplitude (a+y0) decaying
% towards y0 
% numerically convoluted with a gaussian with std. dev. 
if strcmp(name, 'strc_exp_conv')
    func = @(a, t0, t1, b, y0, s, x) gaussConv(x, heaviside(x-t0).*(a*exp(-((x-t0)/t1).^b)+y0),s)';
end

