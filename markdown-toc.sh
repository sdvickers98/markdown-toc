#!/bin/bash


# It's worth noting that this script works best if you don't skip header
# sizes when going from a larger size to a smaller size, otherwise the 
# indentation will look weird. In other words, you don't want to skip from 
# an h1 to h3 or h4, or skip from an h2 to h4. When going from a smaller
# header size to a larger one, this doesn't matter.
#
# Because of this, your first header must be an h1.
#
# Another note is that if you use the hash symbol for anything other than 
# headers (such as comments in code blocks), this script will generate a ToC
# entry for those lines and you will need to manually remove them.
#
# Basically, this script kinda sucks lol, but it works okay if you don't
# mind doing a small bit of manual work in certain scenarios.

cat $1 | while read line; do # iterate through lines in the file
    if [[ ${line:0:5} == "#### " ]]; then # if an h4 is found

        # get length of substring that leaves out the '#' symbols
        end=${#line}-5 

        # generate the text that will be seen in the ToC
        link_text="${line:5:$end}" 
        
        # generate the link by making all characters lower case and replacing
        # all spaces with dashes
        link=$(echo $link_text | tr " " "-" | tr '[:upper:]' '[:lower:]') 

        # put everything together with the proper indentation
        toc="\t\t\t* [$link_text](#$link)\n"

        # display this ToC entry
        printf "${toc}"
    elif [[ ${line:0:4} == "### " ]]; then # if an h3 is found
        end=${#line}-4
        link_text="${line:4:$end}"
        link=$(echo $link_text | tr " " "-" | tr '[:upper:]' '[:lower:]')
        toc="\t\t* [$link_text](#$link)\n"
        printf "${toc}"
    elif [[ ${line:0:3} == "## " ]]; then # if an h2 is found
        end=${#line}-3
        link_text="${line:3:$end}"
        link=$(echo $link_text | tr " " "-" | tr '[:upper:]' '[:lower:]')
        toc="\t* [$link_text](#$link)\n"
        printf "${toc}"
    elif [[ ${line:0:2} == "# " ]]; then # if an h1 is found
        end=${#line}-2
        link_text="${line:2:$end}"
        link=$(echo $link_text | tr " " "-" | tr '[:upper:]' '[:lower:]')
        toc="* [$link_text](#$link)\n"
        printf "${toc}"
    fi
done

