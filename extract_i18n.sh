#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsa4w/locale

pot-create -o unicorecmsa4w/locale/unicorecmsa4w.pot unicorecmsa4w/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsa4w/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsa4w/locale/""$lang""/LC_MESSAGES/unicorecmsa4w.po" ]; then
        msginit -l $lang -i unicorecmsa4w/locale/unicorecmsa4w.pot -o unicorecmsa4w/locale/$lang/LC_MESSAGES/unicorecmsa4w.po
    fi

    msgmerge --update unicorecmsa4w/locale/$lang/LC_MESSAGES/unicorecmsa4w.po unicorecmsa4w/locale/unicorecmsa4w.pot
    msgfmt unicorecmsa4w/locale/$lang/LC_MESSAGES/*.po -o unicorecmsa4w/locale/$lang/LC_MESSAGES/unicorecmsa4w.mo
done
