function handler(event) {
  var response = event.response;
  var request = event.request;
  var headers = response.headers;

  if(request.uri !=="/index.html") {
    // Set the cache-control header
    headers['cache-control'] = { value: 'public, max-age=${duration};' };
  }

  // Return response to viewers
  return response;
}
