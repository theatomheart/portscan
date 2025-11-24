#!/bin/sh

Ports="T:3389,21,22,80,443"

InputFile=$HOME/ips.csv

Outpath=$HOME/.portscan		# This is the path the output will be saved to
mkdir -p $Outpath

if [ ! -f $InputFile ] ; then echo "The file $InputFile is missing." && exit 1 ; fi

Output="$(date +%Y_%b_%d).md"

#>$Outpath/$Output
echo "Scanning for open ports: $Ports."
while IFS="," read -r rec_column1 rec_column2
do
  echo "Scanning $rec_column2 WAN IP $rec_column1."
#  echo "This is test output" >> $Outpath/scan.dmp
#  echo "nmap would have scanned $rec_column1 for the client $rec_column2" >> $Outpath/scan.dmp
#  nmap -Pn -p "$Ports" "$rec_column1" > $Outpath/scan.dmp
#  ScanPositive=$(cat $Outpath/scan.dmp | grep open | awk '{print $1}')
#  if [ -z $ScanPositive ] ; then echo "$rec_column1 ($rec_column2) open port: $ScanPositive" >> $Outpath/$Output ; fi
done < $(tail -n +2 $InputFile)
