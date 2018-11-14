require 'rake'
require 'spec_helper'

describe 'Docker image' do
  before :all do
    @image = Docker::Image::get 'rucker/ubuntu-baseimage:latest'
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

  describe command 'cat /etc/lsb-release'  do
    its(:stdout) { should include 'Ubuntu 18' }
  end

  describe command 'locale -a' do
    its(:stdout) { should include 'en_US.utf8' }
  end
end
