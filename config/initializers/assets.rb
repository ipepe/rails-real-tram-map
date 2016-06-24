Rails.application.config.assets.version = '1.4'
Rails.application.config.assets.digest = true
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf .woff2 .png)
Rails.application.config.assets.paths << Rails.root.join('app','assets','fonts/bootstrap-sass-official/assets/fonts/bootstrap')
Rails.application.config.assets.paths << Rails.root.join('app','assets','leaflet/images')

NonStupidDigestAssets.whitelist += [/\.(?i:)(?:svg|eot|woff|ttf|otf|png)$/]