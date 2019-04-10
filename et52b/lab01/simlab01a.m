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
% Simula circuito Lab 01a
function [circuit]=simlab01a(circuit)

filename='LAB01a';
netlistfile=[ filename '.cir'];

[fid,errmsg] = fopen(netlistfile,'w');
t=0; 
while fid < 0 
   t=t+1;
   disp('Erro ao abrir o arquivo para escrita!')
   disp(errmsg);
   filename=['LAB01at' num2str(t)];
   netlistfile=[ filename '.cir'];
   [fid,errmsg] = fopen(netlistfile,'w');
end

% https://www.vishay.com/docs/89789/1n4007.txt
% .model d1n4007 d is = 1.43733E-008 n = 1.80829 rs = 0.0414712
% + eg = 1.11 xti = 3 tnom = 27
% + cjo = 2.8119E-011 vj = 0.700053 m = 0.346714 fc = 0.5
% + tt = 4.10886E-006 bv = 1100 ibv = 10 af = 1 kf = 0

% fprintf(fid, '%s%c%c', '',13,10);
% strdata=[char(conv.param(ind)) ' = ' num2str(getfield(conv,conv.param{ind}),'%10.8e')];
fprintf(fid, '%s%c%c', [filename ' Simulation'],13,10);
fprintf(fid, '%s%c%c', 'VIPROBE00101 Net1000 NN00101 DC 0',13,10);
fprintf(fid, '%s%c%c', [' R1 NN00101 0 ' num2str(R1)],13,10);
fprintf(fid, '%s%c%c', 'VIPROBE00102 Net1000 NN00102 DC 0',13,10);
fprintf(fid, '%s%c%c', [' R2 NN00102 0 ' num2str(R2)],13,10);
fprintf(fid, '%s%c%c', 'VIPROBE00103 Net1000 NN00103 DC 0',13,10);
% fprintf(fid, '%s%c%c', ' D1 Net1001 NN00103 1n4004',13,10);
fprintf(fid, '%s%c%c', ' D1 Net1001 NN00103 d1n4007',13,10);
fprintf(fid, '%s%c%c', ['V1 Net1001 0 ' num2str(Vcc)],13,10);
fprintf(fid, '%s%c%c', '.options rshunt = 1.0e12 KEEPOPINFO',13,10);
fprintf(fid, '%s%c%c', '.model d1n4007 d is = 1.43733E-008 n = 1.80829 rs = 0.0414712',13,10);
fprintf(fid, '%s%c%c', '+ eg = 1.11 xti = 3 tnom = 27',13,10);
fprintf(fid, '%s%c%c', '+ cjo = 2.8119E-011 vj = 0.700053 m = 0.346714 fc = 0.5',13,10);
fprintf(fid, '%s%c%c', '+ tt = 4.10886E-006 bv = 1100 ibv = 10 af = 1 kf = 0',13,10);
% fprintf(fid, '%s%c%c', '.MODEL 1N4004 D (IS=76.9n RS=42.0m  BV=400 IBV=5.00u CJO=39.8p M=0.333 N=1.45 TT=4.32u)',13,10);
% fprintf(fid, '%s%c%c', '.MODEL 1N4004 D (IS=76.9n RS=42.0m  BV=400 IBV=5.00u CJO=39.8p M=0.333 N=1.45 TT=4.32u)',13,10);
fprintf(fid, '%s%c%c', '.control',13,10);
fprintf(fid, '%s%c%c', 'OP',13,10);
fprintf(fid, '%s%c%c', '* OP Let expressions, if any:',13,10);
fprintf(fid, '%s%c%c', 'let cp_R1.0 = I(VIPROBE00101)',13,10);
fprintf(fid, '%s%c%c', 'let cp_R2.0 = I(VIPROBE00102)',13,10);
fprintf(fid, '%s%c%c', 'let cp_D1.0 = I(VIPROBE00103)',13,10);
fprintf(fid, '%s%c%c', ['write ' filename '.raw Net1000 Net1001 cp_R1.0 cp_R2.0 cp_D1.0 I(V1)'],13,10);
fprintf(fid, '%s%c%c', 'set appendwrite true',13,10);
fprintf(fid, '%s%c%c', 'rusage everything',13,10);
fprintf(fid, '%s%c%c', '.endc',13,10);
fprintf(fid, '%s%c%c', '.end',13,10);
fclose(fid);

% system(['ngspice -b -o ' filename '.log ' filename '.cir']);

system(['ngspice_con ' filename '.cir']); % Como silenciar o log?

[header,variables,data] = rawspice6([filename '.raw']);

% clc

% vR vV iR1 iR2 iD1 iV
