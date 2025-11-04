#!/usr/bin/env sh
set -eu

# Default to /api/ if not provided
: "${API_BASE_URL:=/api/}"

cat > /usr/share/nginx/html/env.js <<EOF
window.__ENV = {
  API_BASE_URL: "${API_BASE_URL}"
};
EOF

exec nginx -g 'daemon off;'


