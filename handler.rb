# sls invokeでローカル実行する場合はLOAD_PATHを変える
if ENV['IS_LOCAL'].nil?
  load_paths = Dir["/opt/bundle/ruby/2.5.0/gems/**/lib"]
  $LOAD_PATH.unshift(*load_paths)
end

require 'json'

def hello(event:, context:)
  response_body =
    if event['body']['type'] =='url_verification'
      {
        challenge: event['body']['challenge']
      }
    else
      {
        message: 'Go Serverless v1.0! Your function executed successfully!',
        input: event
      }
    end
  {
    statusCode: 200,
    body: response_body.to_json
  }
end
