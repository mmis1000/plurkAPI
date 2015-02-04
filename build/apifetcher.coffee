request = require 'request'
cheerio = require 'cheerio'
fs      = require 'fs'

fixDDTag = (text)->
  temp = text.split /(<\/?dd>|<dt>)/ig
  
  isHead = true
  
  correct = temp.map (el)->
    #console.log el, isHead
    if el == '<dd>'
      if isHead == true
        isHead = false
        return el
      else
        #console.log 'err'
        isHead = false
        return '</dd><dd>'
    if el == '</dd>'
      isHead = true
    if el == '<dt>'
      if isHead == false
        isHead = true
        return '</dd><dt>'
    
    return el
  correct .join ''


mapSpoiler = ($, el)->
  ($ el).replaceWith ()->
    html = ($ el).html()
    html = html.replace /[\s\r\n]+/g, ' '
    html = html.replace /^\s+|\s+$/g, ''
    console.log html
    
    if 0 != html.search 'createExample'
      return el
    #"[spoiler]"
    html = html.replace /^createExample\(\s*(.+)\s*\);?$/g, '[$1]'
    try
      html = eval html
      html = "#{html.join ' '}"
      return html
    catch e
      console.log e
      return html
    
request "http://www.plurk.com/API", (error, response, body)->
  bodyFixed = fixDDTag body
  $ = cheerio.load bodyFixed
  #(($ '.fns').find 'h3').each ()-> console.log ($ @).text()
  
  ($ 'script').each ()->
    mapSpoiler $, @
  
  $ '.fns h3 *'
  .remove()
  
  APIsObj = {}
  
  apis = ($ '.fns').each ()->
    type = ($ @).prev('h1').text()
    console.log type
    
    ($ @).find 'h3'
    .filter ()-> "/" == ($ @).text().slice 0,1
    .each ()->
      #API Path
      APIPath = ($ @).text().replace /^\s+|\s+$/g, ''
      console.log APIPath
      APIsObj[APIPath] = {}
      APIsObjSection = APIsObj[APIPath]
      APIsObjSection.type = type
      
      ($ @).nextAll()
      .filter 'dl'
      .eq 0
      .each ()->
        #console.log ($ @).text()
        ($ @).find 'dt'
        .each ()->
        
          #API Section
          APISection = ($ @).text()
          console.log '  section ' + APISection
          APIsObjSection[APISection] = {__data : []}
          APIsObjSectionField = APIsObjSection[APISection]
          
          ($ @).nextUntil 'dt'
          .each ()->
            
            #data slot
            data = ($ @).text()
            console.log  '    data : ' + data
            APIsObjSectionField.__data.push data
          
            html = ($ @).html()
            if 0 == html.search '<b>'
              
              #field key
              APIFieldKey = ($ @).find('b').eq(0).text()
              console.log  '    param key : ' +  APIFieldKey
              
              ($ @).find('b').eq(0).remove()
              
              #field discription
              APIFieldDiscription = ($ @).text()
              console.log  '      param description ' + APIFieldDiscription
              
              APIsObjSectionField[APIFieldKey] = APIFieldDiscription
            
          
  
  console.log JSON.stringify APIsObj, null, 2
  fs.writeFileSync '../lib/APIDataRaw.json', JSON.stringify APIsObj, null, 2