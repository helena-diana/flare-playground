#!/bin/bash
set -euxo pipefail
OUT=docs/app.js
spago bundle-app --main Main --to $OUT
uglifyjs $OUT --compress 'pure_getters,keep_fargs=false,unsafe_comps,unsafe' --mangle --output=$OUT

