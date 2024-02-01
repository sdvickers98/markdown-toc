# markdown-toc
Bash script to generate a table of contents (ToC) for a markdown file based on headers. 

This certainly isn't the most elegant solution, but it gets the job done (kinda...see below for exceptions).

## Important notes about usage

This script is only inteded to work with ATX style headers, i.e. headers indicated using the hashbang symbol (#).

It's also worth noting that this script works best if you don't skip header sizes when going from a larger size to a smaller size, otherwise the indentation will look weird. 

In other words, you don't want to skip from an h1 to h3 or h4, or skip from an h2 to h4. When going from a smaller header size to a larger one, this doesn't matter.

Because of this, your first header must be an h1. Also, when I wrote the script, I only needed to account for h1 through h4. If you want to create ToC entries for smaller headers, it's not too hard to add cases in the script to account for those.

Here's an example of a header layout that would work well with the script:

> # Header 1
>
> ## Header 2
>
> ### Header 3
>
> ## Header 2
>
> ### Header 3
>
> #### Header 4
>
> # Header 1
>
> ## Header 2

Another note is that if you use the hash symbol for anything other than headers (such as comments in code blocks), this script will generate a ToC entry for those lines and you will need to manually remove them. Also, any symbols that will mess with the URL fragment will not work properly, i.e. a forward slash (/) or dash (-) in the header.

Basically, this script kinda sucks lol, but it works okay if you don't mind doing a small bit of manual work in certain scenarios.



## Usage:
```
./markdown-toc.sh <markdown file>
```
The table of contents will be generated in markdown format and printed out in the shell. Simply copy the output and paste it into your markdown file. Be sure to make corrections for situations like those mentioned above.
