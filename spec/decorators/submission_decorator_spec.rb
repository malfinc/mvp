require("rails_helper")

RSpec.describe(SubmissionDecorator) do
  let(:actor) {create(:account)}
  let(:submission) {Submission.new(:id => "#{model.class.name}-#{model.id}", :subject => model)}
  let(:decorator) {described_class.new(submission)}

  context("when the submission is an establishment") do
    let(:model) {build(:establishment)}

    describe("#submitter") do
      subject {decorator.submitter}

      before do
        PaperTrail.request(:whodunnit => actor.email, :controller_info => {:actor_id => actor.id, :group_id => SecureRandom.uuid()}) do
          model.save!
        end
      end

      it("is a AccountDecorator") do
        expect(subject).to(be_a(AccountDecorator))
      end

      it("is the first contributor") do
        expect(subject).to(eq(actor))
      end
    end
  end
end
