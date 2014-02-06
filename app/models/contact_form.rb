class ContactForm < MailForm::Base

	attribute :name, :validate => true
	attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
	attribute :message

	#####
	# Header for gmail mail delivery from the contact form.
	#####
	def headers
		{
			:subject => "My Contact Form",
			:to => 'krelandeweer@gmail.com',
			:from => %("#{name}" <#{email}>)
		}
	end
end
