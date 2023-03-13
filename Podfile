# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

workspace 'Husqvarna.workspace'
project 'Husqvarna.xcodeproj'

def network_pod
  pod 'Network', :path => 'DevPods/Network'
end

def utilities_pod
  pod 'Utilities', :path => 'DevPods/Utilities'
end

def development_pod
  network_pod
  utilities_pod
end

target 'Husqvarna' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  development_pod
end

# Pods for Husqvarna
target 'HusqvarnaTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'HusqvarnaUITests' do
  # Pods for testing
end

target 'Network_Example' do
   use_frameworks!
   project 'DevPods/Network/Example/Network.xcodeproj'
   network_pod
 end

target 'Utilities_Example' do
   use_frameworks!
   project 'DevPods/Utilities/Example/Utilities.xcodeproj'
   network_pod
 end

