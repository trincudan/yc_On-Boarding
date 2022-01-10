!#/bin/bash
backstop reference

curl 'http://localhost:4502/crx/server/crx.default/jcr%3aroot' \
  -H 'Content-Type: multipart/form-data; boundary=crxde' \
  -u admin:admin \
  --data-raw $'--crxde\r\nContent-Disposition: form-data; name=":diff"\r\nContent-Type: text/plain; \
  charset=utf-8\r\n\r\n^/content/platform/ccl/en/components/jcr:content/par-main/title/jcr:title : "Components - Sling"\r\n--crxde-- '

curl 'http://localhost:4502/crx/de/replication.jsp' \
  --data-raw 'path=%2Fcontent%2Fplatform%2Fccl%2Fen%2Fcomponents%2Fjcr%3Acontent%2Fpar-main%2Ftitle&action=replicate&_charset_=utf-8' \
  -u admin:admin

backstop test