function error_data = es_inject_error_gen_fpr_once(obj, error_data)
    if (strcmp(obj.fault_type, 'Network: Time delay'))
        obj.setpast_output(error_data);
        obj.incrcounter;
    end
    if (obj.fail_flag == 1 && strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
        error_data = es_inject_error_gen(obj, error_data);
        obj.setfail_flag(3); %TODO check if delete ff1
        return;
    end
    if (obj.fail_flag == 0)
        randomNum = rand;
        if (randomNum > 1 - obj.event_value || obj.fail_trigger == 1)
            obj.setfail_flag(1);
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                obj.incrdelay_counter;
            end
            if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                obj.setstuck_value(error_data);
            end
            error_data = es_inject_error_gen(obj, error_data);
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                obj.incrdelay_counter;
            end
        end
    elseif (obj.fail_flag == 1 && strcmp(obj.fault_type, 'Network: Time delay'))
        error_data = es_inject_error_gen(obj, error_data);
    end
end

