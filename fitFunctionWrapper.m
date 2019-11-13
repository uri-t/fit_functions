% this function is a wrapper for fitFunctions.m that allows the functions
% specified there to be used in the cftool fitting GUI. 
% Input: name of function, array of coefficients, and array of x data
% Output: the function applied to the x data

function y = fitFunctionWrapper(varargin)
%% error checking
if length(varargin) ~= 3
    error('incorrect number of arguments passed to fitFunctionWrapper')
end

name = varargin{1};
coeffs = varargin{2};
x = varargin{3};

func = fitFunctions(name);

if nargin(func)-1 ~= length(coeffs)
    error('wrong number of coefficients supplied to function %s', name)
end

%% call function
coeffs_c = num2cell(coeffs);
if size(coeffs_c,1) > size(coeffs_c,2)
    coeffs_c = coeffs_c';
end
args = [coeffs_c {x}];
y = func(args{:});
