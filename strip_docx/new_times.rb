regular = [] 
ARGV.each {|e| regular << e.to_i}

def new_times(regular)
	double = regular *2
	timeandhalf = regular * 1.5
	puts "Regular time is #{regular} seconds, #{regular/60} minutes"
	puts "Double time is #{double} seconds, #{double/60} minutes"
	puts "Time and a half is #{timeandhalf} seconds, #{timeandhalf/60} minutes"
	puts 
end

regular.each {|e| new_times(e)}