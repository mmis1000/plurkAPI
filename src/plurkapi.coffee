{EventEmitter} = require 'events'
OAuth = require 'OAuth'
utils = require './utils'
request = require 'request'
querystring = require 'querystring'
Url = require 'url'

APIs = require './plurkapilist.js'

###
  event : response     # new_response
  event : plurk        # new_plurk
  event : notification # update_notification
###

class PlurkAPI
  constructor: (@config)->
    @lang = @config.lang || "tr_ch"
    @qualifier = @config.qualifier || ":"
    
    @oauth = new OAuth.OAuth 'http://www.plurk.com/OAuth/request_token',
      'http://www.plurk.com/OAuth/access_token',
      config.appKey,
      config.appSecret,
      '1.0A',
      null,
      'HMAC-SHA1',
    
    @init_()
  
  init_: ()->
    for item in APIs
      @registerAPI.apply @, item
    
  get: (api, options..., callback)->
    api = api.replace /^\//, ''
    #console.log options
    @oauth.post "http://www.plurk.com/APP/#{api}",
      @config.clientToken,
      @config.clientSecret,
      (utils.mergeDefault options),
      (e, data, res)=>
        if not e and res.statusCode != 200
          e = new Error "unexpected http code '#{response.statusCode}'"
        try
          data = JSON.parse data
        catch e
          e = new Error "response is not a valid JSON" if not e
        callback e, data, res
  registerAPI: (path, inLineOptionNames = [], configOptions = {}, defaultOptions = {})->
    methodName = path.split '/'
    .filter (i)-> i isnt ''
    .map (i)-> i.replace /^./, (i)-> i.toUpperCase()
    .join ''
    .replace /^./, (i)-> i.toLowerCase()
    
    console.log methodName
    
    temp = path.split '/'
    .filter (i)-> i isnt ''
    .map (i)-> i.replace /^./, (i)-> i.toUpperCase()
    
    shortMethodName = ""
    if temp.length > 1
      temp.shift 1
      shortMethodName = temp
      .join ''
      .replace /^./, (i)-> i.toLowerCase()
      
      console.log "  As #{shortMethodName}"
      
      if @[shortMethodName]
        console.log "  Conflict happened! ignore this short name"
        shortMethodName = ""
    
    optionsFromConfig = {}
    for key, value of configOptions
      if configOptions.hasOwnProperty key
        optionsFromConfig[key] = @config[value]
    
    #defaultOptions = utils.mergeDefault configOptions, defaultOptions
    
    method = (args...)->
      if 'function' is typeof args[args.length - 1]
        callback = args.pop()
      
      inLineOptionsList = []
      
      for i in args
        if not utils.isRealObject i
          inLineOptionsList.push args.shift()
        else
          break
      
      inLineOptions = {}
      
      for item, index in inLineOptionsList
        if index < inLineOptionNames.length
          inLineOptions[ inLineOptionNames[index] ] = item
        else
          break
      #console.log inLineOptionsList, inLineOptions, inLineOptionNames
      options = utils.mergeDefault inLineOptions, configOptions, defaultOptions
      
      @get path, options, callback
        
      
    method.displayName = methodName
    
    @[methodName] = method
    @[shortMethodName] = method if shortMethodName
    
module.exports = PlurkAPI