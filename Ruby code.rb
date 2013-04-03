require 'rexml/document'
require 'mysql'
include REXML

file1 = File.new("sitemap.xml")
doc = Document.new(file1)
#puts doc
begin
     # connect to the MySQL server
     connection_string = Mysql.real_connect("localhost", "root","", "urlname")
     # get server version string
     puts "Server version: " + connection_string.get_server_info
end
connection_string.query("CREATE TABLE IF NOT EXISTS \ urlnam(Id INT PRIMARY KEY AUTO_INCREMENT, LOC VARCHAR(100),PRIORITY VARCHAR(100))")
root = doc.root
puts "Root element : " + root.attributes["xmlns"] + root.attributes["xmlns:xsi"] + root.attributes["xsi:schemaLocation"]
doc.elements.each("*/url"){
         |e|
         loc=e.elements["loc"].text()
         priority=e.elements["priority"].text()
         connection_string.query("INSERT INTO urlnam values(' ','#{loc}','#{priority}')")
         
      }
      data=connection_string.query("SELECT *from urlnam")
      data.each_hash do |da|
         puts ("#{da['LOC']}\t\t#{da['PRIORITY']}")
      end    
 connection_string.close if connection_string
