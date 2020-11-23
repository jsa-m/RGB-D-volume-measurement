clear
%Test script to measure volume

dir = "";
ptCloudInicial = pcread(dir);

%Como vemos en un estado inicial la nube de puntos no esta en un
%orientacion correcta para trabajar con ella
figure(1)
pcshow(ptCloudInicial)
%ptCloudInicial = pcdownsample(ptCloudInicial, 'gridAverage', 0.005);

%
% %Reducimos la zona de interes para poder segmentar correctamente el plano
% inferior.

%Ajuste manual (prueba de concepto)
ptCloudRoi = reduceROI(ptCloudInicial, [-0.15 0.2], [-0.2 0.2]);

%FIT PLANE
maxDist = 0.005;
maxAngDist = 15;
ptCloudBA = alineaNube(ptCloudRoi,maxDist,maxAngDist);
%figure(3)
%pcshow(ptCloudBA)

%Segment top and bottom planes
%FIT PLANE
maxDist = 0.01;
refVector = [0 0 1];
maxAngDist = 5;

[model, inlierIdx, outlierIdx] = pcfitplane(ptCloudBA, maxDist, refVector, maxAngDist);
pcplanetop = select(ptCloudBA,outlierIdx);
pcplanebott = select(ptCloudBA, inlierIdx);
%figure(4)
%pcshow(pcplanetop)
%figure(5)
%pcshow(pcplanebott)
%Heuristic adjustment
pcplanetop = pcdenoise(pcplanetop,'NumNeighbors',2400, 'Threshold',0.8);
pcplanetop = pcdownsample(pcplanetop, 'gridAverage', 0.003);
pcshow(pcplanetop);
%figure(6)
%pcshow(pcplanebott)
height = calculaAltura(pcplanetop, pcplanebott);
area = calculaArea(pcplanetop);
volume = height*area