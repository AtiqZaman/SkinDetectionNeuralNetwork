%Atiq uz Zaman
%15026391

% Anfis Sugeno-type fuzzy inference system

data = load('data.txt');

data = data(randperm(size(data,1)),:);  %setting random permutation

dataInput = data(:,1:3); % Given input values 
dataOutput = data(:,4);  % Given output values


rgbData = fliplr(data(:,1:3));  % Changing BGR to RGB

ycbcrData = rgb2ycbcr(rgbData); % Converting rgb to ycbcr

%According to Research paper
y = ycbcrData(:,1)+16;
cb = ycbcrData(:,2)+128;
cr = ycbcrData(:,3)+128;

ycbcrData = [y cb cr];  %desired ycbcr

%splitting it into testing and training
 %with 70% / 30% training data
trainingDataInput = ycbcrData(1:171539,:);
trainingDataOutput = dataOutput(1:171539,:);

testingDataInput = ycbcrData(171539:245057,:);
testingDataOutPut = dataOutput(171539:245057,:);

% with 80% / 20% input training data
%trainingDataInput = ycbcrData(1:196045,:); 
%trainingDataOutput = dataOutput(1:196045,:); 

%testingDataInput = ycbcrData(196045:245057,:);
%testingDataOutPut = dataOutput(196045:245057,:);

% with 90% / 10% input training data
%trainingDataInput = ycbcrData(1:220551,:);
%trainingDataOutPut = dataOutput(1:220551,:);

%testingDataInput = ycbcrData(220551:245057,:);
%testingDataOutPut = dataOutput(220551:245057,:);
 
fis = anfis([trainingDataInput trainingDataOutput]);  %anfis training

evalOutput = round(evalfis(testingDataInput(:,1:3),fis));
result = evalOutput - testingDataOutPut;
skinCount = sum(result ==0);
 performance = (skinCount/length(evalOutput))*100;
 disp(performance);
