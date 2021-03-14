## httpdump scratch container

A small scratch based docker container with httpdump, compressed with upx

https://github.com/hsiafan/httpdump

https://github.com/boeboe/httpdump-scratch


```
capture and dump http contents

Usage: httpdump
  -curl
    	Output an equivalent curl command for each http request
  -device
    	Capture packet from network device. If is any, capture all interface traffics (default any)
  -dump-body
    	dump http request/response body to file
  -file
    	Read from pcap file. If not set, will capture data from network device by default
  -force
    	Force print unknown content-type http body even if it seems not to be text content
  -host
    	Filter by request host, using wildcard match(*, ?)
  -idle
    	Idle time to remove connection if no package received (default 4m)
  -ip
    	Filter by ip, if either source or target ip is matched, the packet will be processed
  -level
    	Output level, options are: url(only url) | header(http headers) | all(headers, and textuary http body) (default header)
  -output
    	Write result to file [output] instead of stdout
  -port
    	Filter by port, if either source or target port is matched, the packet will be processed.
  -pretty
    	Try to format and prettify json content
  -status
    	Filter by response status code. Can use range. eg: 200, 200-300 or 200:300-400
  -uri
    	Filter by request url path, using wildcard match(*, ?)
```