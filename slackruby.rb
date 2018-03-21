require 'bundler/setup'
require 'rubygems'
require 'sinatra'
require 'json'
require 'logger'
require 'yaml'
require 'fileutils'
require 'pry'
require 'uri'
require 'net/http'


post '/testcall' do

  a = request.params['text']
  b = request.params['trigger_word']
  h = a.slice! b
  a = a.strip!
 
 
  
  url = URI("https://geapplight.service-now.com/api/now/v1/table/cmdb_ci_service?sysparm_query=name%3D#{a}&sysparm_fields=u_technical_contact_sso_1&displayvalue=true")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request["authorization"] = 'Basic NTAyNDEyMjMyOlMzcnZpYzNuMHc='
  response = http.request(request)
  data1 = JSON.parse(response.read_body)
  url2 = idvalue = data1['result'][0]['u_technical_contact_sso_1']["link"]
  url = URI(url2)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request["authorization"] = 'Basic NTAyNDEyMjMyOlMzcnZpYzNuMHc='
  response = http.request(request)
  jsonresult = JSON.parse(response.body)
  result1 = jsonresult['result']['u_display_name']
  #content_type :json
  #{:text => "#{result1}"}.to_json
  #passing second url
    urll = URI("https://geapplight.service-now.com/api/now/v1/table/cmdb_ci_service?sysparm_query=name%3D#{a}&sysparm_fields=u_technical_contact_sso_2&displayvalue=true")
  httpl = Net::HTTP.new(urll.host, urll.port)
  httpl.use_ssl = true
  httpl.verify_mode = OpenSSL::SSL::VERIFY_NONE
  requestl = Net::HTTP::Get.new(urll)
  requestl["authorization"] = 'Basic NTAyNDEyMjMyOlMzcnZpYzNuMHc='
  responsel = httpl.request(requestl)
  data1l = JSON.parse(responsel.read_body)
  url2l = idvalue = data1l['result'][0]['u_technical_contact_sso_2']["link"]
  urll = URI(url2l)
  httpl = Net::HTTP.new(urll.host, urll.port)
  httpl.use_ssl = true
  httpl.verify_mode = OpenSSL::SSL::VERIFY_NONE
  requestl = Net::HTTP::Get.new(urll)
  requestl["authorization"] = 'Basic NTAyNDEyMjMyOlMzcnZpYzNuMHc='
  responsel = httpl.request(requestl)
  jsonresultl = JSON.parse(responsel.body)
  result1l = jsonresultl['result']['u_display_name']
  finalresult = result1 + result1l
  content_type :json
  {:text => "#{finalresult}"}.to_json
end
get '/hello' do
	" hello"
end
