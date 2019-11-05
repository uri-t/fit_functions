function convd = gaussConv(x,y, sig)

% check lengths
if size(x) ~= size(y)
    disp('input vectors do not have matching dimensions')
end

% transpose x and y if necessary
if size(x,1) ~= 1
    x = x';
end

if size(y,1) ~= 1
    y = y';
end

convd = zeros(size(x));

w = ceil(sqrt(length(x)));
h = floor(sqrt(length(x)));

% interpolate and pad to deal with numerical issues
x = [x(1)-4*sig x x(end)+4*sig];
y = [y(1) y y(end)];

sp = min([min(diff(x)), sig/2]);
x_int = [min(x):sp: max(x)];
y_int = interp1(x,y,x_int);

%figure()
for i = [1:length(x)]
    mu = x(i);
    g = normpdf(x_int, mu, sig);
%     subplot(w, h, i)
%     plot(x_int, y_int)
%     hold on
%     plot(x_int, g)
    convd(i) = trapz(x_int, g.*y_int);
end
convd = convd(2:end-1);

