uiCallbacks = struct;
uiCallbacks.setup = @setup;
uiCallbacks.calculate = @calculate;
uiCallbacks.home = @home;
uiCallbacks.simulate = @simulate;
uiCallbacks.onload = @onload;

function [] = setup()
    ui;
end

function [] = onload(hObject, eventdata, handles)
    home(hObject, eventdata, handles);
end

function [] = calculate(hObject, eventdata, handles)
    % set up handle arrays
    [handle_in_p, handle_in_q, handle_out_p, handle_out_q] = extractHandles(handles);

    % read data
    [p_data, p_is_defined] = readData(handle_in_p);
    [q_data, q_is_defined] = readData(handle_in_q);

    if p_is_defined
        q_data = backward(p_data);
    elseif q_is_defined
        p_data = forward(q_data);
    else
        home(hObject, eventdata, handles);
        
        return;
    end
    
    setData(handle_out_p, round(p_data, 2));
    setData(handle_out_q, round(q_data, 2));
    
    resetData(handle_in_p);
    resetData(handle_in_q);
    
    axes(handles.axes1);
    roboplot(q_data);
end

function [] = home(hObject, eventdata, handles)
    % set up handle arrays
    [handle_in_p, handle_in_q, handle_out_p, handle_out_q] = extractHandles(handles);

    q_data = zeros(6, 1);
    p_data = forward(q_data);
    
    setData(handle_out_p, round(p_data, 2));
    setData(handle_out_q, round(q_data, 2));

    resetData(handle_in_p);
    resetData(handle_in_q);
    
    axes(handles.axes1);
    roboplot(q_data);
end

function [] = simulate(hObject, eventdata, handles)
    disp("simulate todo");
end

%% HELPER FUNCTIONS

function [handle_in_p, handle_in_q, handle_out_p, handle_out_q] = extractHandles(handles)
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
end

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
