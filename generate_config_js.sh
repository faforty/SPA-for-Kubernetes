#!/bin/sh -eu

cat <<EOF
window.APP_ENV={
  "HOST": "$HOST",
  "API": "$API"
};
EOF