require 'json'


#name of text file used for dictionary
text_file = "words.txt"


class Hangman
    attr_accessor :target_word
    def initialize(txt = text_file)
        @chances_left = 6 
        @guessed_letters = []
        @word_list = create_word_list(txt)
        @target_word = @word_list.sample.downcase
        @display_word = display_word()
        @current_input = "@"
        puts "### Welcome to Hangman! ###"
        puts "---------------------------\n"
        puts "Load saved game? y/n"
        if gets.chomp == 'y'
            load_game(gets.chomp)
            puts "loading game..."
        end
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
            puts "\nEnter a guess (or enter 5 to save game):"
            play()
        end
    end

    def play()
        if get_input() == '5'
            save_game()
            puts "Enter a guess: "
            get_input()
        end

        @guessed_letters << @current_input

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

    def save_game()
        save = JSON.dump({
            :chances_left    => @chances_left,
            :guessed_letters => @guessed_letters,
            :target_word     => @target_word,
            :display_word    => @display_word,
            :current_input   => @current_input
        })
        puts "\"enter file_name\".json"
        save_file = gets.chomp
        File.open(save_file,"w"){|file| file.puts save}
        puts "~ game saved! ~"
    end

    def load_game(save_file)
        data = JSON.load File.read(save_file)
        @chances_left = data["chances_left"]
        @guessed_letters = data["guessed_letters"]
        @target_word = data["target_word"]
        @display_word = data["display_word"]
        @current_input = data["current_input"]
        puts "~ game loaded! ~"
        #code for loading game. gotta unserialize.
        
    end



end

    game = Hangman.new(text_file)


game.play()
