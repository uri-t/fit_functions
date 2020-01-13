% this function is a wrapper for fitFunctions.m that allows the functions
% specified there to be used in the cftool fitting GUI. 
% Input: name of function, array of coefficients, and array of x data
% Output: the function applied to the x data

function y = fitFunctionWrapper(name, coeffs, x)
%% error checking

func = fitFunctions(name);

%% call function

args = [coeffs {x}];
y = func(args{:});