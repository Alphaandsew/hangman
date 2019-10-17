


#name of text file used for dictionary
text_file = "words.txt"


class Hangman
    attr_accessor :target_word
    def initialize(txt)
        @chances_left = 6 
        @guessed_letters = []
        @word_list = create_word_list(txt)
        @target_word = @word_list.sample.downcase
        @display_word = display_word()
        @current_input = "@"
        puts "### Welcome to Hangman! ###"
        puts "---------------------------\n"
        puts @display_word
    end

    
    def create_word_list(text_file)
        list = []
        File.readlines(text_file).map{|line| line[0..-2]}.each do |word|
        list << word if word.length <=12 && word.length >=5
        end
        list
    end

    

    def draw_chances(num)
        output = ("[X]"*(6-num))+("[_]"*num)
    end

    def game_over(word,input)
        return "You Win!" if !word.include? "_"
        @chances_left -= 1 if !target_word.include? input

        if @chances_left <= 0
            "you lost. The word was: #{@target_word}"
        else
            puts draw_chances(@chances_left)
            puts "\nEnter a guess:"
            play()
        end
    end

    def play()

        @guessed_letters << get_input()
            
        puts display_word()

        puts game_over(@display_word,@current_input)
            
    end

    def display_word
        @display_word = @target_word.chars.map do |ch|
            if @guessed_letters.include? ch 
                ch 
            else
                "_"
            end
        end
        @display_word = @display_word.join("")
        @display_word
    end

    def get_input()
        @current_input = gets.to_s.downcase.chomp[0] 
        # puts "debug @current_input: #{@current_input}"
        @current_input
    end

end

game = Hangman.new(text_file)
game.play()
