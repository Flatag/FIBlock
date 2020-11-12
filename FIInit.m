%function FIInit
p = Simulink.Mask.get(gcb);
FIBname = p.getParameter('FIBlockName');
FIBtype = p.getParameter('FaultType');
if FIBtype.Value == "Stuck-at"
    FaultType = "Sensor: Stuck-at fault";
elseif FIBtype.Value == "Package drop"
    FaultType = "Network: Package drop";
elseif FIBtype.Value == "Noise"
    FaultType = "Sensor: Noise";
elseif FIBtype.Value == "Bit flips"
    FaultType = "Hardware: Bit flips";
elseif FIBtype.Value == "Time delay"
    FaultType = "Network: Time delay";
else
    FaultType = "Sensor: Offset";
end
FIBvalue = p.getParameter('FaultValue');
FIBevent = p.getParameter('FaultEvent');
FIBeventval = p.getParameter('EventValue');
FIBeffect = p.getParameter('FaultEffect');
FIBeffectval = p.getParameter('EffectValue');
global finjectors;
finjectors = containers.Map;
if isempty(str2num(FIBvalue.Value))
    BaseFIBvalue = evalin('base', FIBvalue.Value);
else
    BaseFIBvalue = str2double(FIBvalue.Value);
end
if isempty(str2num(FIBeventval.Value))
    BaseFIBeventval = evalin('base', FIBeventval.Value);
else
    BaseFIBeventval = str2double(FIBeventval.Value);
end
if isempty(str2num(FIBeffectval.Value))
    BaseFIBeffectval = evalin('base', FIBeffectval.Value);
else
    BaseFIBeffectval = str2double(FIBeffectval.Value);
end
finjectors(FIBname.Value) = FaultInjector(FaultType, BaseFIBvalue, FIBevent.Value, BaseFIBeventval, FIBeffect.Value, BaseFIBeffectval);
try
  baseFI = evalin('base','finjectors');
catch
  baseFI = [];
  assignin('base','finjectors', finjectors);
end
%disp(baseFI);
finjectors = [baseFI; finjectors];
assignin('base', 'finjectors', finjectors);

%assignin('base','finjectors', finjectors);
faultinjector = finjectors(FIBname.Value);
faultinjector.reset_fi;
FInjEnable = p.getParameter('FInjEnable');
if FInjEnable.Value == "on"
    faultinjector.fexpflag_1;
else
    faultinjector.fexpflag_0;
end
%disp('new');
%disp(FIBname.Value);
%disp(faultinjector);