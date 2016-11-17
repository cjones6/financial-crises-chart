% This program plots the crises data over time using data from the Reinhart
% Rogoff database.  It takes approximately 12 minutes to run.

% Load the data
rawdata = importdata('../data/motion_chart_data.csv', ',', 1); 
latitude = rawdata.data(:,1);
longitude = rawdata.data(:,2);
year = rawdata.data(:,3);
currency_crisis = rawdata.data(:,4);
inflation_crisis = rawdata.data(:,5);
stock_market_crash = rawdata.data(:,6);
sovereign_domestic_debt_crisis = rawdata.data(:,7);
sovereign_external_debt_crisis = rawdata.data(:,8);
banking_crisis = rawdata.data(:,9);
% inflation variable is max(inflation, 0) since I'm using inflation as the  
% size of the points
inflation = rawdata.data(:,11); 
country_label = rawdata.textdata(:,1);
% Drop the first entry to get rid of the column heading
country_label = country_label(2:length(country_label));

% Determine if a crisis occurs in a given year
crisis = [currency_crisis inflation_crisis stock_market_crash sovereign_domestic_debt_crisis sovereign_external_debt_crisis banking_crisis];
crisis = max(crisis,[],2);


% Colors- it's using the rgb color scheme so c can only contain 3
% elements.  Thus, the way it's made, the other types of crises not
% included below will be black on the map.  
c = [sovereign_domestic_debt_crisis sovereign_external_debt_crisis banking_crisis];


% World map in Mercator projection
% Note that in order to be able to plot the points at the correct locations
% using their latitude and longitude, it's easiest to have a map that uses
% the mercator projection. I got the following map from 
% http://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Mercator-project
% ion.jpg/773px-Mercator-projection.jpg
fname = '../data/Mercator_projection.jpg';

img = imread(fname);
[imgH,imgW,~] = size(img);

% Mercator projection for the location of the countries
[x,y] = mercatorProjection(longitude, latitude, imgW, imgH);
% Location of the title 
[t1,t2] = mercatorProjection(-15, 75, imgW, imgH);
% Location of the legend 
[s1,s2] = mercatorProjection(-170, -50, imgW, imgH);

for t=1800:1:2010
    % Display the map
    imshow(img, 'InitialMag',100, 'Border','tight'), hold on
    % Create an indicator vector for the year t
    ind = ismember(year, t);
    % Plot the points: x,y are location, third input is size, c is the
    % color scheme. crisis is a dummy for whether a crisis occurred in a
    % given year in a given country.  
    h = scatter(x,y, crisis.*inflation.*ind+.0001, c, 'filled');
    % Loop over observations in order to display the names of only the
    % countries that have crises in the given year
    labels.str = country_label;
    for i = 1:1:size(labels.str,1)
        if crisis(i,1)==0 || year(i,1)~=t
            labels.str(i,1)={''};
        end
    end    
    text(x, y, labels.str, 'Color','w', 'VerticalAlign','bottom', 'HorizontalAlign','right')
    % Add the title
    text(t1,t2,['Year: ',int2str(t)],'Color','r')
    % Add legend
    text(s1, s2, 'Color of circles is a combination of:','Color','r')
    text(s1, s2+15, 'red: domestic debt crisis','Color','r')
    text(s1, s2+30, 'green: sovereign external debt crisis','Color','r')
    text(s1, s2+45, 'blue: banking crisis','Color','r')
    text(s1, s2+60, 'black: other (currency or inflation crisis or stock market crash)','Color','r')
    text(s1, s2+75, 'Size of circles denotes amount of inflation','Color','r')
    
    hold off
    % Capture the image
    F(t-1799) = getframe(gcf);
end

% Create the movie.  It will be called 'output.avi', have the maximum
% quality (100), and have 1 frame (i.e. 1 year) per second
movie2avi(F, 'output.avi','Quality',100,'fps',1);

