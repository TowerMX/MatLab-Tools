function draw_arrow(origin,tip,options)
%
% DRAW_ARROW(origin,tip)
%   Draws an arrow from the point ORIGIN to the point TIP.
%   These arguments must be vectors of length 2 containing the
%   coordinates of each point.
%
% DRAW_ARROW(origin,tip,options)
%   Specifying OPTIONS as name-value arguments customizes the arrow created.
%   Valid names are Color, Width, HeadWidth and HeadLength.
%   Except Color, they are distances divided by the arrow length,
%   therefore 0.5 means half the length as example.
%
%   Example:
%
% DRAW_ARROW([10 -21],[42 15],'Color','blue')

% Author: Álvaro Estévez López
    
    arguments
        origin (2,1) % So they are column vectors
        tip (2,1)
        options.Color = 'k'
        options.EdgeColor
        options.Width (1,1) {mustBeNonnegative} = 0.02
        options.HeadWidth (1,1) {mustBeNonnegative} = 0.1
        options.HeadLength (1,1) {mustBeNonnegative,mustBeLessThanOrEqual(options.HeadLength,1)} = 0.08
    end
    
    if ~isfield(options,'EdgeColor')
        options.EdgeColor = options.Color;
    end
    
    vector = tip - origin;
    
    p_headbase = tip - options.HeadLength*vector;
    p_headleft = p_headbase + options.HeadWidth/2*[0 -1;1 0]*vector; % [0 -1;1 0]*vector makes it perpendicular
    p_headright = p_headbase - options.HeadWidth/2*[0 -1;1 0]*vector;
    
    p_baseleft = origin + options.Width/2*[0 -1;1 0]*vector;
    p_baseright = origin - options.Width/2*[0 -1;1 0]*vector;
    p_headmidleft = p_headbase + options.Width/2*[0 -1;1 0]*vector;
    p_headmidright = p_headbase - options.Width/2*[0 -1;1 0]*vector;
    
    points = [tip, p_headleft, p_headmidleft, p_baseleft, p_baseright, p_headmidright, p_headright];
    
    patch(points(1,:),points(2,:),options.Color,'EdgeColor',options.EdgeColor)
    
end