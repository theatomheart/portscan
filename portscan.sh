#!/bin/sh

PortsToScan=T:3389,21,22,80,443

InputFile=$HOME/ips.csv

Outpath=$HOME/.portscan		# This is the path the output will be saved to

if [ ! -f $InputFile ] ; then echo "The file $InputFile is missing." && exit 1 ; fi

Output="$(date +%Y_%b_%d).md"

mkdir -p $Outpath
>$Outpath/$Output
echo "Scanning for open ports: $PortsToScan."
while IFS="," read -r rec_column1 rec_column2
do
  echo "Scanning $rec_column2 WAN IP $rec_column1."
  nmap -Pn -p $PortsToScan $rec_column1 > ~ $Outpath/scan.dmp
  ScanPositive=$(cat $Outpath/scan.dmp | grep open | awk '{print $1}')
  [[ $ScanPositive ]] && echo "$rec_column1 ($rec_column2) open port: $ScanPositive" >> $Outpath/$Output
done < <(tail -n +2 $InputFile)
