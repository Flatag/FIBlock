function error_data = es_inject_error_gen(obj, time_data)
    if (strcmp(obj.fault_type, 'Sensor: Noise'))
        error_data = es_inject_error_noise(time_data, obj.fault_value);
    elseif (strcmp(obj.fault_type, 'Sensor: Offset'))
        error_data = time_data + obj.fault_value;
    elseif (strcmp(obj.fault_type, 'Hardware: Bit flips'))
        error_data = es_inject_error_bitflip(time_data, obj.fault_value);
    elseif (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
        error_data = obj.stuck_value;
    elseif (strcmp(obj.fault_type, 'Network: Time delay'))
        error_data = obj.past_output(obj.counter - obj.delay_counter);
    else
        error_data = obj.fault_value;
    end
    %disp(obj.fault_type);
    %disp(error_data);
end