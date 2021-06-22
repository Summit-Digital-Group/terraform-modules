function handler(event) {
  var response = event.response;
  var request = event.request;
  var headers = response.headers;
  var regex = /\.(css|svg|png|jpeg|jpg|gif|pdf|svg|md|ico|js|htm|html|txt|md|woff2|woff|webp|ttf|xml|doc|docx|bmp|mp3|mp4)$/i

  if(request.uri.indexOf('/static')===0) {
    // Set the cache-control header
    headers['cache-control'] = { value: 'public,immutable,max-age=${duration};' };
  }

  // Return response to viewers
  return response;
}
