% test that convolution of single exponential with gaussian matches closed
% form expression found here: 
% http://www.np.ph.bham.ac.uk/research_resources/programs/halflife/gauss_exp_conv.pdf

x = [-1:0.1:5 6:1:15];
f_test = fitFunctions('sing_exp_conv_test');
f_num = fitFunctions('sing_exp_conv');


plot(x, f_test(1,2,1,1,x))
hold on
plot(x, f_num(1,2,1,1,x), 'x')