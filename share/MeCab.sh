#!/bin/sh


if [ ! -e user.dic ]; then
    where mecab-dict-index
    /usr/local/libexec/mecab/mecab-dict-index \
        -d /usr/local/lib/mecab/dic/mecab \
        -u user.dic -f UTF8 -t UTF8 MeCab.csv
fi
