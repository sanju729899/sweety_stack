require 'rails_helper'

describe 'Sign in required to use app' do

  it 'should see home page' do
    visit(root_path)
    expect(page).to have_current_path("/users/sign_in")
  end

  it 'should not see readings until signed in' do
    visit(readings_path)
    expect(page).to have_current_path(new_user_session_path)
  end

  it 'should not see reports until signed in' do
    visit(reports_path)
    expect(page).to have_current_path(new_user_session_path)
  end

  describe 'signing in' do
    let(:user) { User.new(email: 'test@y.com', password: 'test1234') }

    it 'logging in unlocks access to readings page' do
      login_as user, scope: :user
      visit(readings_path)
      expect(page).to have_current_path(readings_path)
    end

    it 'logging in unlocks access to reports page' do
      login_as user, scope: :user
      visit(readings_path)
      expect(page).to have_current_path(readings_path)
    end
  end
end
