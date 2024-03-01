#!/bin/bash


# This script only supports h1 through h3. Any headers with size smaller than h3 
# will not have a ToC entry created for them.
#
# The script also assumes that your first header will be an h1. If you start with
# any header size smaller than that, it will be indented.
#
# Another note is that if you use the hash symbol for anything other than 
# headers (such as comments in code blocks), this script will generate a ToC
# entry for those lines and you will need to manually remove them.

prev_header=1 # keeps track of the previous header size
indent="" # keeps track of the current level of indentation
section_header=1 # keeps track of the header size for the current overarching "section"
                 # this will become clearer later on in the code

cat $1 | while read line; do # iterate through lines in the file
    if [[ ${line:0:1} == "#" ]]; then # if a header is found

	for ((i = 0 ; i < ${#line} ; i++)); do # iterate through characters in the line
	    
	    if [[ ${line:$i:1} == " " ]]; then # if the current character is a space...
		
		header=$i # make note of the header size
		
		if [[ $header > 3 ]]; then # if the header is smaller than an h3...
		    
		    break; # don't create an entry
		    
		elif [[ $header == 1 ]]; then # if the header is an h1...
		    
		    indent="" # do not indent
		    section_header=1 # the header size for the current section is an h1
		    
		elif [[ $header > $prev_header ]]; then # if the current header is a smaller size than the previous one
		    
		    indent+='\t' # add an indentation
		    section_header=$prev_header # Keep track of the header size for the section that the current header falls into.
		                                # Since the script only supports h1, h2, & h3, this will always be either 1 or 2.
		    
		elif [[ $prev_header > $header ]]; then # if the current header is a larger size than the previous one
		    
		    diff=$(($prev_header - $header)) # get the difference in size
		    diff=$(($diff * 2)) # multiply by 2 to account for the fact that '\t' is stored as 2 characters

		    # If the header size is not the same as the stored section header size then we are staying in the same section
		    # even though the new header size is larger. This applies when you go from an h1 to h3, then to an h2.
		    # The h1 is the overarching "section" header in this example. The code below will only execute if we are
		    # moving from an h3 to an h2, where the h3 is directly under another h2 (i.e. double-indented).
		    if [[ $section_header -eq $header ]]; then 
			indent=${indent:0:$((${#indent} - $diff))} # remove the proper number of indentations
			section_header=$header 
		    fi
		    
		fi
		 
		# get length of substring that leaves out the '#' symbols
		end=${#line}-$i
		

		# generate the text that will be seen in the ToC
		link_text="${line:$i+1:$end}"
		
		# generate the link by making all characters lower case and replacing
		# all spaces with dashes
		link=$(echo $link_text | tr " " "-" | tr '[:upper:]' '[:lower:]') 

		# put everything together with the proper indentation
		toc="${indent}* [$link_text](#$link)\n"

		printf "${toc}"
		prev_header=$i
		break;
	    fi
	done

    fi
    
    
done
