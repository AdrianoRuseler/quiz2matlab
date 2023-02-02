@title diode00 cmd test

PsimCmd.exe -LT -i "diode00.psimsch" -v "Vi=5" -v "Von=650m" -v "Ron=13m" -v "R0=820" -m "diode00msg.txt" -g

pause