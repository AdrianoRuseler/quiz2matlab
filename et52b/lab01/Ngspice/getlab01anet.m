% =========================================================================
% ***
% *** The MIT License (MIT)
% *** 
% *** Copyright (c) 2018 AdrianoRuseler
% *** 
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% *** 
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% *** 
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================
% Get LAB01a circuit net
function [circuit]=getlab01anet(circuit)

circuit.Ngspice.name='LAB01a';
% netlistfile=[ filename '.cir'];

circuit.Ngspice.cir.name = circuit.Ngspice.name;
circuit.Ngspice.cir.file = [circuit.Ngspice.simsdir '\' circuit.Ngspice.name '.cir'];


% https://www.vishay.com/docs/89789/1n4007.txt
% .model d1n4007 d is = 1.43733E-008 n = 1.80829 rs = 0.0414712
% + eg = 1.11 xti = 3 tnom = 27
% + cjo = 2.8119E-011 vj = 0.700053 m = 0.346714 fc = 0.5
% + tt = 4.10886E-006 bv = 1100 ibv = 10 af = 1 kf = 0
% circuit.Ngspice.cir.lines{1}=

% fprintf(fid, '%s%c%c', '',13,10);
% strdata=[char(conv.param(ind)) ' = ' num2str(getfield(conv,conv.param{ind}),'%10.8e')];
circuit.Ngspice.cir.lines{1}=[circuit.Ngspice.cir.name ' Simulation'];
circuit.Ngspice.cir.lines{2}='VIPROBE00101 Net1000 NN00101 DC 0';
circuit.Ngspice.cir.lines{3}= ' R1 NN00101 0 {R1}';
circuit.Ngspice.cir.lines{4}= 'VIPROBE00102 Net1000 NN00102 DC 0';
circuit.Ngspice.cir.lines{5}= ' R2 NN00102 0 {R2}';
circuit.Ngspice.cir.lines{6}='VIPROBE00103 Net1000 NN00103 DC 0';
% fprintf(fid, '%s%c%c', ' D1 Net1001 NN00103 1n4004',13,10);
circuit.Ngspice.cir.lines{7}=' D1 Net1001 NN00103 d1n4007';
circuit.Ngspice.cir.lines{8}= 'V1 Net1001 0 {Vcc}';
circuit.Ngspice.cir.lines{9}= '.options rshunt = 1.0e12 KEEPOPINFO';
circuit.Ngspice.cir.lines{10}= '.model d1n4007 d is = 1.43733E-008 n = 1.80829 rs = 0.0414712';
circuit.Ngspice.cir.lines{11}= '+ eg = 1.11 xti = 3 tnom = 27';
circuit.Ngspice.cir.lines{12}= '+ cjo = 2.8119E-011 vj = 0.700053 m = 0.346714 fc = 0.5';
circuit.Ngspice.cir.lines{13}='+ tt = 4.10886E-006 bv = 1100 ibv = 10 af = 1 kf = 0';
% circuit.Ngspice.cir.lines{13}= '.MODEL 1N4004 D (IS=76.9n RS=42.0m  BV=400 IBV=5.00u CJO=39.8p M=0.333 N=1.45 TT=4.32u)',13,10);
% circuit.Ngspice.cir.lines{13}='.MODEL 1N4004 D (IS=76.9n RS=42.0m  BV=400 IBV=5.00u CJO=39.8p M=0.333 N=1.45 TT=4.32u)',13,10);
circuit.Ngspice.cir.lines{14}= '.param Vcc=10 R1=1000 R2=1500';
circuit.Ngspice.cir.paramline=14;

circuit.Ngspice.cir.lines{15}= '.control';
circuit.Ngspice.cir.lines{16}='OP';
circuit.Ngspice.cir.lines{17}= '* OP Let expressions, if any:';
circuit.Ngspice.cir.lines{18}= 'let cp_R1.0 = I(VIPROBE00101)';
circuit.Ngspice.cir.lines{19}= 'let cp_R2.0 = I(VIPROBE00102)';
circuit.Ngspice.cir.lines{20}= 'let cp_D1.0 = I(VIPROBE00103)';
circuit.Ngspice.cir.lines{21}= 'set filetype = ASCII';
circuit.Ngspice.cir.lines{22}= ['write ' circuit.Ngspice.cir.file '.raw Net1000 Net1001 cp_R1.0 cp_R2.0 cp_D1.0 I(V1)'];
circuit.Ngspice.cir.writeline=22;
circuit.Ngspice.cir.writevars=' Net1000 Net1001 cp_R1.0 cp_R2.0 cp_D1.0 I(V1)';
circuit.Ngspice.cir.lines{23}= 'set appendwrite true';

circuit.Ngspice.cir.lines{24}= 'rusage everything';
circuit.Ngspice.cir.lines{25}= '.endc';
circuit.Ngspice.cir.lines{26}= '.end';

circuit.Ngspice.cir.lines=circuit.Ngspice.cir.lines';
% system(['ngspice -b -o ' filename '.log ' filename '.cir']);
% 
% system(['ngspice_con ' filename '.cir']); % Como silenciar o log?
% 
% [header,variables,data] = rawspice6([filename '.raw']);

% clc

% vR vV iR1 iR2 iD1 iV
