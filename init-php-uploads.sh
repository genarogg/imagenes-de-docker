#!/bin/sh
set -e
UPLOAD_MAX="${PHP_UPLOAD_MAX_FILESIZE:-64M}"
POST_MAX="${PHP_POST_MAX_SIZE:-64M}"
INI_DIR="/usr/local/etc/php/conf.d"
INI_FILE="${INI_DIR}/uploads.ini"
mkdir -p "$INI_DIR"
printf "%s\n" \
"file_uploads = On" \
"upload_max_filesize = ${UPLOAD_MAX}" \
"post_max_size = ${POST_MAX}" \
> "$INI_FILE"
chmod 644 "$INI_FILE"
