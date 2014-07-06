# coding: utf-8

module LoginMacros

  def login(user)
    visit root_path
    click_link '登录'
    fill_in '邮箱', :with=>user.email
    fill_in '密码', :with=>user.password
    click_button '登录'
  end

end
