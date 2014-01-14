class ContactFormsController < ApplicationController

  def new
    @contact_form = ContactForm.new
  end

  def create
    begin
      @contact_form = ContactForm.new(secure_params)
      @contact_form.request = request
      if @contact_form.deliver
        flash.now[:notice] = 'Thank you for your message!'
      else
        render :new
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end


  private

  def secure_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end
