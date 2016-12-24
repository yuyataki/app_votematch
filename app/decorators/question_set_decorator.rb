class QuestionSetDecorator < Draper::Decorator
  delegate_all

  def toggle_status
    visible? ? 'invisible' : 'visible'
  end

  def status_text
    visible? ? '公開' : '非公開'
  end
end
