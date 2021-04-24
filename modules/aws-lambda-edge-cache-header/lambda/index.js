'use strict';

exports.handler = (event, context, callback) => {
  const response = event.Records[0].cf.response;
  console.log('event')
  console.log(event)
  console.log('context')
  console.log(context)
  if (!response.headers['cache-control']) {
    response.headers['cache-control'] = [{
      key: 'Cache-Control',
      value: 'max-age=${max_age}'
    }];
  }
  callback(null, response);
};
