class ReviewMatchOperation < ApplicationOperation
  task(:match)

  schema(:match) do
    field(:account, :type => Account)
    field(:review, :type => Review)
  end
  def match(state:)
    state.review.critiques.reduce(0) do |score, critique|
      desire = state.account.desires.find_by!(question: critique.answer.question)

      modifier = case desire.impact
      when :low then 1
      when :medium then 2
      when :high then 3
      else raise(UnknownReviewMatchImpactException)
      end


      operator = if critique.answer == desire.answer
        :+
      else
        :-
      end

      score.public_send(operator, modifier)
    end
  end
end
