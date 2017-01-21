class UserDecorator < Draper::Decorator
  delegate_all

  def displayable_nickname
    nickname || id
  end
end
