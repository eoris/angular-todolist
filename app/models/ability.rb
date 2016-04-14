class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can [:index, :create, :update, :destroy], Project, user_id: user.id
      can [:create, :update, :destroy], Task, project: { user_id: user.id }
      can [:create, :destroy], Comment, task: { project: { user_id: user.id } }
      can [:create, :destroy], Attachment, comment: { task: { project: { user_id: user.id } } }
    end
  end
end
