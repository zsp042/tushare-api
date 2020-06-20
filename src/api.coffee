axios = require 'axios'
chalk = require 'chalk'

sleep = (ms)=>
  new Promise((resolve) => setTimeout(resolve, ms))


class Api
  constructor:(@token, @url="https://api.waditu.com/")->

  $:(api_name, params, fields)->
    body = {
      token:@token
      api_name
    }
    if params
      body.params = params
    if fields
      delete params.fields
      body.fields = fields
    {data,status} = await axios.post(
      @url, body
    )
    if status != 200
      throw new Error(data)
    {code} = data
    if code
      if code == 40203
        console.log chalk.redBright(data.msg)
        await sleep(3000)
        return await @$.apply @,arguments
      else
        err = new Error(data.msg)
        Object.assign(err, data)
        throw err
    if fields
      d = data.data
      df = d.fields
      d.fields = fields = fields.split ','
      pli = fields.map((x)=>df.indexOf(x))
      items = []
      for i in d.items
        t = []
        for p in pli
          t.push i[p]
        items.push t
      d.items = items
    data.data


module.exports = ->
  new Proxy(
    new Api(...arguments)
    {
      get: (obj, prop) =>
        f = obj[prop]
        if not f
          obj.$.bind(obj,prop)
    }
  )

