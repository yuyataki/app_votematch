require 'rails_helper'

RSpec.describe QuestionSet, type: :model do
  describe '#result' do
    let!(:question_set) { create(:question_set) }
    let!(:question1) { create(:question, question_sets: [question_set]) }
    let!(:question2) { create(:question, question_sets: [question_set]) }
    let(:leberal_democratic) { create(:party, :leberal_democratic) }
    let(:communist) { create(:party, :communist) }

    before do
      question1.scores.find_by(party: leberal_democratic)
               .update!(agree: 2, neutral: 3, opposition: 5)
      question1.scores.find_by(party: communist).update!(agree: 6, neutral: 3, opposition: 1)
    end

    let(:choice_params) { { question1.id => 'agree', question2.id => 'opposition' }.stringify_keys }
    subject { question_set.results(choice_params) }

    let(:expectation) {
      [
        { party: leberal_democratic, total: 6, percentage: 30 },
        { party: communist, total: 10, percentage: 50 },
      ]
    }
    it { is_expected.to contain_exactly(*expectation) }
  end

  describe '#create_question_set_history' do
    context 'when no questions' do
      let(:question_set) { create(:question_set) }
      it { expect { question_set }.not_to change { question_set.histories.count } }
    end

    context 'when make question_set visible' do
      let(:question_set) { create(:question_set, :with_question) }
      it { expect { question_set.visible! }.to change { question_set.histories.count }.by(1) }
    end

    context 'when visible' do
      context 'when title is changed' do
        let(:question_set) { create(:question_set, :with_question) }
        before { question_set.visible! }

        let(:title) { 'title changed' }
        let(:edit_title) { question_set.update!(title: title) }

        it 'question_set_history is created' do
          expect { edit_title }.to change { question_set.histories.count }.by(1)
        end

        it 'title of question_set_history is changed' do
          expect { edit_title }.to change {
            question_set.histories.latest.title
          }.from('20XX年衆議院選挙!あなたの選択は?!').to(title)
        end
      end

      context 'when title is not changed' do
        let(:question_set) { create(:question_set, :with_question) }
        before { question_set.visible! }

        let(:title) { '20XX年衆議院選挙!あなたの選択は?!' }
        let(:edit_title) { question_set.update!(title: title) }

        it 'question_set_history is not created' do
          expect { edit_title }.not_to change { question_set.histories.count }
        end
      end

      context 'when question is added' do
        # This case is described in mypage/questions_controller_spec
      end
    end
  end
end
