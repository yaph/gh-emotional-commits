# -*- coding: utf-8 -*-
import os, csv, glob

langdata = {}

def proc_csv(fname, count_key):
    fcsv = open(fname, 'rb')
    reader = csv.reader(fcsv)
    headers = reader.next()
    for record in reader:
        lang, cnt = record
        if lang not in langdata:
            langdata[lang] = {}
        langdata[lang][count_key] = cnt
    fcsv.close()

# this file must be processed 1st so ratio are calculated correctly
proc_csv('commit_messages_langcount.csv', 'total_count')

csvfiles = glob.glob('counts_*.csv')

for csvfile in csvfiles:
    name, ext = os.path.splitext(os.path.basename(csvfile))
    proc_csv(csvfile, name)

    # create merged csv for further processing
    target = 'merged_%s%s' % (name, ext)
    ftarget = open(target, 'wb')
    writer = csv.writer(ftarget, quoting=csv.QUOTE_MINIMAL)
    writer.writerow(['language', 'percentage'])

    for lang in langdata:
        # only consider languages with at least 40000 messages
        tc = float(langdata[lang]['total_count'])
        if name not in langdata[lang] or tc < 40000:
            continue
        rc = float(langdata[lang][name])
        writer.writerow([lang, (rc/tc)*100])

    ftarget.close()

