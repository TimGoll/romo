path_arr = strsplit(mfilename('fullpath'), {'/', '\'});
path_arr(end) = [];
base_path = strjoin(path_arr, '/');

addpath(base_path + "/robot/");
