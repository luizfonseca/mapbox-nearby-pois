module Endpoint
  describe NearbyPointsOfInterest, type: :request do
    let(:params) do
      { lat: 52.5301, lng: 13.41 }
    end

    before { get '/nearby', params }
    subject { last_response.body }

    context 'when valid coordinates' do
      it { expect(subject).to include('data') }
    end

    context 'when coordinates are not present' do
      let(:params) { nil }
      it { expect(subject).to eq JSON.generate(data: {}) }
    end
  end
end
