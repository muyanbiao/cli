require_relative 'osproject'
require 'xcodeproj'

class OSProject::IOS < OSProject
  # this is a temporary placeholder
  attr_accessor :has_sdk 

  attr_accessor :project 
  attr_accessor :target 
  attr_accessor :nse 
  attr_accessor :os_app_id 
  attr_accessor :lang 
  attr_accessor :target_name

  def initialize(dir, lang, os_app_id)
    @has_sdk = false
    @lang = lang
    @os_app_id = os_app_id
    super(:ios, dir, lang, os_app_id)
  end

  def _add_sdk!
    @has_sdk = true
    _add_onesignal_dependency()
    #Main target setup
    _add_onesignal_framework_to_main_target()
    _add_capabilities_to_main_target()
    _add_app_groups_to_main_target()
    _add_os_init_to_app_target()
    #NSE setup
    _create_nse()
    _add_onesignal_framework_to_nse()
    _add_app_groups_to_nse()
  end

  def has_sdk?
    return self.has_sdk
  end

  def install_onesignal(xcproj_path, target_name, os_app_id)
    # TODO error check too make sure both project and target were found
    @project = Xcodeproj::Project.open(xcproj_path)
    @target = self.project.native_targets.find { |target| target.name == target_name}
    # this can probably be optional
    @os_app_id = os_app_id
    # this can be used to get the entitlements plist
    @target_name = target_name

    add_sdk()
  end

  #Just SPM for now. Can be extended to support Cocoapods
  def _add_onesignal_dependency()
    _add_onesignal_sp_dependency()
  end

  # create new target
  # needs notificationservice files, plists
  # set bundle id, dev team?
  # embed in main app target
  # can be done using xcodeproj
  def _create_nse()
    group = @project.main_group.find_subpath('NotificationExtension', true)
    # This should just be a file we add with the code already in it.
    group.new_reference("NotificationExtension/NotificationService.h")
    assets = group.new_reference("NotificationExtension/NotificationService.m")

    #Create NSE target
    #new_target(type, name, platform, deployment_target = nil, product_group = nil, language = nil) ⇒ PBXNativeTarget
    @nse = self.project.new_target(:app_extension, 'OneSignalNotificationServiceExtension', :ios, "10.0", nil, :objc)
    self.nse.add_file_references([assets])

    #Set Info.plist
    self.build_configuration_list.set_setting('INFOPLIST_FILE', "NotificationExtension/Info.plist")
    #Set bundle id based on @target's bundle id
    self.build_configuration_list.set_setting('PRODUCT_BUNDLE_IDENTIFIER', "")
    #Set dev team based on @target's dev team
    self.build_configuration_list.set_setting('DEVELOPMENT_TEAM', "")
    self.project.save
  end

  # add OneSignalXCFramework Swift Package dependency
  # can use xcoed gem for this
  def _add_onesignal_sp_dependency()
  end

  # add swift package binary to nse target
  # can use xcoed gem for this
  def _add_onesignal_framework_to_nse()
  end 

  # app groups capability
  # use xcodeproj
  def _add_app_groups_to_nse()
  end

  # Code is dependent on language but otherwise a constant
  # Probably should just be a file with code already populated.
  def _add_onesignal_code_to_nse()
  end

  # add swift package binary to main target
  # can use xcoed gem for this
  def _add_onesignal_framework_to_main_target()
  end 

  # push capability in entitlments
  # background capability with remote notifications enabled
  # use xcodeproj
  def _add_capabilities_to_main_target()
  end

  # app groups capability
  # use xcodeproj
  def _add_app_groups_to_main_target()
  end

  # depends on language and app lifecycle (appdelegate vs swiftui)
  def _add_os_init_to_app_target()
  end 

end
