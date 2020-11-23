function [area] = calculateArea(pcplanetop)
%calculateArea.m From a segmented pointcloud of the top surface of the 
%liquid calculate the area.
%Input:
% pcplanetop : pointcloud of the top surface
%Salida:
% area : area of the top surface
%x,y coordinates of the cloud.
x=double(pcplanetop.Location(:,1));
y=double(pcplanetop.Location(:,2));
P = [x y];
%Index of the points that form the convex hull
[k] = convhull(P);
%Calculate area
len = length(k);
sum1 = 0;
sum2 = 0;
for i=1:1:(len-1)
sum1 = sum1 + P(k(i),1)*P(k(i+1),2);
sum2 = sum2 + P(k(i+1),1)*P(k(i),2);
end
area = 1/2*(sum1 + P(k(len),1)*P(k(1),2) - sum2 -P(k(1),1)*P(k(len),2));
end