helpers do
def coition(url)
	#takes casual encounters listings in New York and uses the text to search google for images
	search_text = grab_text(url, false, 'a').split(".")
	search_text = search_text[rand(search_text.size-1)]
	image_search =  search_text.gsub(/[^a-zA-Z0-9]/, "+")
	image = grab_image(image_search)
	image == "" ?  coition(url) : [image, search_text] 
end

def poetry(form, words)
	tagger = EngTagger.new
	form = tagger.add_tags(form.gsub("Share this page : ", "")).split(" ")
	tagged_words = tagger.add_tags(words).split(" ")

	form.each_index do |index| 
	form_size = /<.+?>/.match(form[index]).to_s.length
             if form[index].match(/<br>/).to_s == "<br>" 
             	form[index] = form[index] 
             else
             tagged_words.shuffle.each do |word|
             	word_size = /<.+?>/.match(word).to_s.length
				form[index] = word.downcase if /<.+?>/.match(form[index]).to_s == /<.+?>/.match(word).to_s && form[index].length == word.length
				end
			end
		end

form.join(" ")

end

def letter_to_editor(text_1, text_2="")
	text_1_array = text_1.split(".").shuffle
	text_2_array = text_2[0..text_1.size].split(".").shuffle
	
	slice_1 = text_1_array.map do|phrase| 
			phrase = phrase.split(" ")
			phrase[0..-6].join(" ")
		end
	
	slice_2 = text_2_array.map do |phrase| 
			phrase = phrase.split(" ")
			phrase = phrase[phrase.size/rand(2..10)..-1].join(" ")
		end
	slice_1.each_index{|index| slice_1[index] << " #{slice_2[index]}" }

	slice_1[0..(slice_1.size)/2].join(". ")
end
end