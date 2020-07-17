uiCallbacks = struct;
uiCallbacks.setup = @setup;
uiCallbacks.calculate = @calculate;
uiCallbacks.home = @home;
uiCallbacks.simulate = @simulate;

function [] = setup()
    ui;
    
    home();
end

function [] = calculate(hObject, eventdata, handles)
    % set up handle arrays
    handle_in_p = [
        handles.in_x
        handles.in_y
        handles.in_z
        handles.in_a
        handles.in_b
        handles.in_c
    ];

    handle_in_q = [
        handles.in_q1
        handles.in_q2
        handles.in_q3
        handles.in_q4
        handles.in_q5
        handles.in_q6
    ];

    handle_out_p = [
        handles.out_x
        handles.out_y
        handles.out_z
        handles.out_a
        handles.out_b
        handles.out_c
    ];

    handle_out_q = [
        handles.out_q1
        handles.out_q2
        handles.out_q3
        handles.out_q4
        handles.out_q5
        handles.out_q6
    ];

    % read data
    [p_data, p_is_defined] = readData(handle_in_p);
    [q_data, q_is_defined] = readData(handle_in_q);
    
    Qstart = [RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361)].';

    
    if p_is_defined
        q_data = round(backward(p_data,Qstart), 2);
    elseif q_is_defined
        p_data = round(forward(q_data), 2);
    end
    
    setData(handle_out_p, p_data);
    setData(handle_out_q, q_data);
    
    resetData(handle_in_p);
    resetData(handle_in_q);
    
    axes(handles.axes1);
    roboplot(q_data);
end

function [] = home(hObject, eventdata, handles)
    disp("Home todo");
end

function [] = simulate(hObject, eventdata, handles)
     % set up handle arrays
    handle_in_p = [
        handles.in_x
        handles.in_y
        handles.in_z
        handles.in_a
        handles.in_b
        handles.in_c
    ];

    handle_in_q = [
        handles.in_q1
        handles.in_q2
        handles.in_q3
        handles.in_q4
        handles.in_q5
        handles.in_q6
    ];

    handle_out_p = [
        handles.out_x
        handles.out_y
        handles.out_z
        handles.out_a
        handles.out_b
        handles.out_c
    ];

    handle_out_q = [
        handles.out_q1
        handles.out_q2
        handles.out_q3
        handles.out_q4
        handles.out_q5
        handles.out_q6
    ];

    % read data
    [p_data, p_is_defined] = readData(handle_in_p);
    [q_data, q_is_defined] = readData(handle_in_q);
    [p_data2, p2_is_defined] = readData(handle_out_p);
    [q_data2, q2_is_defined] = readData(handle_out_q);
    
%     Qstart = [RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361)].';

    
    if p_is_defined
        q_data = round(backward(p_data,q_data2), 2);
    elseif q_is_defined
        p_data = round(forward(q_data), 2);
    end
     disp(p_data2);
    disp(p_data);
    
    setData(handle_out_p, p_data);
    setData(handle_out_q, q_data);
    
    resetData(handle_in_p);
    resetData(handle_in_q);
%     p_data2 = [-1180 -260 10 90 0 0].';
%     p_data = [-471 -782.73 201.03 -179.88 -24.48 -158].';
    axes(handles.axes1);
    n=1000;
    simulateRobo(p_data2,p_data,n,q_data2);
end

%% HELPER FUNCTIONS

function [data, is_defined] = readData(tags)
    tag_size = size(tags, 1);
    
    data = zeros(tag_size, 1);
    is_defined = false;

    for i = 1 : tag_size
        in = get(tags(i), "String");
        
        if in == ""
            data(i) = 0.0;
        else
            data(i) = str2double(in);
            is_defined = true;
        end
    end
end

function [] = setData(tags, values)
    tag_size = size(tags, 1);
    
    for i = 1 : tag_size
        set(tags(i), "String", values(i));
    end
end

function [] = resetData(tags)
    tag_size = size(tags, 1);
    
    values = cell(tag_size, 1);
    
    for i = 1 : tag_size
        values{i} = "";
    end
    
    setData(tags, values);
end
