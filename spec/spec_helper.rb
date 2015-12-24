$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'deckorator'
require 'active_support'
require 'active_support/core_ext'
require 'active_model/naming'

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
end

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

class FakeModelWithAssociation
  def fake
    FakeModel.new
  end
end

class FakeModelWithAssociationDecorator
  include Deckorator
  include Deckorator::Delegator
  include Deckorator::Association

  attr_accessor :decorated_object
  decorate_association :fake

  def initialize(object)
    @decorated_object = object
    deckorator_define_association_methods
  end

  def fake
    FakeModel.new
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
class PostDecorator < Struct.new(:post)
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
    AwesomeUserDecorator
  end
end
class AwesomeUserDecorator < Struct.new(:user); end

class Blog < Struct.new(:title)
  extend ActiveModel::Naming
  def self.to_s
    nil
  end
end
class BlogDecorator < Struct.new(:blog); end
