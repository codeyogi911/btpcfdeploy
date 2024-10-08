#!/bin/bash
set -e

cf_opts=
cf api ${INPUT_API:-$CF_API} ${cf_opts}

cf auth "$INPUT_USERNAME" "$INPUT_PASSWORD"

if [ "x${INPUT_CREATESPACE}" = "xtrue" ]; then
  cf create-space ${INPUT_SPACE:-$CF_SPACE} -o ${INPUT_ORG:-$CF_ORG}
fi

cf target -o ${INPUT_ORG:-$CF_ORG} -s ${INPUT_SPACE:-$CF_SPACE}

cf deploy ${INPUT_MTAFILE} -f ${INPUT_DEPLOYPARAMS}

if [ ! -z "${INPUT_FINDURL_COMMAND}" ]; then
  # echo "Find URL command: ${INPUT_FINDURL_COMMAND}, regex: ${INPUT_FINDURL_REGEX}"
  res=`${INPUT_FINDURL_COMMAND}`
  url=`echo "${res}" | grep -o "${INPUT_FINDURL_REGEX}"`
  echo "URL: $url"
  echo "::set-output name=url::$url"
fi
