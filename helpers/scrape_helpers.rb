helpers do
def stream_topics(client, topics)
	client.search(topics, :count => 1000, :result_type => "recent").take(1000).collect do |tweet|
  "#{tweet.user.screen_name}: #{tweet.text}"
end
	
end

def hot_trends
	#pulls hourly hot trends off of googles atom rss feed & returns array
	#white space replace with "+" to prepare google search
	trends = []
	raw_trends = Nokogiri::HTML(open("http://www.google.com/trends/hottrends/atom/hourly"))
	raw_trends.search('a').xpath('text()').each do|tag|  
		trends<< tag.to_s.gsub(" ", "+")
	end
	trends
end

def grab_image(term, array=false)	
	#grabs image either from a website or from searching google images
	images =[]
	search = "http://www.google.com/search?site=imghp&tbm=isch&source=hp&biw=1027&bih=440&q=" << term
	search = term if term[0..6] == "http://"  
	doc = Nokogiri::HTML(open(search)).xpath("//img/@src").each {|src| images << src}
	image = images[rand(images.size-1)].to_s
end

def grab_text_random(term = hot_trends[rand(hot_trends.size-1)], tag = 'p')
	#grabs text from random website based on searchterm
	agent = Mechanize.new
	search_term = term
	search = agent.get("http://www.google.com/")
	search_form = search.form()
	search_form.q = "#{term}"
	results = agent.submit(search_form, search_form.buttons.first)
	text = results.links[rand((25..results.links.size-1))].click.search(".//p").text
	text.size < 1000 ? grab_text_random(search_term) : text
end

def grab_text(url, keep_line_breaks = false, tag = 'p')
	#grabs text from a website returns string of text
	page = Nokogiri::HTML(open(url))

	page.search('br').each {|br| br.replace('##br##')} if keep_line_breaks == true #keeps line formatting

	sentences = page.search(tag).map{ |n| n.text }
	text = sentences.join(" ").gsub("##br##", "<br>")
end

def grab_link(url)
	urls = []
	doc = Nokogiri::HTML(open(url)).xpath('//div/a/@href').each {|link| urls<< link.text}
	urls.reject!{|val| val.include?("http://") != true}
	urls.map!{|val| val[val.index("http://")..-1]}
end

def temp_file(data, name = "temp", extension=".txt", directory="public/tmp")
	temp = Tempfile.new([name, extension], directory)
	temp.write(data)
	temp.rewind
	temp.path.gsub("public", "")
end

def splice_svg(file1, file2)
	#takes two svg files and splices together ab style. make a random svg image
	#to improve a: add ability to turn raster into svg

	file1_to_array =File.open(file1).read.split("<path d=")
	first = file1_to_array.shift
	last = file1_to_array.pop
	file2_to_array =File.open(file2).read.split("<path d=")
	file2_to_array.shift
	file2_to_array.pop

	file1_to_array = file1_to_array.map{|line| line = line.split(" ")[0..rand(2..line.size/2)].join(" ")}
	file2_to_array = file2_to_array.map{|line| line = line.split(" ")[rand(1..10)..-1].join(" ")}

	file1_to_array.each_index{|index| file1_to_array[index] << file2_to_array[index]} 
	svg_file = first << file1_to_array.join("<path d=") << last
	
	temp_file(svg_file, "spliced_svg", ".svg")
	#File.open("public/masks/test.svg", 'w'){|file| file.write(svg_file)}
end
end