# plurkAPI
an unofficial plurk api lib

===

usage

```
    var PlurkAPI = require("plurkAPI")
    var api = new PlurkAPI({
      "appKey"       : "xxxxxxxxxxxx",
      "appSecret"    : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "clientToken"  : "xxxxxxxxxxxx",
      "clientSecret" : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    });
    // if you want to access /Emoticons/get
    api.emothionsGet(function(err, data, res) {
      console.log(data);
    });
    // if you want to access /Responses/get
    api.responsesGet(1234567890, function(err, data, res){
      if (!err) {
        console.log(data);
      } else {
        console.error(err)
      }
    };
    // if you want to access /Responses/get with optional parameter
    api.responsesGet(1234567890, {from_response : 5},function(err, data, res){
      console.log(data);
    };
    // if you would like use object parameter instead
    api.responsesGet({plurk_id: 1234567890,from_response : 5},function(err, data, res){
      console.log(data);
    };
    
    // you can find the parameters each api required in plurkapilist.coffee
    
```