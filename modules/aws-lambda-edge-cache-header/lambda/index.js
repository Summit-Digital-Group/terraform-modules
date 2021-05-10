'use strict';

exports.handler = (event, context, callback) => {
  const response = event.Records[0].cf.response;
  const request = event.Records[0].cf.request;
  const uri = request.uri
  if(uri.indexOf('/static')===0) {
    if (!response.headers['cache-control']) {
      response.headers['cache-control'] = [{
        key: 'Cache-Control',
        value: 'max-age=${max_age}'
      }];
    }
  }
  callback(null, response);
};
