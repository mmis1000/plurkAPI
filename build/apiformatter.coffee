fs = require 'fs'
original = JSON.parse fs.readFileSync '../lib/APIDataRaw.json'

formated = []

removeSpace = (text)->
  text = text.replace /\s+/g, ' '
  text = text.replace /^[:\s\r\n]+|[\s\r\n]+$/g, ''
  text

getMethodName = (apiPath)->
  path = apiPath.replace /^(?:\/APP)?\/?/, ""
  
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
    
    return {method : methodName, methodShort : shortMethodName}
    
for key, value of original
  api = {}
  api.path = key
  methods = getMethodName key
  api.method = methods.method
  api.methodShort = methods.methodShort
  api.docURL = "http://www.plurk.com/API##{key}"
  api.require = {}
  api.optional = {}
  api.type = value.type
  
  if value["Required parameters:"]
    delete value["Required parameters:"].__data
    delete value["Required parameters:"].none
    
    for key, value1 of value["Required parameters:"]
      api.require[key] = removeSpace value1
      
  if value["Optional parameters:"]
    delete value["Optional parameters:"].__data
    delete value["Optional parameters:"].none
    
    for key, value1 of value["Optional parameters:"]
      api.optional[key] = removeSpace value1
  
  api.requires = Object.keys( api.require )
  api.optionals = Object.keys( api.optional )
  
  formated.push api

data = {}
data.apis = formated
data.classes = {}

temp = []

for key, value of formated
  temp.push value.type if 0 > temp.indexOf value.type

temp.forEach (type)->
  data.classes[type] = []
  for value in formated
    if value.type == type
      data.classes[type].push value.method

console.log temp
console.log data.classes

fs.writeFileSync '../lib/APIData.json', JSON.stringify data, null, 2