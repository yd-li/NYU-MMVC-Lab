fid = fopen('data.txt');

lineNum = 0;
last_frame = 1;
filename = sprintf('%06d.jpg', last_frame);
tline = fgets(fid);
img = imread('image/000001.jpg');
fh = figure;
imshow(img);
hold on;

Colors = ['y', 'm', 'c', 'r', 'g', 'b', 'w', 'k'];
[M, N] = size(Colors);

while ischar(tline)
    lineNum = lineNum + 1;
    C = textscan(tline,'%d	%d	%f	%f	%f	%f	%f	%f	%f	%f');
    frame = C{1};
    obj = C{2};
    coord = [C{3}, C{4}, C{5}, C{6}];

    % Start parsing data
    if frame ~= last_frame
        % Save the last frame
        frm = getframe(fh); % get the image + rectangle
        imwrite(frm.cdata, strcat('saved/', filename));
        close(fh)

        % Config params for the new image
        last_frame = frame;
        filename = sprintf('%06d.jpg', frame);
        img = imread(strcat('image/', filename));
        fh = figure(1);
        imshow(img);
        hold on;

        fprintf('Processing %s', filename);
    end

    rectangle('Position', coord, 'EdgeColor', Colors(mod(obj, N) + 1));

    % End parsing data
    tline = fgets(fid);
end

% Save the last file
frm = getframe(fh); % get the image + rectangle
imwrite(frm.cdata, strcat('saved/', filename));
close(fh)

fclose(fid);
