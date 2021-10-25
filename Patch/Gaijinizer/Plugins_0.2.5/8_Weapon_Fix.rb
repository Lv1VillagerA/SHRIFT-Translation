=begin
Translates the CE 760 weapon names and "Equipped" state.
LP: 0
=end

class Game_Variables
	# Constants.
	MARION_WEAPONS = ["Musket", "Flintlock", "Tetsuhau", "Cannon", "Hand Grenade", "Heirloom Spear"]
	
	# Assigns a variable.
	alias :ex4ce760p_array_assign :[]=
	def []=(index, value)
		value = MARION_WEAPONS[@data[239] - 1] if (index == 240)
		value = " [Equipped]" if ((index >= 252) && (index <= 257) && !value.empty?)
		ex4ce760p_array_assign(index, value)
	end
end