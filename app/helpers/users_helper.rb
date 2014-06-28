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
      [Setting.users.grade_master_one_string, Setting.users.grade_master_one],
      [Setting.users.grade_master_two_string, Setting.users.grade_master_two],
      [Setting.users.grade_master_three_string, Setting.users.grade_master_three]
    ]
  end
end
