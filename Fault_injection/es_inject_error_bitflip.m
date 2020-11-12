function error_data = es_inject_error_bitflip( input_data, number_of_bitflips )

%input_data=int8(input_data); % Temporary Solution

    var_info = whos('input_data');
    var_type = var_info.class;
    bits = uint32(8 * var_info.bytes);
    if bits == 8
        cast_data_type = 'uint8';
    elseif bits == 16
        cast_data_type = 'uint16';
    elseif bits == 32
        cast_data_type = 'uint32';
    elseif bits == 64
        cast_data_type = 'uint64';
    else
        %disp('es_make_error check 1!');
        cast_data_type = 'uint64';
        data = 'unknown_type';
        return
    end
    
    if strcmp(var_type, 'uint8') || strcmp(var_type, 'uint16') || strcmp(var_type, 'uint32') || strcmp(var_type, 'uint64')
        res_data = es_invert_bit(input_data, cast_data_type,number_of_bitflips,bits);
    else
        data_cast = typecast(input_data, cast_data_type);
        data_cast = es_invert_bit(data_cast, cast_data_type,number_of_bitflips,bits);
        res_data = typecast(data_cast, var_type);
    end

    error_data = double(res_data);

    
end



function data = es_invert_bit(in_data, data_type,number_of_bitflips,bits)

for n = 1:number_of_bitflips
    bit_number = uint32(randi(bits));
    xor_with = cast(2 ^ (bit_number - 1), data_type);
    data = bitxor(in_data, xor_with, data_type);
    in_data=data;
end

data = in_data;

end
