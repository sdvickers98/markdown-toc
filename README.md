# markdown-toc
Bash script to generate a table of contents (ToC) for a markdown file based on headers. 

This certainly isn't the most elegant solution, but it gets the job done (kinda...see below for exceptions).

## Important notes about usage

The original script has support for headers as small as h4, but does not allow you to skip header sizes without creating weird indentation (e.g. jumping from an h1 to an h3). 

Version 2 of the script provides support for cases like jumping from h1 to h3, then to an h2, but want the level of indentation to be the same for the h3 and h2. The caveat is that it only supports h1, h2, and h3. Any smaller headers will not have ToC entries created. 

Unless you want to create entries for h4 headers, I recommend using v2.

**NOTE**: The script will generate a ToC entry for any line that begins with a '#'. This includes comments in code blocks, so be sure to remove any unwanted ToC entries created this way.

## Example

Here's an example of a header layout that would work well with version 2 of the script (of course, you wouldn't want any headers with the same name to avoid confusing the ToC):

> # Header 1
>
> ## Header 2
>
> ### Header 3
>
> ## Header 2
>
> # Header 1
>
> ### Header 3
>
> ## Header 2
>
> ### Header 3
>
> # Header 1

For the layout above, the script would generate the following ToC:
 * [Header 1](#header-1)
	* [Header 2](#header-2)
		* [Header 3](#header-3)
	* [Header 2](#header-2)
* [Header 1](#header-1)
	* [Header 3](#header-3)
	* [Header 2](#header-2)
		* [Header 3](#header-3)
* [Header 1](#header-1)





## Usage
```
./markdown-toc_v2.sh <markdown file>
```
The table of contents will be generated in markdown format and printed out in the shell. Simply copy the output and paste it into your markdown file.
