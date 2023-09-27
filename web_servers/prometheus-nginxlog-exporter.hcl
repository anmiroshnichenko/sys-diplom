listen {
  port = 4040
  address = "192.168.10.22"
 }

namespace "web" {
  source = {
    files = [
      "/var/log/nginx/access.log"
    ]
  }

  #format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" \"$http_x_forwarded_for\""
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
  labels {
    app = "web"
  }
}