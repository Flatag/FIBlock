function error_data = es_inject_error_noise(input_data,noisepercentage)

a=-noisepercentage*input_data/100;
b=+noisepercentage*input_data/100;

oscillation=rand(1)*(b-a)+a;
error_data = input_data + oscillation;

end
