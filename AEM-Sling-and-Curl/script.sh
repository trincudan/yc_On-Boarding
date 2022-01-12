#!/bin/bash

backstop reference

curl -s -u admin:admin \
  -Fjcr:title="Append" \
  http://localhost:4502/content/platform/ccl/en/components/jcr:content

curl -s -u admin:admin \
  -X POST -F path="/content/platform/ccl/en/components" -F \
  cmd="activate" http://localhost:4502/bin/replicate.json

backstop test
