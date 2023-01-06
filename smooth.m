function new_data = smooth(data)
    if length(data(:,1))> 1
        data = transpose(data);
    end
    data_matrix = [data(3:end) 0 0;2.*data(2:end) 0;3.*data;0 ...
        2.*data(1:end-1);0 0 data(1:end-2)];
    new_data = sum(data_matrix)./9;

end