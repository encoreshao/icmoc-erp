# frozen_string_literal: true

require 'open-uri'

namespace :db do
  namespace :themes do
    desc 'Create themes for Project'
    task all: :environment do
      Theme.delete_all
      BuildingTheme.import
      puts "  Total of #{Theme.count} themes."
    end
  end
end

class BuildingTheme
  class << self
    def import
      {
        'light' => light_themes,
        'dark' => dark_themes
      }.each do |key, names|
        names.each do |name|
          creating_theme(key, name)
        end
      end
    end

    def light_themes
      %w[
        sunset greenfield tulips grass cloud-sea pink-fencer grass-ears atmosphere paradise
        village mountains beach sea-sunset snow-village meditation architecture skyscraper
        wall flower metro shining stars clouds canyon valley leafs wind tree red-field trees
        ice countryside morning scooter air autumn-forest bird city coloured-feathers desert
        feathers flower-and-leafs high-grass highness hills horses lake lava lion-cubs mountain
        mountain-air offices perspective plants sea slope steel-wall travel winter-forest winter-night camouflage
        jack-o-lantern halloween christmas-snow christmas-gift christmas-ball new-years-room easter-eggs
        valentines-hearts
      ].shuffle
    end

    def dark_themes
      %w[
        starfish sea-stones seashells easter-eggs lotus coloured-paper dew fabric flamingo
        flowers freshness fur light-fabric table vibration window wooden-letters pattern-tulips
      ].shuffle
    end

    def creating_theme(mode, name)
      next_position = (Theme.maximum(:position) || 0) + 1
      theme = Theme.new(name: name.titleize, appearance: mode.to_sym, position: next_position)
      File.open(file_path(mode, name)) { |f| theme.image = f }
      theme.save!
    end

    def file_path(mode, name)
      File.join(Rails.root, 'spec', 'factories', 'images', mode.to_s, "#{name}.jpg")
    end
  end
end
