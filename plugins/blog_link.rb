require 'rexml/document'
require 'open-uri'

module Jekyll
  class BlogLinkTag < Liquid::Tag
    def render(context)
	html = ""
	blog_link_file = context.registers[:site].config['blog_link_file']
	blog_link_url = context.registers[:site].config['url'] + "/" +  blog_link_file 

	if File.exists?(blog_link_file)
	  File.delete(blog_link_file)
	end

	File.open(blog_link_file, 'wb') do |output|
		open(blog_link_url) do |input|
			output << input.read
		end
	end
			
	if File.exists?(blog_link_file)
	  xml = REXML::Document.new(File.open(blog_link_file))

	  xml.each_element('//blog') do |elem|
		blog_name = elem.elements['name'].text
		blog_link = elem.elements['link'].text
		html << "<li class='blog_link'><a href=#{blog_link}>#{blog_name}</a></li>"
	  end

	end
	html
    end
  end
end

Liquid::Template.register_tag('blog_link', Jekyll::BlogLinkTag)
