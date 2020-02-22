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
      (light_themes + dark_themes).each_slice(17).with_index do |names, index|
        names.each do |name|
          creating_theme(Theme.appearance.values[index], name)
        end
      end
    end

    def light_themes
      %w[
        atmosphere ice countryside morning scooter air autumn-forest bird city coloured-feathers desert
        sunset greenfield tulips grass cloud-sea pink-fencer grass-ears paradise valentines-hearts
        jack-o-lantern halloween christmas-snow christmas-gift christmas-ball new-years-room easter-eggs
        wall flower metro shining stars clouds canyon valley leafs wind tree red-field trees
        feathers flower-and-leafs high-grass hills horses lake lava lion-cubs mountain lotus
        village mountains beach sea-sunset snow-village meditation architecture skyscraper
        mountain-air offices perspective plants sea slope steel-wall winter-forest winter-night camouflage
      ]
    end

    def dark_themes
      %w[
        coloured-paper dew fabric flamingo starfish sea-stones seashells easter-eggs pattern-tulips
        table vibration window wooden-letters flowers freshness fur light-fabric
      ]
    end

    def creating_theme(mode, name)
      next_position = (Theme.maximum(:position) || 0) + 1
      theme = Theme.new(name: name.titleize, appearance: mode.to_sym, position: next_position)
      File.open(file_path(mode, name)) { |f| theme.image = f }
      theme.save!
    end

    def file_path(mode, name)
      File.join(Rails.root, 'spec', 'factories', 'images', (mode == :dark ? mode.to_s : 'light'), "#{name}.jpg")
    end
  end
end
