module ApplicationHelper
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def remove_params(filter)
    params.delete_if {|key, value| key == filter} if filter 
  end
end
