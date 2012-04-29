require 'sinatra'
require "sinatra/reloader" if development?

require 'lib/PdfStuff'


get '/' do

	erb :index

end

#HTTP Post from PDF
#Just display back the info
post '/posted' do

	erb :posted
end


#PDF file itself is Posted
#Make timestamp based filename, save and then read out the form data

post '/pdf' do

	pdfFile = request.body

	fileName = "drops/form_#{Time.new.to_i}.pdf"

	

	File.open(fileName, 'wb') do |f|
		f.write(pdfFile.read) 
	end

	@fData = PdfStuff.readForm(fileName)

	if @fData.is_a? String 
		erb :xfa
	else
		erb :pdf
	end

end

#Data from LiveCycle created PDF form sent via Post
post '/xml' do

	p request.body.read


end



get '/fillform' do

	erb :fillform

end

#Insert XML data into Dynamic XFA form
get '/fillform/result' do

	fName = "fill_#{Time.new.to_i}.pdf"

	PdfStuff.fill('public/fill.pdf', 'public/fill.xml', "drops/#{fName}")

	send_file("drops/#{fName}")

end

