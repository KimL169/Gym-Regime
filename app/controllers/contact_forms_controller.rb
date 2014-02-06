class ContactFormsController < ApplicationController

  #########
  # Initialize a new contact form
  #######
  def new
    @contact_form = ContactForm.new
  end

  ############
  # Create the contact form if submitted.
  ###########
  def create 
    begin
      @contact_form = ContactForm.new(secure_params)
      @contact_form.request = request 
      if @contact_form.deliver
        flash.now[:notice] = 'Thank you for your message!'
      else
        render :new
      end
    rescue ScriptError #make sure spammers don't get through
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end


  private
  ########
  # Secure contact form parameters
  ########
  def secure_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end
