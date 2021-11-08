=begin
Allows to align the text to the right side of the window by using \R[1] code.
Use \R[0] code to reset the alignment.
LP: 1
=end

class Window_Base < Window
	# Constructor.
	alias :ra_initialize :initialize
	def initialize(x, y, width, height)
		ra_initialize(x, y, width, height)
		@right_align = false
		@right_aligned_text = ""
	end
	
	# Processes the code characters.
	alias :ra_process_escape_character :process_escape_character
	def process_escape_character(code, text, pos)
		if (code.upcase == "R")
			@right_align = (obtain_escape_param(text) == 1)
			return
		end
		ra_process_escape_character(code, text, pos)
	end
	
	# Processes normal characters.
	alias :ra_process_character :process_character
	def process_character(c, text, pos)
		if (@right_align)
			@right_aligned_position = pos if (@right_aligned_text.empty?)
			@right_aligned_text += c
			return
		end
		ra_process_character(c, text, pos)
	end
	
	# Draws the text.
	alias :ra_draw_text_ex :draw_text_ex
	def draw_text_ex(x, y, text)
		ra_draw_text_ex(x, y, text)
		@right_align = false
		if (!@right_aligned_text.empty?)
			text = @right_aligned_text
			@right_aligned_text = ""
			width_plus = text_size_ex(text).width
			if (!@right_align_width_fix)
				@right_align_width_fix = true
				old_contents = contents.dup
				self.width += width_plus
				create_contents
				contents.blt(0, 0, old_contents, old_contents.rect)
				old_contents.dispose
			end
			draw_text_ex(contents_width - width_plus, @right_aligned_position[:y], text)
		end
	end
end