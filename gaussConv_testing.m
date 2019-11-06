% testing numerical guassian convolution by convoluting a step function and
% fitting the result
% k from the fit should be 1/(s*sqrt(2)) where s is the standard deviation
% of the gaussian we're convoluting with
len = 200;
x = rand(1, len);
x = sort(x);
y = zeros(1,len);
y(x > 0.5) = 1;
y_conv = gaussConv(x,y,0.05);

func = @(k, a, x) 0.5*(erf((k*(x-a)))+1);
[f gof] = fit(x',y_conv', func, 'startpoint', ...
    [0.2, 0.5]);

plot(x,y_conv, 'o')
hold on
plot(x,f(x), 'linewidth', 1.1)

[f.a f.k]