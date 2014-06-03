#encoding: utf-8
require "spec_helper"
describe User do
  before {

    @user = User.new({user_name: "name_test",
                      user_email: "test@qq.com",
                      password: "123456",
                      password_conformation: "123456"}) }
  describe "test for attributes" do
    subject { @user }
    it { should respond_to (:user_name) }
    it { should respond_to (:user_email) }
    it { should respond_to (:password) }
    it { should respond_to (:password_conformation) }
    it { should respond_to (:salt) }
    it { should respond_to (:encrypted_password) }

    it { should respond_to (:user_name) }
    it { should respond_to (:user_email) }
    it { should respond_to (:password) }
    it { should respond_to (:password_conformation) }
    it { should respond_to (:salt) }
    it { should respond_to (:encrypted_password) }
    it { should be_valid }

    describe "when name is not valid" do
      before { @user.user_name = "" }
      it { should_not be_valid }
    end
    describe "when name is not unique" do
      before { @user2 = User.new({user_name: "name_test",
                                  user_email: "test2@qq.com",
                                  password: "123456",
                                  password_conformation: "123456"})
      @user2.save
      @user.save
      }
      it { should_not be_valid }
    end

    describe "when email is not valid" do
      before { @user.user_email = "" }
      it { should_not be_valid }
    end
    describe "when emain is not unique" do
      before do
        @user2 = User.new({user_name: "name_test2",
                           user_email: "test@qq.com",
                           password: "123456",
                           password_conformation: "123456"})
        @user2.save
        @user.save
      end
      it { should_not be_valid }
    end
    describe "when email format is not valid" do
      before do
        @user.user_email = "345"
        @user.save
      end
      it { should_not be_valid }
    end

    describe "when password and password_confirmation" do
      before do
        @user.password = "123456"
        @user.password_conformation = "456789"
        @user.save
      end
      it { should_not be_valid }
    end

    describe "when password is blank" do
      before do
        @user.password = ""
        @user.password_conformation = ""
        @user.save
      end
      it { should_not be_valid }
    end

  end

  describe "Test for methods of User model" do

    describe "destroy_user_by_ids" do
      describe "user_ids is blank" do
        it "should return blank and success" do
          status, message = User.destroy_user_by_ids([])
          status.should == "success"
          message.should == []
        end
      end
      describe "user_ids is not existing" do
        it "should return error message and error" do
          status, message = User.destroy_user_by_ids([9999])
          status.should == "error"
          message.should == ["'9999' does not existing!"]
        end
      end

      describe "user_ids is existing" do
        it "should return error message and error" do
          User.delete_all
          user = User.new({user_name: "name_test2",
                             user_email: "test@qq.com",
                             password: "123456",
                             password_conformation: "123456"})
          user.save
          status, message = User.destroy_user_by_ids([user._id.to_s])
          status.should == "success"
          message.should == ["Delete user success, name=#{user.user_name}"]
        end
      end
    end
    describe "get_user_list" do
      describe "users db table is blank" do
        it "should return []" do
          User.delete_all
          result = User.get_user_list
          result.should == []
        end

        it "should return data" do
          User.delete_all
          user = User.new({user_name: "name_test2",
                           user_email: "test@qq.com",
                           password: "123456",
                           password_conformation: "123456"})
          user.save
          result = User.get_user_list
          result.length.should == 1
          result[0].length.should == 2
        end
      end
    end

  end

end