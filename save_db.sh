#! /bin/sh  collin_m
DATE=`date '+%Y.%m.%d-%H:%M:%S'` # backup date
FOLDER=/path/to/your/backup/folder
# folder to save the backup
MYSQLUSER=root # Mysql user
MYSQLPASSWD=pwd # Mysql password (let empty if no password)
DATABASES=`mysql -u $MYSQLUSER -p$MYSQLPASSWD -e 'SHOW DATABASES' | sed '1,2d'`
# Get a list of databases
[ -d $FOLDER ] || mkdir $FOLDER
# In case of the backup's folder is not created yet

# loop of the databases
for i in $DATABASES; do
echo "Dumping $i... database" in $FOLDER ;
mysqldump -u $MYSQLUSER -p$MYSQLPASSWD $i > $FOLDER/$i.$DATE.sql ;
done

echo "`echo $DATABASES | wc -w` Databases were backed up in $FOLDER"
cd $FOLDER
zip backup_db_$DATE.zip ./*.sql
echo "ZIP DONE!" # Hope so
rm *.sql
cd - # Go back