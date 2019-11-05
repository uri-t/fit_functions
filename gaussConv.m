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
x_int = [min(x): min(diff(x)): max(x)];
y_int = spline(x,y,x_int);

figure()
for i = [1:length(x)]
    mu = x(i);
    g = normpdf(x, mu, sig);
    
    % in order to get correct values at the ends, we pad the vector by
    % repeating the first or last value until the gaussian we're
    % multiplying by has values greater than the cut_off
    
    y_pad = y;
    x_pad = x;
    
    cut_off = 0.01;
    
    % pad beginning 
    while g(1) > cut_off
        spacing = min([x_pad(2)-x_pad(1) sig]);
        x_add = [x_pad(1)-sig:spacing:x_pad(1)-spacing];
        x_pad = [x_add x_pad];
        g = [normpdf(x_add, mu, sig) g];
        y_pad = [y_pad(1)*ones(1,length(x_add)) y_pad];
    end
    
    % pad end
    while g(end) > cut_off
        spacing = min([x_pad(end)-x_pad(end-1) sig]);
        x_add = [x_pad(end)+spacing:spacing:x_pad(end)+sig];
        x_pad = [x_pad x_add];
        g = [g normpdf(x_add, mu, sig)];
        y_pad = [y_pad y_pad(end)*ones(1, length(x_add))];
    end
    
     subplot(h, w, i)
     plot(x_pad, y_pad);
     hold on
     plot(x_pad, g)
     title(sum(g))
    convd(i) = trapz(x_pad, g.*y_pad);
end

