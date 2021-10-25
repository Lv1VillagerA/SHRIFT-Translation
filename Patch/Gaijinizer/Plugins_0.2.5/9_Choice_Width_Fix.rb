=begin
Fixes the choice window width.
LP: 0
=end

class Window_ChoiceList < Window_Command
	# Choice window width.
	def max_choice_width
		$game_message.choices.collect {|s| text_size_ex(s).width}.max
	end
end

class Window_Base < Window
	# Calculates the text size without commands.
	def text_size_ex(text)
		return Rect.new unless (text)
		additional_width = 0
		text = text.gsub(/[\\\e]I\[.+?\]/) do |str|
			additional_width += 16
			""
		end
		text = text.gsub(/[\\\e].\[.+?\]/, "")
			.gsub(/[\\\e]./, "")
			.gsub(/en\(.+?\)/, "")
			.gsub(/if\(.+?\)/, "")
		result = text_size(text)
		result.width += additional_width
		return result
	end
end