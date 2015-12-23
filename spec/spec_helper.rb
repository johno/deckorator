$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'deckorator'
require 'active_support'
require 'active_support/core_ext'
require 'active_model/naming'

class FakeModel
  def name
    'Fred Flinstone'
  end
end

class FakeModelDecorator
  include Deckorator::Delegator

  attr_accessor :decorated_object

  def initialize(object)
    @decorated_object = object
  end

  def yelling_name
    "#{name.upcase}!!!"
  end
end

class FakeController
  include Deckorator

  def show
    @fake_model = FakeModel.new
    @fake_model = decorate(@fake_model)
  end
end

class Post < Struct.new(:text); end
class PostDeckorator < Struct.new(:post)
  def display_text; "Bang! #{post.text}"; end
end

class Comment < Struct.new(:text)
  def self.decorator_class
    CommentDecorator
  end
end
class CommentDecorator < Struct.new(:comment); end

class User < Struct.new(:username)
  def decorator_class
    UserDecorator
  end
end
class UserDecorator < Struct.new(:user); end

class Blog < Struct.new(:title)
  extend ActiveModel::Naming
  def self.to_s
    nil
  end
end
class BlogDeckorator < Struct.new(:blog); end
