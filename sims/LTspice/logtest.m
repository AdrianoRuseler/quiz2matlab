clear all
clc

circuit.dir = getsimdir('logtest.m'); % Sets simulation dir
circuit.LTspice.log.file=[circuit.dir 'DR01op.log'];

%%

[circuit] = ltlogread(circuit);

%%



% tline=circuit.LTspice.log.lines;

