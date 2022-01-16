load('MobileSensorData/sensorlog2.mat');
first6 = Position(1:6,:);
first6 = Position{1:6,:};
positionTime = Position.Timestamp;

% Initialize Variables

earthCirc = 24901*5280; % 24901 miles, convert to ft by multiplying by 5280  
totaldis = 0; 
stride = 2.5; % feet
lat = Position{1,:};
lon = Position{2,:};

% Processing Loop

for i = 1:(length(lat)-1)  % Loop through every data sample
      lat1 = lat(i); % Latitude of the i’th sample
      lon1 = lon(i); % Longitude of the i’th sample
      lat2 = lat(i+1); % Latitude of the (i+1)’th sample
      lon2 = lon(i+1); % Latitude of the (i+1)’th sample
      diff = distance(lat1, lon1, lat2, lon2); % MATLAB function to compute distance between 2 points on a sphere
      dis = (diff/360)*earthCirc; % convert degrees to feet
      totaldis = totaldis +dis;
end

steps = totaldis/stride;

% Plotting Results

plot(lat,lon);plot(lat, lon, '-r',lat(1),lon(1),'*g',lat(end),lon(end),'*b','LineWidth',3, 'MarkerSize',10 );
hold on;
legend('Route','Start Point','End Point');
xlabel('Latitude')
ylabel('Longitude');
title(sprintf('Workout Summary : You took %0.0f steps and moved %0.3f miles',steps, totaldis_ft/5280) );
hold off
