platform :ios, '12.0'

inhibit_all_warnings!
use_frameworks!

target 'ConcreteChallenge' do

  # Pods for ConcreteChallenge
  pod 'SnapKit', '~> 5.0.0'
  pod 'Kingfisher', '~> 5.11'

  target 'ConcreteChallengeTests' do
    inherit! :complete
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'KIF', :configurations => ['Debug']
  end

  target 'ConcreteChallengeUITests' do
    # Pods for testing
    inherit! :complete
    pod 'Quick'
    pod 'Nimble'
  end

end
