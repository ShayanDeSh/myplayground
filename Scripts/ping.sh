read -p "which server you want to ping" server
ping -c3 $server > /dev/null 2>&1 || echo "server dead"
