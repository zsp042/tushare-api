#!/usr/bin/env coffee
axios = require 'axios'

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
    if data.code
      throw data
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

