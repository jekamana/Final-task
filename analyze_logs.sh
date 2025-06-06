#!/bin/bash

tot_requests=$(wc -l < access.log)

uniq_ip=$(awk '{ip[$1]++} END {print length(ip)}' access.log)

get_count=$(awk -F\" '{ split($2, a," "); if (a[1]=="GET") c++ } END {print c+0}' access.log)
post_count=$(awk -F\" '{ split($2, a," "); if (a[1]=="POST") c++ } END {print c+0}' access.log)

pop_url=$(awk '{urls[$7]++} END {max=0; for (i in urls) if (urls[i]>max) {max=urls[i]; top=i} print top}' access.log)

{
    printf "Total requests:%8d\n" "$tot_requests"
    printf "Total uniq IP:%8d\n" "$uniq_ip"

    echo "Total methods requests:"
    echo "    $get_count GET"
    echo "    $post_count POST"
    echo
    echo -n "The most popular URL:    "
    echo "$pop_url"
} > report.txt
