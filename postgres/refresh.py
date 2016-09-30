import os
import re
import time
from subprocess import check_output


answer = input('Would you like to setup a local db (Y/N): ')
# uname = input('Enter your postgres username: ')
# pword = input('Do you have a password (Y/N): ')
# if (str(pword).lower == 'n'):
#     pword = ''



isLocal = True if str(answer).lower() == 'y' else False


if not os.path.isdir("stockdb") and isLocal:
    os.system("initdb --pgdata stockdb")



# os.system("ls -l");
hasFiles = os.path.isfile('./delete.sql') and \
        os.path.isfile('./create.sql') and \
        os.path.isfile('./triggers.sql') and \
        os.path.isfile('./insert.sql');
if hasFiles:
    if isLocal:
        # os.system("cd stockdb")
        os.system("pg_ctl -D stockdb -l logfile start")
        time.sleep(2)
        dbinfo = check_output(['psql','-lqt'])
        dbexists = str(dbinfo).find('stockdb') > 0
        # os.system('psql ' + uname + '-c "CREATE USER stockuser WITH PASSWORD \'stockuser\';"')
        if not dbexists:
            os.system('psql postgres -c "CREATE DATABASE stockdb;"')
        os.system("psql -d stockdb -f delete.sql")
        os.system("psql -d stockdb -f create.sql")
        os.system("psql -d stockdb -f triggers.sql")
        os.system("psql -d stockdb -f insert.sql")
else:
    print (' one of the files may be missing ')


#TODO
# print 'Would you like to setup a local db? (Y/N - Answering no will cotinue setup with an remote/online database)\n'

# dbName = os.system('psql -lqt | cut -d \| -f 1 | grep -w "stockdb"')
# dbName = os.system('psql -lqt | cut -d \| -f 1 | grep -w "stockdb"')
