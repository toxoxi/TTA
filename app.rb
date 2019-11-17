# sls invokeでローカル実行する場合はLOAD_PATHを変える
if ENV['IS_LOCAL'].nil?
  load_paths = Dir["/opt/bundle/ruby/2.5.0/gems/**/lib"]
  $LOAD_PATH.unshift(*load_paths)
end

require 'json'
require './lib/slack/event'

def handleHttp(event:, context:)
  e = Slack::Event.new(event)

  if result = e.validate || e.verify
    return make_response(body: result)
  end

  make_response(body: {
    message: 'Go Serverless v1.0! Your function executed successfully!',
    input: event
  })
end

def handlerSqs
  make_response(body: { message: 'handle SQS' })
end

private

def makes_response(statusCode: 200, body: {})
  {
    statusCode: statusCode,
    body: body.to_json
  }
end
