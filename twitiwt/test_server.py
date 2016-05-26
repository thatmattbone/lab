#!/usr/bin/env python
import BaseHTTPServer
import base64

TEST_LINES = ["""{"text": "hello", "user":{"screen_name":"foobar"}}""",
              """{"text": "world", "user":{"screen_name":"foobar"}}""",
              """{"text": "how are you", "user":{"screen_name":"foobar"}}""",
              """{"text": "racecar", "user":{"screen_name":"foobar"}}""",
              """{"text": "i like my kayak", "user":{"screen_name":"foobar"}}""",
              """{"text": "i like my kayka", "user":{"screen_name":"foobar"}}""",
              """{"text": "Race fast, safe car.", "user":{"screen_name":"foobar"}}""",]

NEWLINE = '\r\n'


class TwitterStreamRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
  
    def is_authorized(self):
        try:
            authentication = self.headers['Authorization']
            decoded_auth = base64.b64decode(authentication.split()[1])
            
            username = decoded_auth.split(':')[0]
            password = decoded_auth.split(':')[1]
            
            print("username: %s" % username)
            print("password: %s" % password)
            
            return True
        except KeyError:
            return False
        
            
    
    def echo_request(self):
        if(self.is_authorized()):
            request = "GET: %s" % self.path

            self.send_response(200)
            self.send_header('content-type', 'text/plain')
            self.end_headers()
            
            while(True):
                for line in TEST_LINES:                
                    self.wfile.write(line)
                    self.wfile.write(NEWLINE)
        else:
            self.send_error(401, "Not Authorized")
    
    def do_GET(self):
        #print(self.headers)
        self.echo_request()
    
  

def run(server_class=BaseHTTPServer.HTTPServer,
        handler_class=BaseHTTPServer.BaseHTTPRequestHandler):
    server_address = ('', 8000)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()


if __name__ == '__main__':
    run(handler_class=TwitterStreamRequestHandler)
