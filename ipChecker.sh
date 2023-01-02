## Moving the current working directory for local sources
parent_path=$(
  # shellcheck disable=SC2164
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
# shellcheck disable=SC2164
cd "$parent_path"

ipFile="./ipHistory"
mailToSend="example@mail.com"

lastKnownIP=$(tail -1 "${ipFile}")
echo "${lastKnownIP}"
NOW=$(date +"%d-%m-%YT%T")
echo "${NOW}"

actualIP=$(curl https://ipinfo.io/ip)
echo "${actualIP}"

if [ "${lastKnownIP}" = "${actualIP}" ]; then
  echo "Same IP"
elif [ "${actualIP}" = "" ]; then
  echo "No IP"
else
  echo "Different IP"
  printf "New IP : %s
Change it at domains.google.com

This is an automated message, please don't reply.

  " "${actualIP}" | mail --subject="Device IP changed" "${mailToSend}"
  echo "${NOW}" >> "${ipFile}"
  echo "${actualIP}" >> "${ipFile}"
fi