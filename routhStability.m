function [table, unstableRoots] = routhStability(coeffs)
degree = length(coeffs);
len = ceil(degree./2);
height = degree - 2;
table = zeros(height, len);
row = 1;
column = 1;
index = 1;
rowOfZeros = false;
% Start off the table
while column < degree + 1 && index < degree + 1
    table(row, column) = coeffs(index);
    if row == 2
        column = column + 1;
        row = 1;
    else
        row = 2;
    end
    index = index + 1;
end
row = 3;
column = 1;
for i = 1:(len.*height)
    % Cover all 0s row edge case
    if prevLine(table(end,1:len)) == len
        if len - prevLine(table(end - 1, 1:len)) > 1
            poly = table(end - 1, 1: len);
            for k = 1:length(poly)
                poly(k) = poly(k).*(length(poly) - k).^2;
            end
            poly(end) = 0;
            table(end, 1:len) = poly;
            rowOfZeros = true;
        end
    end
    if column ~= len
        divisor = table(row - 1, 1);
        posTerm = divisor.*table(row - 2, column + 1);
        negTerm = table(row - 2, 1).*table(row - 1, column + 1);
        %cover 0 followed by number case
        if divisor == 0 && table(row - 1, column + 1) ~= 0
            % Pos or Neg infinity?
            if table(row - 2, 1).*table(row - 1, column + 1) > 0
                table(row, column ) = log(0);
            else
                table(row, column) = 1.e1000;
            end
            % Prevent division by Inf
        elseif divisor == Inf || divisor == -Inf
            table(row, column) = table(row - 2, column + 1);
            % Prevent division by 0 for unecessary addition
        elseif divisor == 0 && table(row - 1, column + 1) == 0
            table(row, column) = 0;
        else
            table(row, column) = (posTerm - negTerm)./divisor;
        end
        column = column + 1;
    else
        column = 1;
        row = row + 1;
    end
end
% Cover weird edge case where an uneccesary line was added to the bottom
if prevLine(table(end - 2, 2:end)) + prevLine(table(end - 1, 1:end)) == len.*2 - 2
    table = table(1:(end - 1), 1:end)
end
column = 1;
% Assume starts at positive
positive = true;
unstableRoots = 0;
for row = 1:(degree - 1)
    if table(row, column) < 0 && positive
        unstableRoots = unstableRoots + 1;
        positive = false;
    elseif table(row, column) > 0 && ~positive
        unstableRoots = unstableRoots + 1;
        positive = true;
    end
end
% Cover marginally Stable case
if rowOfZeros && unstableRoots == 0
    unstableRoots = 'Marginally Stable'
elseif unstableRoots == 0
    unstableRoots = 'Stable';
else
    unstableRoots = ['Unstable with ', num2str(unstableRoots), ' Unstable Roots'];
end