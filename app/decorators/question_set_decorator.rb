class QuestionSetDecorator < Draper::Decorator
  delegate_all

  def toggle_status
    visible? ? 'invisible' : 'visible'
  end

  def status_text
    visible? ? '公開' : '非公開'
  end

  def selected_choice_tags(position, choice)
    if position == choice
      h.content_tag(
        :div, I18n.t("activerecord.attributes.question_score.#{choice}"),
        class: "question-#{choice} question-choices question-#{choice}-click"
      )
    else
      h.content_tag(
        :div, I18n.t("activerecord.attributes.question_score.#{position}"),
        class: "question-#{position} question-choices"
      )
    end
  end
end
