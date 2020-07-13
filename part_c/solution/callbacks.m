uiCallbacks = struct;
uiCallbacks.setup = @setup;
uiCallbacks.calculate = @calculate;

function [] = setup()
    ui;
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

    if p_is_defined
        setData(handle_out_p, p_data);
    elseif q_is_defined
        setData(handle_out_q, q_data);
    end
    
    resetData(handle_in_p);
    resetData(handle_in_q);
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
