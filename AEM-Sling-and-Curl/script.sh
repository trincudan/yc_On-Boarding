#!/bin/bash

#backstop reference

PATHS=`curl -u admin:admin http://localhost:4502/bin/querybuilder.json\?type\=cq:Page\&path\=/content/platform/ccl/en/components\&p.limit=-1 | jq -r '.hits[] | .path'`
for path in ${PATHS[@]}; do
  oldTitle=`curl -s -u admin:admin --url http://localhost:4502/${path}/jcr:content.json | jq .'"jcr:title"'`
  oldTitle=$(sed -e 's/^"//' -e 's/"$//' <<<"$oldTitle")
	newTitle="$oldTitle - Sling"
	curl -u admin:admin -X POST -F condition="" -F"jcr:title=${newTitle}" --url "http://localhost:4502${path}/jcr:content"
	echo "** Now changeing http://localhost:4502${path}/jcr:content **"
	echo "======================"
	echo "PATH: ${path}"
	echo "Old title: ${oldTitle}"
	echo "New title: ${newTitle}"
	echo "======================"
done
#curl -s -u admin:admin -X POST -F path="/content/platform/ccl/en/components" -F cmd="activate" http://localhost:4502/bin/replicate.json

#backstop test


#curl -s -u admin:admin -X POST -F condition="" -Fjcr:title=test --url http://localhost:4502/content/platform/ccl/en/components/breadcrumbs/jcr:content