helpers do

def page_sections
	#lays out page section links randomly on front page
	links = {"M0dern th0ughts"=>"/two", "aRt"=>"/three", "Poetry"=>"/four", "soUnd"=>"/five", "inTerview"=>"/six", "coition"=>"/eight"}
	 alignments = ["left", "right", "center"]

    Hash[links.to_a.sample(links.length)].map{|k,v| "<p style='text-align:#{alignments[rand(3)]}'><a class='two' href=#{v}>#{k}</a></p>"}
end


def page_sections_drop
	#lays out page section links randomly on front page
	links = {"M0dern th0ughts"=>"/two", "aRt"=>"/three", "Poetry"=>"/four", "sounD"=>"/five", "inTerview"=>"/six", "coition"=>"/eight", "coVER"=>"/"}
	 alignments = ["left", "right", "center"]

 menu= "<nav> <ul><li><a href='#'' class='two'>links</a><ul>"
 Hash[links.to_a.sample(links.length)].map{|k,v| menu << "<li style='text-align:#{alignments[rand(3)]}'><a class='two' href=#{v}>#{k}</a></li>"}  
 menu << "</ul></li></ul></nav>"
end

def url_tracker
	session["urls"] == nil ? session["urls"] = [request.env['HTTP_REFERER']] : session["urls"]<< request.env['HTTP_REFERER']
	params[:key] == nil ? source = "#{session['urls'][-1]}?key=#{session['urls'].size-2}" : source = "#{session['urls'][params[:key].to_i]}?key=#{params[:key].to_i-1}"
	"<iframe id='back' src=#{source}></iframe>" if params[:key] !=0
end

end