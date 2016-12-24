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
        { party: leberal_democratic, total: 6, percent: 30 },
        { party: communist, total: 10, percent: 50 },
      ]
    }
    it { is_expected.to contain_exactly(*expectation) }
  end
end
