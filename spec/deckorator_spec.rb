require 'spec_helper'

describe Deckorator do
  it 'has a version number' do
    expect(Deckorator::VERSION).not_to be nil
  end

  describe '.deckorate' do
    context 'object is nil' do
      it { expect(Deckorator.deckorate(nil)).to be_nil }
    end
    context 'object is plain ruby' do
      let(:post) { Post.new('Testing 1 2 3') }
      it { expect(Deckorator.deckorate(post)).to be_a PostDeckorator }
    end
    context 'object has decorator_class class method' do
      let(:comment) { Comment.new('Haters gonna hate.') }
      it { expect(Deckorator.deckorate(comment)).to be_a CommentDecorator }
    end
    context 'object has decorator_class instance method' do
      let(:user) { User.new('bravely') }
      it { expect(Deckorator.deckorate(user)).to be_a UserDecorator }
    end
    context 'object is an ActiveRecord object' do
      let(:blog) { Blog.new('Noah Caldwell-Gervais') }
      it { expect(Deckorator.deckorate(blog)).to be_a BlogDeckorator }
    end
    context 'object is an array' do
      let(:obj_array) { [Post.new('First!'), Comment.new('Scrublord')] }
      it { expect(Deckorator.deckorate(obj_array).first).to be_a PostDeckorator }
      it { expect(Deckorator.deckorate(obj_array).last).to be_a CommentDecorator }
      it { expect(Deckorator.deckorate(obj_array)).to be_a Array }
    end
  end
end
