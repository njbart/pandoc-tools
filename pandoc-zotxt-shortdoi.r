#! /usr/bin/env Rscript

# Replaces any DOI in pandoc-zotxt’s output by a shortDOI (see http://shortdoi.org/).
# Requires R (https://www.r-project.org/), jq (https://stedolan.github.io/jq/), and curl
# Usage: pandoc -s --filter pandoc-zotxt --filter pandoc-zotxt-shortdoi.r --filter pandoc-citeproc myfile.md

library("methods")
library("jsonlite")

# stdin
data <- scan(file="stdin", what=character(0), quiet=TRUE)

astr <- fromJSON(data, simplifyVector = FALSE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)

bibfile <- astr$meta$bibliography$c[[1]]$c

bibdata <- fromJSON(bibfile, simplifyVector = FALSE, simplifyDataFrame = FALSE, simplifyMatrix = FALSE)

for (n in seq_along(bibdata)) {
	if (exists('DOI', where=bibdata[[n]])) {
		getshortdoi <- paste0("curl -sS --globoff \"http://shortdoi.org/", bibdata[[n]]$DOI, "?format=json\" | jq -r .ShortDOI")
		shortdoi <- try(system(getshortdoi, intern = TRUE))
			if (identical(shortdoi, character(0))) {
				bibdata[[n]]$DOI <- "✖︎︎︎✖︎︎︎✖︎︎︎ FIXME: INVALID DOI ✖︎︎︎✖︎︎︎✖︎︎︎"
			} else {
				bibdata[[n]]$DOI <- shortdoi
			}
		}
	}

write(toJSON(bibdata, auto_unbox = TRUE), file = bibfile)

# stdout
write(data, file = "/dev/stdout")
