module ApplicationHelper
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def remove_filter(attribute)
    temp_params = params.dup
    temp_params.delete_if {|key, value| key == attribute} 
  end
end
