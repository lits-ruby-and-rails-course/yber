module MessagesHelper
	def find_user (id) 
		user = User.find(id)
	end

	def sender?(id)
		Message.find(id).from_id == current_user.id ? true : false
	end

	def count_messages(id)
		Message.where(from_id: current_user.id, to_id: id).count + Message.where(to_id: current_user.id, from_id: id).count
	end

	def count_sent_messages(id)
		(Message.where(from_id: current_user.id, to_id: id)).count
	end

	def count_incoming_messages(id)
		Message.where(to_id: current_user.id, from_id: id).count
	end	
end
