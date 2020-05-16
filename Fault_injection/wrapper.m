function [error_data, error_flag] = wrapper(data, time, name, flag)
d = data;
t = time;
n = name;
f = flag;
error_data = d;
error_flag = 0;
global finjectors;
ff = 2;
try 
    ff = finjectors(n);
catch
    ne = n;
    warning('NOT EXIST');
    warning(n);
    %disp(n);
end
%disp(ff);
if ff ~= 2
    if (ff.fexp_flag == 1)
        if (f > 0 && ff.fail_trigger ~= 1)
            ff.setfail_trigger(1);
            %disp(time);
        elseif f <= 0
            ff.setfail_trigger(0);
        end
        error_data = ff.finject(d, t);
        error_flag = ff.fail_flag;
        %disp('injecting');
    end
end

%global faultdatas;
%faultdatas = containers.Map;
%faultdatas(n) = error_data;
%disp('____________________');
end