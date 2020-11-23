function [height] = calculateHeight(pcplanetop, pcplanebottom)
%calculateHeight.m From the top and bottom planes calculates the height
%of the liquid.
%Input:
% pcplanetop: pointcloud of the top plane
% pcplanebottom: pointcloud of the bottom plane
%Output:
% height: distance between the top and bottom plane without outliers.
% 
zplanetop = pcplanetop.Location(:,3);
zbottom = (pcplanebottom.Location(:,3));
%Eliminacion de outliers suelo
iqr_zsuelo = iqr(zbottom);
Q1 = quantile(zbottom, 0.75);
Q3 = quantile(zbottom, 0.25);
z_bottom_no_outlier = [];
for i=1 : length(zbottom)
if (zbottom(i) > (Q1 -1.5*iqr_zsuelo) && zbottom(i) < (Q3 + 1.5*iqr_zsuelo))
z_bottom_no_outlier = [z_bottom_no_outlier zbottom(i)];
end
end
%Median z bottom
median_bottom = median(z_bottom_no_outlier);
%Eliminacion de outliers plano superior.
iqr_ztop = iqr(zplanetop);
Q1 = quantile(zplanetop, 0.75);
Q3 = quantile(zplanetop, 0.25);
z_top_no_outlier = [];
for i=1 : length(zplanetop)
if (zplanetop(i) > (Q1 -1.5*iqr_ztop) && zplanetop(i) < (Q3 + 1.5*iqr_ztop))
z_top_no_outlier = [z_top_no_outlier zplanetop(i)];
end
end
%Median z top
median_top = median(z_top_no_outlier);
%Height of the liquid
height = abs(median_bottom - median_top);
end