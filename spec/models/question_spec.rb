require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    before { question.valid? }
    subject { question }

    describe '#check_parties_count' do
      context 'when scores count is zero' do
        let(:question) { build(:question).tap { |question| question.scores = [] } }

        let(:expectation) { ['政党数は2つ以上にしてください'] }
        its('errors.full_messages') { is_expected.to contain_exactly(*expectation) }
      end

      context 'when scores count is one' do
        let(:question) {
          build(:question).tap do |question|
            question.scores = []
            question.scores << build(:question_score, :leberal_democratic, question: question)
          end
        }

        let(:expectation) { ['政党数は2つ以上にしてください'] }
        its('errors.full_messages') { is_expected.to contain_exactly(*expectation) }
      end

      context 'when scores count is two' do
        let(:question) { build(:question) }

        it { is_expected.to be_valid }
      end
    end

    describe '#check_question_and_party' do
      context 'when scores count is duplicate' do
        let(:question) { build(:question).tap { |q| q.scores << q.scores.first } }

        let(:expectation) { ['政党は重複できません'] }
        its('errors.full_messages') { is_expected.to contain_exactly(*expectation) }
      end
    end
  end
end
