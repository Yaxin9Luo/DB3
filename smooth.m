%% smooth signal by weighted average algorithm
function new_data = smooth(data)
%5 points weighted average smooth method
%Input: data in array
%Output: new_data = smoothed data
    if length(data(:,1))> 1
        data = transpose(data);
    end
% original data in matrix, first row = 1*left shift 2 data points
% second row = 2 * left shift 1 data point
% third row = original data array
% fourth row = 2 * right shifted one data point
% fifth row = 1 * right shifted 2 data points
    data_matrix = [data(3:end) 0 0;2.*data(2:end) 0;3.*data;0 ...
        2.*data(1:end-1);0 0 data(1:end-2)];
% 1*X_(i-2)+2*X_(i-1)+3*X+2*X_(i+1)+1*X_(i+1) / 9 
    new_data = sum(data_matrix)./9;

end