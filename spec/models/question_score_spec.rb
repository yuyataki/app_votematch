require 'rails_helper'

RSpec.describe QuestionScore, type: :model do

  describe 'validations' do
    let(:score) { build(:question_score, points) }

    before { score.valid? }
    subject { score }

    describe '#check_total_score' do
      context 'when total_score is 10' do
        let(:points) { { agree: 2, neutral: 7, opposition: 1 } }
        it { is_expected.to be_valid }
      end
    end

    context 'when total_score is 9' do
      let(:points) { { agree: 2, neutral: 7, opposition: 0 } }

      let(:expectation) { ['ポイントの合計は10ポイントにしてください'] }
      its('errors.full_messages') { is_expected.to contain_exactly(*expectation) }
    end

    context 'when total_score is 11' do
      let(:points) { { agree: 2, neutral: 7, opposition: 2 } }

      let(:expectation) { ['ポイントの合計は10ポイントにしてください'] }
      its('errors.full_messages') { is_expected.to contain_exactly(*expectation) }
    end
  end
end
