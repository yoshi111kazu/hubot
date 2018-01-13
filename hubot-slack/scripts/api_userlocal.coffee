module.exports = (robot) ->

    robot.respond /ul (.*)/i, (res) ->
        url = "https://chatbot-api.userlocal.jp/api/chat"
        api_key = process.env.HUBOT_UL_API_KEY
        message = res.match[1]
        params = {
          "message": message,
          "key": api_key
        }
        robot.http(url).query(params).get() (err, response, body) ->
          return response.send "Encountered an error :( #{err}" if err
          body = JSON.parse(body)
          res.reply "#{body.result}"

