#/bin/bash
# enhanced sqlplus to save input and output trace
# USE IT ONLY INTERACTIVELY 

set -e # ends if there is ANY error, there is no file or dir, a command fails ...
if [ $# -eq 0 ]
then
cat <<EOF
USE ONLY INTERACTIVELY:
  sqlplus enriched to save input and output trace.
Use:
  sqlpluss [-f fout] user / password @ conection @scripts ...
     (fout will be opened in add mode and it will default to yyyymmdd.log)
      
summary:
  tee -a fout | sqlplus $@ |  tee -a fout
EOF
exit
fi
DIRLOG=$ADMIN_HOME/log/sqlplus_traza
NOW=`date +%Y%m%d`

if [ ! -d $DIRLOG ] ;
then
 mkdir $DIRLOG
fi

while getopts f: option
do

 case "${option}"
 in
 f) fout=${OPTARG};;
 esac

 shift "$((OPTIND - 1))"

done

FOUT=$DIRLOG/${fout-$NOW}

echo log completo en  $FOUT
echo sqlplus $@
echo ==================  >> $FOUT
echo INI:`date`:  $0 $* >> $FOUT
echo ------------------  >> $FOUT
echo sqlplus $@ >> $FOUT
