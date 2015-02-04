ejs = require 'ejs'
helper = (require 'express-helpers')()
#console.log helper
fs = require 'fs'
beautify_html = (require 'js-beautify').html;

outputPath = '../doc/index.htm'

data = JSON.parse fs.readFileSync '../lib/APIData.json', {encoding  : 'utf8'}
templete = fs.readFileSync '../src/doc.ejs', {encoding  : 'utf8'}

for i ,j of helper
  data[i] = j
#console.log data
#console.log data, templete

###
result = ejs.render templete, data
###
#template = ejs.compile templete

result = ejs.render templete, data
result = beautify_html result, {"preserve_newlines": false}
fs.writeFileSync outputPath, result