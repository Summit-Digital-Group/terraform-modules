function handler(event) {
  var response = event.response;
  var request = event.request;
  var headers = response.headers;

  if(request.uri.indexOf('/static')===0) {
    // Set the cache-control header
    headers['cache-control'] = { value: 'public,immutable,max-age=${duration};' };
  }

  // Return response to viewers
  return response;
}
