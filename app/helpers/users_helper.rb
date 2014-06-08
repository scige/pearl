module UsersHelper
  def generate_all_identity
    [
      [Setting.users.identity_admin_string, Setting.users.identity_admin],
      [Setting.users.identity_teacher_string, Setting.users.identity_teacher],
      [Setting.users.identity_student_string, Setting.users.identity_student]
    ]
  end
end
