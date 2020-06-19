test = require('ava')
API = require './index'

test(
  'foo'
  (t) =>
    {data} = await API.index_daily(
      {
        ts_code:'399300.SZ'
        start_date:20181001
        end_date:20181010
      }
      "trade_date,vol,amount,open,high,low,close"
    )
    console.log data.fields
    for i in data.items
      console.log i
    t.assert(
      data.items.length > 0
    )
)
