module UsersHelper
  def generate_all_identity
    [
      [Setting.users.identity_admin_string, Setting.users.identity_admin],
      [Setting.users.identity_teacher_string, Setting.users.identity_teacher],
      [Setting.users.identity_student_string, Setting.users.identity_student]
    ]
  end

  def generate_all_user_grades
    [
      [2010, 2010],
      [2011, 2011],
      [2012, 2012],
      [2013, 2013],
      [2014, 2014]
    ]
  end
end
