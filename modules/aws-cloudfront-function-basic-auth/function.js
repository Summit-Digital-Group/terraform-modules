var unauthorizedResponse = {
  statusCode: 401,
  statusDescription: 'Unauthorized',
  headers: {
    'www-authenticate': {value:'Basic'},
  },
};
var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
function btoa(input) {
  input = String(input);
  var bitmap, a, b, c,
    result = "", i = 0,
    rest = input.length % 3; // To determine the final padding

  for (; i < input.length;) {
    if ((a = input.charCodeAt(i++)) > 255
      || (b = input.charCodeAt(i++)) > 255
      || (c = input.charCodeAt(i++)) > 255)
      throw new TypeError("Failed to execute 'btoa' on 'Window': The string to be encoded contains characters outside of the Latin1 range.");

    bitmap = (a << 16) | (b << 8) | c;
    result += b64.charAt(bitmap >> 18 & 63) + b64.charAt(bitmap >> 12 & 63)
      + b64.charAt(bitmap >> 6 & 63) + b64.charAt(bitmap & 63);
  }

  // If there's need of padding, replace the last 'A's with equal signs
  return rest ? result.slice(0, rest - 3) + "===".substring(rest) : result;
}
var user = '${username}';
var pass = '${password}';
var basicAuthentication = 'Basic ' +  btoa(user + ':' + pass);
function handler(event) {
  var request = event.request;
  var headers = request.headers;
  if (typeof headers.authorization == 'undefined' || headers.authorization.value != basicAuthentication) {
    return unauthorizedResponse
  }
  return request;
}
