#!/bin/bash

group_number=7

# Define the output CSV file name
output_file="speedtest_$group_number.csv"

# Write the CSV header
echo "Server ID,Sponsor,Server Name,Timestamp,Distance,Ping,Download,Upload,Share,IP Address" > $output_file

# Function to test speed for a specific server and append results to the CSV
test_speed() {
    server_id=$1
    echo "======================================"
    echo "Testing speed for server ID: $server_id" 
    echo "======================================"
    # Run the speed test and capture the results in CSV format
    result=$(speedtest-cli --server $server_id --csv)
    
    # Append the result to the CSV file
    echo "$result" >> $output_file

    echo "Result saved for server ID: $server_id"
}

# Get the list of available servers
echo "Fetching server list..."
server_list=$(speedtest-cli --list | grep -Eo '^[0-9]+')

# Iterate over each server in the list and test the speed
for server_id in $server_list; do 
    echo "--------------------------------------"
    test_speed $server_id
done

echo "All tests completed. Results saved to $output_file"

