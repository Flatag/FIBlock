function error_data = es_inject_error_gen_mttf_constime(obj, error_data, simul_time)
    if (strcmp(obj.fault_type, 'Network: Time delay'))
        obj.setpast_output(error_data);
        obj.incrcounter;
    end
    if (obj.fail_flag == 0 && obj.fail_time == 0)
        obj.setfail_time(random(makedist('Normal', 'mu', obj.event_value)));
    end
    if (obj.fail_flag == 0)
        if (simul_time > obj.fail_time || obj.fail_trigger == 1)
            obj.setfail_flag(1);
            obj.setfail_time(simul_time);
            if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                obj.setstuck_value(error_data);
            end
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                obj.incrdelay_counter;
            end
        elseif (obj.delay_counter ~= 0 && strcmp(obj.fault_type, 'Network: Time delay'))
            error_data = es_inject_error_gen(obj, error_data);
        end
    end
    if (obj.fail_flag == 1)
        if(simul_time >= obj.effect_value + obj.fail_time)
            obj.setfail_flag(0);
            obj.setfail_time(simul_time+random(makedist('Normal', 'mu', obj.event_value)));
            if (strcmp(obj.fault_type, 'Sensor: Stuck-at fault'))
                obj.setstuck_value(error_data); %TODO check if delete ff1
            end
            if (strcmp(obj.fault_type, 'Network: Time delay'))
                error_data = es_inject_error_gen(obj, error_data);
                obj.dicrdelay_counter;
            end
        end
    end
    if (obj.fail_flag == 1)
        error_data = es_inject_error_gen(obj, error_data);
        if (simul_time ~= 0 && strcmp(obj.fault_type, 'Network: Time delay'))
            obj.incrdelay_counter;
        end
    end
end

