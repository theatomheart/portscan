#!/bin/bash

Ports="T:3389,21,22,80,443"

InputFile=$HOME/ips.csv		# This is the CSV file with your list of IPs and names.

Outpath=$HOME/.portscan		# This is the path the output will be saved to.

Output="$(date +%Y_%b_%d).md"

Say() { echo "$*" >> $Outpath/$Output ;}
if [ ! -f $InputFile ] ; then echo "The file $InputFile is missing." && exit 1 ; fi

mkdir -p $Outpath
>$Outpath/$Output

PrintPorts="${Ports:2}"
echo "Scanning for open ports: $PrintPorts."
#echo "# Portscan looking for ports $PrintPorts" > $Outpath/$Output
Say "# Portscan looking for ports $PrintPorts"
#echo "" >> $Outpath/$Output
Say ""

while IFS="," read -r rec_column1 rec_column2
do
	nmap -Pn -p $Ports $rec_column1 > $Outpath/scan.dmp
	ScanPositive=$(cat $Outpath/scan.dmp | grep open | awk '{print $1}')
	if [[ -n $ScanPositive ]] ; then
#		echo "$rec_column2 ($rec_column1) open port: $ScanPositive" >> $Outpath/$Output
		Say "$rec_column2 ($rec_column1) open port: $ScanPositive"
#		echo "" >> $Outpath/$Output
		Say ""
	fi
done < <(tail -n +2 $InputFile)

rm $Outpath/scan.dmp &>/dev/null
