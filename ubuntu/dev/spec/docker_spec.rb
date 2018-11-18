require 'rake'
require 'spec_helper'

describe 'Docker image' do
  before :all do
    begin
      image_name = 'rucker/ubuntu-dev:latest'
      @image = Docker::Image::get image_name
    rescue
      #FIXME: Build baseimage from dev image Rakefile
      Rake::Task['ubuntu_dev:build'].reenable
      Rake::Task['ubuntu_dev:build'].invoke(:buildargs => { 'user' => @user })
      @image = Docker::Image::get image_name
    end
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
