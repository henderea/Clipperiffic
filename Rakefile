# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue
  system('bundle install')
  exit
end

SKIP_CODESIGN_TIMESTAMP = true

module Motion::Project
  class Builder
    def codesign(config, platform)
      app_bundle   = config.app_bundle_raw('MacOSX')
      entitlements = File.join(config.versionized_build_dir(platform), 'Entitlements.plist')
      if File.mtime(config.project_file) > File.mtime(app_bundle) or !system("/usr/bin/codesign --verify \"#{app_bundle}\" >& /dev/null")
        App.info 'Codesign', app_bundle
        File.open(entitlements, 'w') { |io| io.write(config.entitlements_data) }
        sh "/usr/bin/codesign --deep --force --sign \"#{config.codesign_certificate}\"#{SKIP_CODESIGN_TIMESTAMP ? ' --timestamp=none' : ''} --entitlements \"#{entitlements}\" \"#{app_bundle}\""
      end
    end
  end
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  # app.icon                           = 'Icon.icns'
  # app.info_plist['CFBundleIconFile'] = 'Icon.icns'
  app.name                      = 'Clipperiffic'
  app.version                   = '0.1'
  app.short_version             = '0.1'
  app.identifier                = 'com.clipperiffic.Clipperiffic'
  app.info_plist['NSUIElement'] = 1
  # app.info_plist['SUFeedURL']   = 'https://rink.hockeyapp.net/api/2/apps/128ebd3240db358d4b1ea5f228269de6'
  app.deployment_target         = '10.7'
  app.codesign_certificate      = 'Developer ID Application: Eric Henderson (SKWXXEM822)'
  app.paddle {
    # set :product_id, '993'
    set :vendor_id, '1657'
    # set :api_key, 'ff308e08f807298d8a76a7a3db1ee12b'
    # set :current_price, '2.49'
    set :dev_name, 'Eric Henderson'
    set :currency, 'USD'
    # set :image, 'https://raw.githubusercontent.com/henderea/MemoryTamer/master/resources/Icon.png'
    set :product_name, 'MemoryTamer'
    # set :trial_duration, '7'
    # set :trial_text, 'Thanks for downloading a trial of MemoryTamer! I hope you enjoy it.'
    # set :product_image, 'Icon.png'
    set :time_trial, false
  }
  app.embedded_frameworks << 'vendor/Growl.framework'
  app.embedded_frameworks << 'vendor/Paddle.framework'

  app.pods do
    pod 'CocoaLumberjack'
    pod 'HockeySDK-Mac', '~> 2.1'
    pod 'Sparkle'
    pod 'MASShortcut'
  end
end
