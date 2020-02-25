# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_enumerize_name(enum_name, enum_value)
    I18n.t("enumerize.#{model_name.i18n_key}.#{enum_name.to_s}.#{enum_value}")
  end
end
