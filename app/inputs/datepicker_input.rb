class DatepickerInput < SimpleForm::Inputs::Base
#####
# Get the righ date format for input date workout/bodylogs
####
 def input
    @builder.text_field(attribute_name, input_html_options) + \
    @builder.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt"}) 
  end
end