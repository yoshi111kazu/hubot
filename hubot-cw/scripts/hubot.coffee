module.exports = (robot) ->
	status  = {}

	robot.respond /(.*)/i, (res) ->
		message = res.match[1]
		lunch = ['コンビニ', '中華', 'イタリアン', '和食', 'カレー', '昨日と同じ']

		if message.length == 0
			res.reply "What?"

		else if /お昼/i.test(message)
			res.reply res.random lunch

		else if /site (.*)/i.test(message)
            url = message
            options =
              url: url
              timeout: 2000
              headers: {'user-agent': 'node title fetcher'}
 
            request = require 'request'
            cheerio = require 'cheerio'

            request options, (error, response, body) ->
              $ = cheerio.load body
              title = $('title').text().replace(/\n/g, '')
              res.reply(title)

		else if /(.*)/i.test(message)
            url = "https://www.cotogoto.ai/webapi/noby.json"
            api_key = process.env.HUBOT_CG_API_KEY
            message = res.match[1]
            params = {
              "text": message,
              "app_key": api_key
            }
            robot.http(url).query(params).get() (err, response, body) ->
              return response.send "Encountered an error :( #{err}" if err
              body = JSON.parse(body)
              res.reply "#{body.text}"
		else
			dumm = "dumm"
