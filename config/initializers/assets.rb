# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
#
# Rails.application.config.assets.paths << Rails.root.join("app", "assets", "node_modules", "leaflet-routing-machine", "dist")
# Rails.application.config.assets.paths << Rails.root.join("app", "assets", "node_modules", "leaflet-routing-machine", "css")

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( leaflet.js )
Rails.application.config.assets.precompile += %w( leaflet.css )

Rails.application.config.assets.precompile += %w( leaflet-routing-machine.js )
Rails.application.config.assets.precompile += %w( leaflet-routing-machine.css )
Rails.application.config.assets.precompile += %w( Control.Geocoder.js )
