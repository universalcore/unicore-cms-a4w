echo 'starting ve'
virtualenv ve
source ve/bin/activate
echo 'Starting webserver..'
pserve development.ini --reload &
sass --watch unicorecmsa4w/static/sass:unicorecmsa4w/static/css
kill %1
echo 'done'
