require 'rails_helper'

describe 'topics/show.html.erb' do
  it "shows the topic's name" do
    assign(:topic, build(:topic, name: 'The Name'))
    assign(:notices, [])

    render

    expect(rendered).to include('The Name')
  end

  it "shows the topic's html description" do
    topic = build(:topic, description: 'Some *markdown*')
    assign(:topic, topic)
    assign(:notices, [])

    render

    expect(rendered).to include(topic.description_html)
  end

  it "shows the topic's relevant questions" do
    questions = build_list(:relevant_question, 3)
    assign(:topic, build(:topic, relevant_questions: questions))
    assign(:notices, [])

    render

    questions.each do |question|
      expect(rendered).to include(question.question)
      expect(rendered).to include(question.answer_html)
    end
  end
end
