module ApplicationHelper

	# Check if the current controller is an Admin
	# namespaced controller
	def admin_section?
		controller.class.name.split("::").first == "Admin"
	end
end
