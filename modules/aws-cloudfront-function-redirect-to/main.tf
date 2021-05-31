resource "random_password" "this" {
  length = 10
}

resource "aws_cloudfront_function" "this" {
  name    = local.function_name
  runtime = "cloudfront-js-1.0"
  comment = "redirect_to_target"
  publish = true
  code    = <<EOF
function handler(event) {
    var request = event.request;
    var headers = request.headers;
    var host = request.headers.host.value;
    var newurl = `${var.target}`
    var path = '${var.path}'
    var uri = request.uri;
    if(uri.indexOf(path)!==-1){
    var cleanedPath = uri.replace(path,'')
    var response = {
        statusCode: 302,
        statusDescription: 'Found',
        headers:
            { "location": { "value": newurl+(cleanedPath.indexOf('/')===0?cleanedPath:'/'+cleanedPath) } }
        }
        return response;
    }
    return request;
}
EOF
}
