require 'spec_helper'

describe Deckorator do
  it 'has a version number' do
    expect(Deckorator::VERSION).not_to be nil
  end

  describe '.decorate' do
    context 'object is nil' do
      it { expect(Deckorator.decorate(nil)).to be_nil }
    end
    context 'object is plain ruby' do
      let(:post) { Post.new('Testing 1 2 3') }
      it { expect(Deckorator.decorate(post)).to be_a PostDeckorator }
    end
    context 'object has decorator_class class method' do
      let(:comment) { Comment.new('Haters gonna hate.') }
      it { expect(Deckorator.decorate(comment)).to be_a CommentDecorator }
    end
    context 'object has decorator_class instance method' do
      let(:user) { User.new('bravely') }
      it { expect(Deckorator.decorate(user)).to be_a UserDecorator }
    end
    context 'object is an ActiveRecord object' do
      let(:blog) { Blog.new('Noah Caldwell-Gervais') }
      it { expect(Deckorator.decorate(blog)).to be_a BlogDeckorator }
    end
  end
end
