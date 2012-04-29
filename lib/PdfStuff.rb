require 'cgi'

require 'java'
require 'ext/itextpdf-5.2.1'
require 'nokogiri'
java_import java.io.FileOutputStream
java_import java.io.FileInputStream
java_import java.io.StringWriter


java_import org.apache.xml.serialize.XMLSerializer
java_import org.apache.xml.serialize.OutputFormat

java_import com.itextpdf.text.pdf.AcroFields
java_import com.itextpdf.text.pdf.PdfReader
java_import com.itextpdf.text.pdf.PdfStamper
java_import com.itextpdf.text.pdf.XfaForm


class PdfStuff

	def self.fill(pdfTemplate, xmlData, filledPdf)
		reader = PdfReader.new(pdfTemplate)
		stamper = PdfStamper.new(reader, FileOutputStream.new(filledPdf))
		form = stamper.getAcroFields()
		xfa = form.getXfa()
		xfa.fillXfaForm(FileInputStream.new(xmlData))
		stamper.close()
	end


	def self.readForm(fileName)

		reader = PdfReader.new(fileName)
		form = reader.getAcroFields()
		xfa = form.getXfa()
	

		if xfa.isXfaPresent
			self.getXfaData(reader)
		else
			self.getAcroData(form)
		end
			



	end


	def self.getAcroData(form)

		data = {}

		form.getFields().each do |f|
			data[f[0]] = form.getField(f[0])

			#p f[0]
			#p form.getField(f[0])
		end
		
		data

	end






	def self.getXfaData(reader)
		
		xf = XfaForm.new(reader)

		node = xf.getDatasetsNode()
	

		#some java stuff to convert xml to string. I'm not as familiary with java xml classes. This can be better
		out = StringWriter.new
		serializer = XMLSerializer.new(out, OutputFormat.new())
		serializer.serialize(node)
		xmlData = out.toString()

		CGI.escapeHTML(xmlData)

	
	end


end





