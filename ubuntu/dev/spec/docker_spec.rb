require 'rake'
require 'spec_helper'

describe 'Docker image' do
  before :all do
    Rake::Task['ubuntu_dev:build'].invoke
    @image = Docker::Image::get 'rucker/ubuntu-dev:latest'
    set :os, family: :debian
    set :backend, :docker
    set :docker_container, 'test_container'
    @container = Docker::Container.create(
      'Image' => @image.id,
      'name' => 'test_container',
      'Cmd' => ['sleep','1']
    )
    @container.start
  end

  after :all do
    @container.stop
    @container.remove
  end

  user=`whoami`.strip
  describe command "id -u #{user}" do
    its(:exit_status) { should eq 0 }
  end
end
