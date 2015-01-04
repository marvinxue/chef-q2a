@test "Apache port 80 open" {
  run bash -c "netstat -anpt | grep LISTEN | grep ':80' | wc -l"
  [ "$output" -gt 0 ]
}

@test "Mysql port 3306 open" {
  run bash -c "netstat -anpt | grep LISTEN | grep ':3306' | wc -l"
  [ "$output" -gt 0 ]
}
