require 'rails_helper'

RSpec.feature 'Create QuestionSet', type: :feature do
  include_context 'my page login in feature'
  let(:parties_count) { Party.active(Time.zone.now).count }

  scenario 'Create QuestionSet and Question successfully', :js do
    visit mypage_path

    fill_in 'question_set[title]', with: 'ボートマッチタイトル'
    click_button 'ボートマッチを作成する'

    (parties_count - 2).times do
      expect { find('.j__delete_party', match: :first).trigger('click') }.to change {
        page.all('.j__delete_party').count
      }.by(-1)
    end

    fill_in 'question[title]', with: '質問のタイトル'

    select 1, from: "question_scores_attributes_#{parties_count - 2}_agree"
    select 4, from: "question_scores_attributes_#{parties_count - 2}_neutral"
    select 5, from: "question_scores_attributes_#{parties_count - 2}_opposition"

    select 6, from: "question_scores_attributes_#{parties_count - 1}_agree"
    select 2, from: "question_scores_attributes_#{parties_count - 1}_neutral"
    select 2, from: "question_scores_attributes_#{parties_count - 1}_opposition"

    expect { click_button '追加' }.to change { user.questions.count }.by(1)
    expect(current_path).to eq mypage_question_set_path(user.question_sets.last)
  end

  scenario 'Create QuestionSet successfully but only one party and less than 10 points', js: true do
    visit mypage_path

    fill_in 'question_set[title]', with: 'ボートマッチタイトル'
    click_button 'ボートマッチを作成する'

    (parties_count - 1).times do
      expect { find('.j__delete_party', match: :first).trigger('click') }.to change {
        page.all('.j__delete_party').count
      }.by(-1)
    end

    select 3, from: "question_scores_attributes_#{parties_count - 1}_agree"
    select 3, from: "question_scores_attributes_#{parties_count - 1}_neutral"
    select 3, from: "question_scores_attributes_#{parties_count - 1}_opposition"

    within '.j__alert' do
      expect(page).to have_content 'ポイントの合計は10にしてください。'
    end

    click_button '追加'

    within '.errors' do
      expect(page).to have_content 'ポイントの合計は10ポイントにしてください'
      expect(page).to have_content '質問のタイトルを入力してください'
      expect(page).to have_content '政党数は2つ以上にしてください'
    end
  end

  scenario 'Create QuestionSet unsuccessfully', :js do
    visit mypage_path

    fill_in 'question_set[title]', with: ''
    click_button 'ボートマッチを作成する'

    within '.errors' do
      expect(page).to have_content 'タイトルを入力してください'
    end

    expect(user.question_sets.length).to eq 0
  end
end
