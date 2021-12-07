=begin
Makes "Universal Requiem" change description on use.

LP: 1
=end

class Game_Battler < Game_BattlerBase
	# Invokes a skill or uses an item.
	alias :sdc_use_item :use_item
	def use_item(item)
		sdc_use_item(item)
		item.on_use if (item.respond_to?(:on_use))
	end
end

module DataManager
	class << self
		# Constructor.
		alias :sdc_init :init
		def init
			sdc_init
			class << $data_skills[936]
				# Constants.
				VERSES = [
					"I pray amidst despair, standing in God's love and justice...\nFor those who could not stand for themselves.",
					"Let us pause to remember those who have lost their lives,\nwho died along the way—never having seen the Promised Land.",
					"As we pause to remember the worlds who are left to mourn,\nmay our mourning join with theirs; and may you comfort us, oh God.",
					"In your mercy, hear our prayer.\nAmen."
				]
				
				# Description getter.
				def description
					@verse_index ||= 0
					return VERSES[@verse_index]
				end
				
				# Called on skill invocation / item usage.
				def on_use
					@verse_index = [@verse_index + 1, VERSES.count - 1].min
				end
			end
		end
	end
end