function [data, x, amp, peak_pos]  = linescan(path, varargin)
files = dir(fullfile(path, '*.tim'));

data = {};

%% loop over tims files
if size(varargin) > 0
    range = varargin{1};
else
    range = 1:size(files,1);
end

for i = range
    % read position from corresponding par file
    fname = fullfile(path, files(i).name);
    fname_par = [fname(1:end-3) 'par'];
    
    fid = fopen(fname_par);
    line = '';
    x = 0;
    while ~feof(fid)
        line = fgetl(fid);
        if contains(line, 'ThorLabs Position')
            x = split(line, ':');
            x = x{2};
            x = str2double(x);
        end
    end
    fclose(fid);
    
    fprintf("%s: x = %0.2f\n", fname, x)
    
    fid = fopen(fname);
    d = textscan(fid, '%f %f');
    fclose(fid);
    
    data{end+1} = struct('data', [d{1} d{2}], 'x', x);
end

%plot max amplitude vs. position (normalized to max amplitude)
get_max = @(c) max(c.data(:,2));
get_x = @(c) c.x;
x = cellfun(get_x, data);
amp = cellfun(get_max, data);
get_peak_pos = @(c) c.data(find(c.data(:,2) == get_max(c),1),1);
peak_pos = cellfun(get_peak_pos, data);
figure()
subplot(2,1,1)
plot(x, amp, '.')
subplot(2,1,2)
plot(x, peak_pos, '.')