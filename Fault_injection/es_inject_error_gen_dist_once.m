function error_data = es_inject_error_gen_dist_once(obj, error_data, simul_time)
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
        if (isobject(obj.event_value))
            if (randomNum > 1 - pdf(obj.event_value, simul_time) || obj.fail_trigger == 1)
                obj.setfail_flag(1);
                if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                    obj.setstuck_value(error_data);
                end
                if (strcmp(obj.fault_type, 'Network: Time delay'))
                    obj.incrdelay_counter;
                end
                obj.setfail_time(simul_time); %TODO check delete this line
                error_data = es_inject_error_gen(obj, error_data);
                if (strcmp(obj.fault_type, 'Network: Time delay'))
                    obj.incrdelay_counter;
                end
            end
        else
            if (randomNum > 1 - es_manual_dist_interpolation(simul_time, obj.event_value) || obj.fail_trigger == 1)
                obj.setfail_flag(1);
                if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                    obj.setstuck_value(error_data);
                end
                if (strcmp(obj.fault_type, 'Network: Time delay'))
                    obj.incrdelay_counter;
                end
                obj.setfail_time(simul_time); %TODO check delete this line
                error_data = es_inject_error_gen(obj, error_data);
                if (strcmp(obj.fault_type, 'Network: Time delay'))
                    obj.incrdelay_counter;
                end
            end     
        end
    elseif (obj.fail_flag == 1 && strcmp(obj.fault_type, 'Network: Time delay'))
        error_data = es_inject_error_gen(obj, error_data);
    end
end

