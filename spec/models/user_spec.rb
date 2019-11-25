require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid name, email, and valid password" do
    user = User.new(
      name: "テスト用保育士さん",
      email: "test-user@example.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)

    user.valid?

    expect(user.errors[:name]).to include ("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)

    user.valid?

    expect(user.errors[:email]).to include ("can't be blank")
  end

  it "is invalid with an invalid email" do
    user = User.new(email: "foo")

    user.valid?

    expect(user.errors[:email]).to include ("is invalid")
  end

  it "is invalid with a duplicate email" do
    User.create(
      name: "test1",
      email: "test@example.com",
      password: "hogehoge",
      password_confirmation: "hogehoge"
    )
    
    user = User.new(
      name: "test2",
      email: "test@example.com",
      password: "foobarbaz",
      password_confirmation: "foobarbaz"
    )

    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with too short password" do
    user = User.new(password: "foo", password_confirmation: "foo")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "is invalid with too long password" do
    user = User.new(password: "a"*33, password_confirmation: "a"*33)
    user.valid?
    expect(user.errors[:password]).to include("is too long (maximum is 32 characters)")
  end

  it "is invalid with password_confirmation differ from password" do
    user = User.new(password: "hogehoge", password_confirmation: "hogehugo")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

end
