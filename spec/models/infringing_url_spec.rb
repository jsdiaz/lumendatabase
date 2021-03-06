require 'spec_helper'

describe InfringingUrl, type: :model do
  it { is_expected.not_to have_db_index(:url).unique(true) }
  it { is_expected.to have_db_index(:url_original).unique(true) }

  context 'automatic validations' do
    it { is_expected.to validate_presence_of(:url_original) }
    it { is_expected.to validate_length_of(:url).is_at_most(8.kilobytes) }
    it { is_expected.to validate_length_of(:url_original).is_at_most(8.kilobytes) }
  end

  context "#url" do
    it_behaves_like 'an object with a url'
  end

  context "#url_original" do
    it_behaves_like 'an object with a url'
  end

  context "performance" do
    it "runs method in less than specified time" do
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      InfringingUrl.get_approximate_count
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      expect(end_time - start_time).to be <= 1.0
    end
  end
end
