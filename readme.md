## Overview
This code produces a motion chart depicting financial crises that occurred in each country from 1800-2010. From it you can get a sense of how often and where the financial crises occurred, and if there was [contagion](https://en.wikipedia.org/wiki/Financial_contagion). There is one frame per year, with each frame containing a world map with the locations of crises in that year labeled. The circles for the crises are color-coded according to the rgb color scheme, with
- red: sovereign domestic debt crisis
- green: sovereign external debt crisis
- blue: debt crisis
- black: currency crisis, inflation crisis, or stock market crash
The size of the circles represents the amount of inflation.

The code was written in Matlab version 7.10.0 (R2010a). It takes approximately 12 minutes to run and produces an avi file.

## Data sources
- Crisis data:
	- Crisis dates: [http://www.carmenreinhart.com/data/browse-by-topic/topics/7/]
	- Inflation: [http://www.carmenreinhart.com/data/browse-by-topic/topics/2/]
	Reinhart, C. M., & Rogoff, K. S. (2011). From financial crash to debt crisis. *The American Economic Review, 101*(5), 1676-1706.
- Map and coordinates:
	- Average latitude and longitude for countries: [http://dev.maxmind.com/geoip/legacy/codes/country_latlon/]
	- Mercator map: [http://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Mercator-projection.jpg/773px-Mercator-projection.jpg]


