require 'spec_helper'

describe Bbcc::PostsController do
  before do
    @posts = 10.times do |i|
      Post.create :description => "Post #{i}"
    end
  end
  describe "#index" do
    it "should return all posts" do
      get(:index).should include(@posts)
    end
  end
end
