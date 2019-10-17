##Simple Hangman Game. 

#create array for words
word_list = []
guessed_letters = []
text_file = "words.txt"

#read dictionary file and add words to array
File.readlines(text_file).map{|line| line[0..-2]}.each do |word|
    word_list << word if word.length <=15 && word.length >=4
end

target_word = word_list.sample.downcase
misses_left = 6

#define method for displaying #incorrect guesses
def draw_misses(num)
    
    output ="Guesses: "+ ("[X]"*(6-num))+("[_]"*num)
    
end

puts misses_left

until misses_left <= 0 do 
    puts
    puts "enter a guess:"
    input = gets.downcase.chomp[0]
    puts
    guessed_letters << input
    display_word = ""
    target_word.chars.each do |ch|
        if guessed_letters.include? ch 
            display_word += ch
            wrong = false
        else
            display_word += "_"
        end
    end
    puts display_word
    break if !display_word.include? "_"
    misses_left -= 1 if !target_word.include? input 
    puts draw_misses(misses_left)
end

if misses_left <= 0
    puts "you lost. The word was: #{target_word}"
else
    puts "you win!"
end