%Atiq uz Zaman
%15026391

% Mamdani solution

data = load('data.txt');
data = data(randperm(size(data,1)),:);    %setting random permutation

fis = readfis('mamdanifuzzylogic.fis');   %reading fuzzy inference system FIS

dataInput = data(:,1:3); % given input values 
dataOutput = data(:,4);  % given output values

dataOutput(dataOutput ==2) = 0;  %replacing all 2 values to 0

rgbData = fliplr(data(:,1:3));  %BGR to RGB

ycbcrData =  rgb2ycbcr(rgbData);   % RGB to YCBCR

%According to Research paper
y = ycbcrData(:,1)+16;
cb = ycbcrData(:,2)+128;
cr = ycbcrData(:,3)+128;

ycbcrData = [y cb cr];  %desired ycbcr


evalOutput = round(evalfis(ycbcrData,fis));
result = evalOutput - dataOutput;
skinCount = sum(result==0);
performance = (skinCount/length(evalOutput))*100;
disp(performance);